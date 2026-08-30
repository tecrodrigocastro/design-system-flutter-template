import 'dart:async';
import 'dart:io';

import 'package:dart_mcp/client.dart';
import 'package:mcp_server/src/design_system_mcp_server.dart';
import 'package:path/path.dart' as p;
import 'package:stream_channel/stream_channel.dart';
import 'package:test/test.dart';

/// End-to-end test: spins up a real [DesignSystemMcpServer] and a real
/// [MCPClient] connected over an in-memory duplex channel (no subprocess),
/// then drives the actual MCP protocol — initialize, tools/list, tools/call.
void main() {
  final designSystemRoot =
      p.normalize(p.join(Directory.current.path, '..', 'design_system'));

  late DesignSystemMcpServer server;
  late MCPClient client;
  late ServerConnection connection;

  setUp(() async {
    final clientController = StreamController<String>();
    final serverController = StreamController<String>();
    final clientChannel = StreamChannel<String>.withCloseGuarantee(
      serverController.stream,
      clientController.sink,
    );
    final serverChannel = StreamChannel<String>.withCloseGuarantee(
      clientController.stream,
      serverController.sink,
    );

    server = DesignSystemMcpServer(serverChannel,
        designSystemRoot: designSystemRoot);
    client = MCPClient(Implementation(name: 'test client', version: '0.0.1'));
    connection = client.connectServer(clientChannel);

    await connection.initialize(
      InitializeRequest(
        protocolVersion: ProtocolVersion.latestSupported,
        capabilities: client.capabilities,
        clientInfo: client.implementation,
      ),
    );
    connection.notifyInitialized(InitializedNotification());
    await server.initialized;
  });

  tearDown(() async {
    await client.shutdown();
  });

  test('advertises every catalog tool', () async {
    final tools = await connection.listTools(ListToolsRequest());

    expect(
      tools.tools.map((t) => t.name),
      containsAll([
        'list_components',
        'get_component',
        'list_tokens',
        'get_token',
        'list_enums',
        'get_enum',
        'search_docs',
      ]),
    );
  });

  test('list_components returns every component, grouped by category',
      () async {
    final result =
        await connection.callTool(CallToolRequest(name: 'list_components'));

    expect(result.isError, isNot(true));
    final text = (result.content.single as TextContent).text;
    expect(
        text,
        allOf(contains('DsButton'), contains('atom'), contains('DsAppBar'),
            contains('organism')));
  });

  test('get_component returns the full DsButton schema', () async {
    final result = await connection.callTool(
      CallToolRequest(name: 'get_component', arguments: {'name': 'DsButton'}),
    );

    expect(result.isError, isNot(true));
    final text = (result.content.single as TextContent).text;
    expect(
        text, allOf(contains('DsButtonVariant'), contains('"required":true')));
  });

  test('get_component reports an error for an unknown name', () async {
    final result = await connection.callTool(
      CallToolRequest(name: 'get_component', arguments: {'name': 'DsNope'}),
    );

    expect(result.isError, isTrue);
  });

  test('get_token returns literal token values', () async {
    final result = await connection.callTool(
      CallToolRequest(name: 'get_token', arguments: {'name': 'DsPrimary'}),
    );

    expect(result.isError, isNot(true));
    final text = (result.content.single as TextContent).text;
    expect(text, contains('Color(0xFF782DC8)'));
  });

  test('get_enum returns every value of DsButtonVariant', () async {
    final result = await connection.callTool(
      CallToolRequest(name: 'get_enum', arguments: {'name': 'DsButtonVariant'}),
    );

    expect(result.isError, isNot(true));
    final text = (result.content.single as TextContent).text;
    expect(
        text,
        allOf(contains('primary'), contains('secondary'), contains('outline'),
            contains('ghost')));
  });

  test('search_docs surfaces a helpful error when dartdoc has not run',
      () async {
    // The fresh temp catalog above has no doc/api/index.json unless `dart
    // doc` happens to have been run already; either outcome is valid, but
    // if it's missing we must fail gracefully, not throw.
    final result = await connection.callTool(
      CallToolRequest(name: 'search_docs', arguments: {'query': 'banner'}),
    );

    if (result.isError == true) {
      final text = (result.content.single as TextContent).text;
      expect(text, contains('dart doc'));
    } else {
      final text = (result.content.single as TextContent).text;
      expect(text, contains('DsBanner'));
    }
  });
}

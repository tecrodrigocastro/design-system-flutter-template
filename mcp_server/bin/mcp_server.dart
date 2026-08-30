import 'dart:io' as io;

import 'package:dart_mcp/stdio.dart';
import 'package:mcp_server/src/design_system_mcp_server.dart';
import 'package:path/path.dart' as p;

void main(List<String> args) {
  DesignSystemMcpServer(
    stdioChannel(input: io.stdin, output: io.stdout),
    designSystemRoot: _resolveDesignSystemRoot(args),
  );
}

/// Resolves the design_system package root, checked in this order:
/// 1. `--design-system-root=<path>` CLI argument.
/// 2. `DESIGN_SYSTEM_ROOT` environment variable.
/// 3. `../../design_system` relative to this script (the monorepo default).
String _resolveDesignSystemRoot(List<String> args) {
  const flag = '--design-system-root=';
  for (final arg in args) {
    if (arg.startsWith(flag)) {
      return p.normalize(arg.substring(flag.length));
    }
  }

  final fromEnv = io.Platform.environment['DESIGN_SYSTEM_ROOT'];
  if (fromEnv != null) return p.normalize(fromEnv);

  final scriptDir = p.dirname(io.Platform.script.toFilePath());
  return p.normalize(p.join(scriptDir, '..', '..', 'design_system'));
}

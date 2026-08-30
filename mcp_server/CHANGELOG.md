## 0.1.0

- Initial MCP server: `list_components`, `get_component`, `list_tokens`, `get_token`, `list_enums`, `get_enum`, `search_docs`.
- Component/token/enum catalog is parsed live from `design_system/lib` via `package:analyzer`; `search_docs` reads the `dart doc`-generated index.

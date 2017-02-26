[ {port, 8800},
  {server_name, "localhost"},
  {server_root, "."},
  {document_root, "."},
  {erl_script_alias, {"", [emv_server]}},
  {modules, [mod_esi]},
  {mime_types,[
   {"html","text/html"},
   {"css","text/css"},
   {"js","application/x-javascript"}]
}].

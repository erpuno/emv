-module(inn_visa).
-compile(export_all).

info(length)    -> [ 13, 16 ];
info(prefix)    -> [ "4" ];
info(countries) -> [ { ch, [ "404159" ] },
                     { au, [ "401795", "404137" ] }].

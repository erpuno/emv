-module(inn_mastercard).
-compile(export_all).

info(length)    -> [ 16 ];
info(prefix)    -> [ "51", "52", "53", "54", "55" ];
info(countries) -> [ { ca, ["500235", "500766", "501012"] },
                     { es, ["510013", "510014", "510017"] },
                     { au, ["401795", "404137"] } ].

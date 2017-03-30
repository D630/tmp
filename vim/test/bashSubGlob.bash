#!/usr/bin/env bash

echo *?\?*\*[^123foo[:alnum:][=C=][.foo.]foo0-9]\?\*????

?(foo)
*(foo|bar)
+(foo|*?)
@(foo|[123])
!(foo|*?\?*\*[^123foo[:alnum:][=C=][.foo.]foo0-9]\?\*????)


( ?(foo) )
$( ?(foo) )

# vim: set ft=bash :

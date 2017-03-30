#!/usr/bin/env bash

{,}
{foo,bar}
_{foo,bar}_

{1..5}
{0001..5}
{1..10..2}
_{1..5}_

{a..e}
{a..j..2}
_{a..e}_

{{1..5},{a..e}}

{1..5}{a..e}

{ {,}; }
{ {,} }

# vim: set ft=bash :

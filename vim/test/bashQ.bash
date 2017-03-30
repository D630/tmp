#!/usr/bin/env bash

'foo' "foo" $'foo' $"foo"

'foo'
"foo"
$'foo'
$"foo"

bar'foo'bar
bar"foo"bar
bar$'foo'bar
bar$"foo"bar

bar 'foo' bar
bar "foo" bar
bar $'foo' bar
bar $"foo" bar

'"foo"\n'
$'"foo"\n'
"'foo' bar"
$"'foo' \Far"

foo \
	bar

\foo
foo \bar

# vim: set ft=bash :

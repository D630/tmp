#!/usr/bin/env bash

foo() {

syn keyword bashBuiltinOnly \
	compopt enable getopts

syn keyword bashBuiltinSpecial \
	break continue eval exec exit export readonly return set shift times trap unset

syn keyword bashBuiltinRegular \
	alias bg cd command false fc fg getopts hash jobs kill pwd read true type ulimit umask unalias wait

syn keyword bashBuiltinUtilU \
	bind builtin caller compgen complete declare dirs disown help history let local logout mapfile popd pushd readarray shopt source suspend typeset

syn keyword bashBuiltinUtilS \
	echo printf test

}

# vim: set ft=bash :

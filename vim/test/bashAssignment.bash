#!/usr/bin/env bash

foo=bar
foo+=bar

foo=bar bar=foo

foo=(foo bar)
foo+=(foo bar)
foo=(
	[0]=
	[1]+=bar
	[(2+2) + 1 + foo *= foo[1+1] + 1]=bar
	foo
	bar
	[-1]=bar
)

foo[0]=
foo[bar++]=bar
foo[--bar]+=bar

# vim: set ft=bash :

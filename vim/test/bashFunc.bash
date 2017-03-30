#!/usr/bin/env bash

function foo() { bar; }

foo() { bar; }
foo() {
	bar
}
foo()
{
	function bar() { bar; }

	function bar() {
		bar
	}

	function bar()
	{
		bar
	}
}

# vim: set ft=bash :

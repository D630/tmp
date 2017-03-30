#!/usr/bin/env bash
#
# TODO: multiple here-doc

&> /foo
&>> /foo

< /foo
> /foo
<> /foo
>> /foo

0< /foo
00< /foo
01< /foo
1> /foo
1<> /foo
1>> /foo

3< /foo
2> /foo
3<> /foo
2>> /foo

31< /foo
21> /foo
31<> /foo
21>> /foo

{bar}< /foo
{bar}> /foo
{bar}<> /foo
{bar}>> /foo

0<&3
0<&-
0>&-
3>&-

0<&3-
0>&3-

{bar}<&3
{bar}<&-
{bar}>&-

{bar}<&3-
{bar}>&3-

<<< foo
3<<< foo
12<<< foo
0<<< foo
{bar}<<< foo

<<bar
bar

	<<bar
bar

foo 0<<bar
bar

foo <<bar
foo
bar

foo <<-bar
	foo
	bar

foo <<\bar
foo
bar

foo <<-\bar
	foo
	bar

foo <<'bar'
foo
bar

foo <<-'bar'
	foo
	bar

foo <<"bar"
foo
bar

foo <<-"bar"
	foo
	bar

# vim: set ft=bash :

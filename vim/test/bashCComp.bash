#!/usr/bin/env bash

( foo )
(
	foo
)
( ( foo ) )

{ foo; }
{
	foo
}
{ { foo;} }

(((1 + 1) + 1, foo++))
((
	(
		1 + 1
		foo+=bar
	)
))

if foo; then bar; else bar; fi
if foo
then bar
elif foo
then bar
else foo
fi
if
	if foo; then bar; fi;
then
	bar
else
	foo
fi

while foo; do bar; done
while foo
do
	bar *.[c] $( bar ) <( bar )
done

until foo; do bar; done
until foo
do
	bar
done

for ((1;1;1)) do foo; done
for (((1+1);(1+1);(1+1), bar[1]+=foo))
do
	foo
done

for foo in bar *.[c] $( bar ) <( bar )
do
	bar
done

select foo in bar *.[c] $( bar ) <( bar )
do
	bar
done

[[
	-f $( bar ) foo $((1+1)) 1 "bar" <( bar ) ||
	foo == @(bar|foo) ||
	foo != *bar &&
	foo > $( bar ) ||
	1 -ge (1+1)/12 ||
	( -a $( bar ) ) &&
	foo =~ bar
]]

[[ ! -f foo && -h foo ]]
[[
	( foo == foo && foo =~ foo && foo != foo && ! foo ) || -f foo
]]

case foo in
(@(foo|bar)) ;;
(foo|bar|"ls"|$( ls )|$((1+1))) ((1 + 1));;
esac

case foo in
(foo $( ls ) ) $( ls ); $((1+1));&
([123]) foo;;&
(*) foo; bar;;
esac

case foo in
(foo)
	bar;&
(bar)
	foo;;&
(*)
	foo
	bar;;
esac

# vim: set ft=bash :

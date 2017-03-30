#!/usr/bin/env bash

$foo $1 $?
${foo} ${#} ${#10} ${10} ${foo[1+1]} ${foo[@]} ${foo[*]}

${!!} ${!$} ${!*} ${!@}

${#foo} ${#11} ${#foo[1+1]}
${!foo@}
${!11@}
${!foo[1+1]@}
${!foo*} ${!11*} ${!foo[1+1]*}

${foo:-foo} ${foo?$( foo )} ${foo+"foo"} ${foo-$((1+1))} ${foo[1+1]:-${foo[1+1]}}
${foo[1]:=bar} ${foo[1+1]=$1}
${foo#foo} ${foo##$( foo )} ${foo%"foo"} ${foo%%$((1+1))}
${foo^foo} ${foo^^$( foo )} ${foo,"foo"} ${foo,,$((1+1))}
${foo@Q} ${foo@E} ${foo@P} ${foo@A} ${foo@a} # ${foo@xx}
${foo:(bar=1-1),bar} ${foo[1]: -1} ${foo[1]: -1:3} ${foo[@]:1:1+2}
${foo/foo/bar} ${foo//foo/bar} ${foo/#foo/bar} ${foo/%foo/bar} ${foo/#/bar} ${foo/%/bar}
${foo/foo} ${foo//foo} ${foo/#} ${foo/%}

${!foo:-foo} ${!foo?$( foo )} ${!foo+"foo"} ${!foo-$((1+1))} ${!foo[1+1]:-${!foo[1+1]}}
${!foo[1]:=bar} ${!foo[1+1]=$1}
${!foo#foo} ${!foo##$( foo )} ${!foo%"foo"} ${!foo%%$((1+1))}
${!foo^foo} ${!foo^^$( foo )} ${!foo,"foo"} ${!foo,,$((1+1))}
${!foo@Q} ${!foo@E} ${!foo@P} ${!foo@A} ${!foo@a} # ${!foo@xx}
${!foo:(bar=1-1),bar} ${!foo[1]: -1} ${!foo[1]: -1:3} ${!foo[@]:1:1+2}
${!foo/foo/bar} ${!foo//foo/bar} ${!foo/#foo/bar} ${!foo/%foo/bar} ${!foo/#/bar} ${!foo/%/bar}
${!foo/foo} ${!foo//foo} ${!foo/#} ${!foo/%}

${10:-foo} ${10?$( foo )} ${10+"foo"} ${10-$((1+1))} ${foo[1+1]:-${foo[1+1]}}
${foo[1]:=bar} ${foo[1+1]=$1}
${10#foo} ${10##$( foo )} ${10%"foo"} ${10%%$((1+1))}
${10^foo} ${10^^$( foo )} ${10,"foo"} ${10,,$((1+1))}
${10@Q} ${10@E} ${10@P} ${10@A} ${10@a} # ${10@xx}
${10:(bar=1-1),bar} ${foo[1]: -1} ${foo[1]: -1:3} ${foo[@]:1:1+2}
${10/foo/bar} ${10//foo/bar} ${10/#foo/bar} ${10/%foo/bar} ${10/#/bar} ${10/%/bar}
${10/foo} ${10//foo} ${10/#} ${10/%}

${!10:-foo} ${!10?$( foo )} ${!10+"foo"} ${!10-$((1+1))} ${!foo[1+1]:-${!foo[1+1]}}
${!foo[1]:=bar} ${!foo[1+1]=$1}
${!10#foo} ${!10##$( foo )} ${!10%"foo"} ${!10%%$((1+1))}
${!10^foo} ${!10^^$( foo )} ${!10,"foo"} ${!10,,$((1+1))}
${!10@Q} ${!10@E} ${!10@P} ${!10@A} ${!10@a} # ${!10@xx}
${!10:(bar=1-1),bar} ${foo[1]: -1} ${foo[1]: -1:3} ${foo[@]:1:1+2}
${!10/foo/bar} ${!10//foo/bar} ${!10/#foo/bar} ${!10/%foo/bar} ${!10/#/bar} ${!10/%/bar}
${!10/foo} ${!10//foo} ${!10/#} ${!10/%}

$( ls; foo )
$(
	ls
	foo
)

$((1+1))
$((
	1 + 1
	-+!\~\*/%&^|?:=,<>==
	( 1 + 1 -+!\~\*/%&^|?:=,<>== )
))

$'foo'
$'\a\b\e\E\f\n\r\t\v'
$"foo"

${foo:-$( bar )}
$(($( bar )))
$(($"foo" "bar"))
$( $foo ${foo} $(((1 + 1) + 1 + 1)) )

# vim: set ft=bash :

" Vim syntax file
" Language:             bash shell script
" License:              Vim (see :h license)
" Repository:           https://github.com/D630/vim-bash

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn iskeyword @,48-57,128-255,!,#,%,+,,,-,.,:,?,@-@,[,],_,{,},~,^

" the command language: for, if, functions, ...
" the word language: ${}, $(), $(()), ...
" the arithmetic language: a**2 + b**2
" the boolean language: [[ a =~ b ]]

" TODO:
"
" integer attributed scalars
" multi heredocs
"
" optimize
" errors
" re in [[
" left side of binary primaries in [[
" misc:
" - quotings, bashQEchar ...
" - containments
" - etc.

" bashCComp, bashIn, bashDo {{{1
"

syn region  bashIn
            \ contains=@bashQ,@bashSub
            \ contained
            \ matchgroup=bashInDel
            \ nextgroup=bashDo
            \ start="\<in\>\s\+" end="\<do\>"me=e-2

syn region  bashDo
            \ contains=bashDo,@bashQ,@bashSub,@bashOpRedir,bashFuncNestedDefKey,bashComment,@bashCComp,@bashCSimple,bashContinuation,bashOpCtrl
            \ matchgroup=bashDoDel
            \ start="\<do\>" end="\<done\>"

syn cluster bashCComp
            \ contains=bashCCompSubshell,bashCCompBrace,bashCCompTest,bashCCompIf,bashCCompFor,bashCCompCFor,bashCCompWhile,bashCCompUntil,bashCCompSelect,bashCCompCase,bashCCompArith
" TODO: begin and end?!
syn region  bashCCompSubshell
            \ contains=@bashQ,@bashSub,@bashOpRedir,bashFuncNestedDefKey,bashComment,@bashCComp,@bashCSimple,bashContinuation,bashOpCtrl
            \ matchgroup=bashCCompSubshellDel
            \ start="\$\@<!(\_s\+" skip="\\)" end=")"
syn region  bashCCompBrace
            \ contains=@bashQ,@bashSub,@bashOpRedir,bashFuncNestedDefKey,bashComment,@bashCComp,@bashCSimple,bashContinuation,bashOpCtrl
            \ matchgroup=bashCCompBraceDel
            \ start="\$\@<!\<{\>\_s\+" skip="\\}" end="\<}\>"
syn region  bashCCompArith
            \ contains=bashNumbers,@bashOpArith,bashQDbl,bashQBkslshDbl,@bashSubDollar,@bashIdentifier
            \ matchgroup=bashCCompArithDel
            \ start="\$\@<!((" skip="\%(\\\\\)*\\$" end="))"
syn region  bashCCompIf
            \ contains=bashCCompIfDel,@bashQ,@bashSub,@bashOpRedir,bashFuncNestedDefKey,bashComment,@bashCComp,@bashCSimple,bashContinuation,bashOpCtrl
            \ matchgroup=bashCCompIfDel
            \ start="\<if\>\_s\+" end="\<fi\>"
syn keyword bashCCompIfDel
            \ contained
            \ elif else then
syn region  bashCCompFor
            \ contains=bashIdentifierScalar
            \ matchgroup=bashCCompForDel
            \ nextgroup=bashIn
            \ start="\<for\>\s\+\%(((\)\@!" end="\<in\>"me=e-2
syn region  bashCCompSelect
            \ contains=bashIdentifierScalar
            \ matchgroup=bashCCompSelectDel
            \ nextgroup=bashIn
            \ start="\<select\>\s\+" end="\<in\>"me=e-2
syn region  bashCCompCfor
            \ contains=bashNumbers,@bashOpCfor,bashQDbl,bashQBkslshDbl,@bashSubDollar,@bashIdentifier
            \ matchgroup=bashCCompCforDel
            \ start="\<for\>\s\+((" end="))"
syn region  bashCCompWhile
            \ contains=@bashQ,@bashSub,@bashOpRedir,bashFuncNestedDefKey,bashComment,@bashCComp,@bashCSimple,bashContinuation,bashOpCtrl
            \ matchgroup=bashCCompWhileDel
            \ start="\<while\>\_s\+" end="\<do\>"me=e-2
syn region  bashCCompUntil
            \ contains=@bashQ,@bashSub,@bashOpRedir,bashFuncNestedDefKey,bashComment,@bashCComp,@bashCSimple,bashContinuation,bashOpCtrl
            \ matchgroup=bashCCompUntilDel
            \ start="\<until\>\_s\+" end="\<do\>"me=e-2
syn region  bashCCompCase
            \ contains=@bashQ,bashSubTilde,bashSubProc,@bashSubDollar
            \ matchgroup=bashCCompCaseDel
            \ nextgroup=bashCCompCaseIn
            \ start="\<case\>\s\+" end="\<in\>"me=e-2
syn region  bashCCompCaseIn
            \ contained
            \ contains=bashCCompCasePatternList
            \ transparent
            \ matchgroup=bashCCompCaseInDel
            \ start="\<in\>\_s\+" end="\<esac\>"
syn region  bashCCompCasePatternList
            \ contained
            \ contains=@bashQ,@bashSub,bashCCompCasePatternListAlternation
            \ matchgroup=bashCCompCasePatternListDel
            \ nextgroup=bashCCompCaseItem
            \ start="\$\@<!(" skip="\\)" end="\ze)\_s\+"
syn match   bashCCompCasePatternListAlternation
            \ contained
            \ display
            \ "|"
syn region  bashCCompCaseItem
            \ contained
            \ contains=@bashQ,@bashSub,@bashOpRedir,bashFuncNestedDefKey,bashComment,@bashCComp,@bashCSimple,bashContinuation,bashOpCtrl
            \ keepend
            \ matchgroup=bashCCompCaseItemDel
            \ start=")\_s\+" end="\%(;;&\=\|;&\)"

" bashSub {{{1
"

syn cluster bashSub
            \ contains=@bashSubGlob,bashSubTilde,bashSubProc,@bashSubDollar

" bashSubBrace {{{2
"

syn region  bashSubBrace
            \ contains=bashSubBrace,bashSubBraceRange,bashSubBraceSeq,bashNumbers
            \ matchgroup=bashSubBraceDel
            \ start="\$\@<!{\_s\@!" skip="\\}" end="}"

syn match   bashSubBraceRange
            \ contained
            \ display
            \ "\.\."

syn match   bashSubBraceSeq
            \ contained
            \ display
            \ ","

" bashSubGlob, bashPosix {{{2
"

syn cluster bashSubGlob
            \ contains=bashSubGlobExt,bashSubGlobBracket,bashSubGlobChar
syn region  bashSubGlobBracket
            \ contains=bashPosixCharClass,bashPosixCollation,bashPosixSymbol,bashNumbers,bashSubGlobBracketRange
            \ matchgroup=bashSubGlobBracketDel
            \ start="\[[]!^-]\=" skip="\\]\|[:\.=]\]" end="\]"
syn match   bashSubGlobBracketRange
            \ contained
            \ display
            \ "-"
syn match   bashSubGlobChar
            \ "\%(\\\)\@<![?\*]\%(\\\)\@<!"
syn region  bashSubGlobExt
            \ contains=@bashSubGlob,bashSubGlobExtAlternation
            \ matchgroup=bashSubGlobExtDel
            \ start="[?\*+@!](" skip="\\)" end=")"
syn match   bashSubGlobExtAlternation
            \ contained
            \ display
            \ "|"
syn match   bashPosixCharClass
            \ contained
            \ display
            \ "\[:\%(alnum\|alpha\|ascii\|blank\|cntrl\|digit\|graph\|lower\|print\|punct\|space\|upper\|word\|xdigit\):\]"
syn match   bashPosixCollation
            \ contained
            \ display
            \ "\[=.\+=\]"
syn match   bashPosixSymbol
            \ contained
            \ display
            \ "\[\..\+\.\]"
" syn keyword bashPosixSymbolK
"             \ contained
"             \ NUL SOH STX ETX EOT ENQ ACK alert backspace tab newline vertical-tab form-feed carriage-return SO SI DLE DC1 DC2 DC3 DC4 NAK SYN ETB CAN EM SUB ESC IS4 IS3 IS2 IS1 space exclamation-mark quotation-mark number-sign dollar-sign percent-sign ampersand apostrophe left-parenthesis right-parenthesis asterisk plus-sign comma hyphen-minus period slash zero one two three four five six seven eight nine colon semicolon less-than-sign equals-sign greater-than-sign question-mark commercial-at A B C D E F G H I J K L M N O P Q R S T U V W X Y Z left-square-bracket backslash right-square-bracket circumflex underscore grave-accent a b c d e f g h i j k l m n o p q r s t u v w x y z left-curly-bracket vertical-line right-curly-bracket tilde DEL

syn region  bashCCompTest
            \ contains=@bashOpCond,@bashQ,@bashSub,bashNumbers
            \ matchgroup=bashCCompTestDel
            \ start="\<\[\[\>\_s\+" skip="\%(\\\\\)*\\$" end="\_s\+\<\]\]\>"

" bashSubTilde {{{2
"

" TODO: tilde in assignments
" TODO: no tilde in quoting

syn match   bashSubTilde
            \ display
            \ "\~[+-]\="
syn match   bashSubTilde
            \ display
            \ "\<\~\%(\d\|\w\)\+\>"
syn match   bashSubTilde
            \ display
            \ "\<\~[+-]\d\+\>"

" bashSubProc {{{2
"

" TODO: no proc in quoting

syn region  bashSubProc
            \ contains=@bashQ,@bashSub,@bashOpRedir,bashFuncNestedDefKey,bashComment,@bashCComp,@bashCSimple,bashContinuation,bashOpCtrl
            \ matchgroup=bashSubProcDel
            \ start="[<>](" skip="\\)" end=")"

" bashSubDollar {{{2
"

syn cluster bashSubDollar
            \ contains=bashSubParaRef,bashSubParaExp,bashSubCom,bashSubArith,bashQBkslshSngl,bashQBkslshDbl
syn match   bashSubParaRef
            \ display
            \ "\$\%(\h\w*\|\d\|[!#$*@?_-]\)"
syn region  bashSubParaExp
            \ contains=@bashIdentifier,bashIdentifierPositional,bashSubParaExp1,bashSubParaExp2,bashSubParaExp3,bashSubParaExp4,bashSubParaExp5,bashSubParaExp6,bashSubParaExp7
            \ matchgroup=bashSubParaExpDel
            \ start="\${!\=" skip="\\}" end="}"
syn region  bashSubParaExp
            \ contains=bashSubParaExp1,bashSubParaExp2,bashSubParaExp3,bashSubParaExp4,bashSubParaExp5,bashSubParaExp6,bashSubParaExp7
            \ matchgroup=bashSubParaExpDel
            \ start="\${[$*@?_-]" skip="\\}" end="}"
syn region  bashSubParaExp
            \ contains=bashSubParaExp1,bashSubParaExp2,bashSubParaExp3,bashSubParaExp4,bashSubParaExp5,bashSubParaExp6,bashSubParaExp7
            \ matchgroup=bashSubParaExpDel
            \ start="\${![#?_]" skip="\\}" end="}"
syn region  bashSubParaExp1
            \ contained
            \ contains=bashNumbers,@bashOpArith,bashQDbl,bashQBkslshDbl,@bashSubDollar,@bashIdentifier
            \ matchgroup=Operator
            \ start=":\%(\s\+-\)\=" skip="\\}" end="\ze:" end="\ze}"
syn region  bashSubParaExp2
            \ contained
            \ contains=@bashQ,@bashSub
            \ matchgroup=Operator
            \ start=":\=[-+?]" skip="\\}" end="\ze}"
syn region  bashSubParaExp3
            \ contained
            \ contains=@bashQ,@bashSub
            \ matchgroup=Type
            \ start=":\==" skip="\\}" end="\ze}"
syn region  bashSubParaExp4
            \ contained
            \ contains=@bashQ,@bashSub
            \ matchgroup=Operator
            \ start="\%(%%\=\|##\=\)" skip="\\}" end="\ze}"
syn region  bashSubParaExp5
            \ contained
            \ contains=@bashQ,@bashSub
            \ matchgroup=Operator
            \ start="\%(\^\^\=\|,,\=\)" skip="\\}" end="\ze}"
syn region  bashSubParaExp6
            \ contained
            \ matchgroup=Operator
            \ start="@[QEPAa]" skip="\\}" end="\ze}"
" syn region  bashSubParaExp6
"             \ contained
"             \ matchgroup=Error
"             \ start="@[^QEPAa]\+" skip="\\}" end="\ze}"
syn region  bashSubParaExp7
            \ contained
            \ contains=@bashQ,@bashSub
            \ matchgroup=Operator
            \ start="/[/#%]\=" skip="\\}" end="\ze/" end="\ze}"
syn match   bashSubParaExpDel
            \ display
            \ "\${!\h\w*[@\*]}"
syn match   bashSubParaExpError
            \ display
            \ "\${![!\$\*@]"
syn region  bashSubParaExp
            \ contains=@bashIdentifier,bashIdentifierPositional,bashIdentifierSpecial
            \ matchgroup=bashSubParaExpDel
            \ start="\${#" skip="\\}" end="}"
syn region  bashSubCom
            \ contains=@bashQ,@bashSub,@bashOpRedir,bashFuncNestedDefKey,bashComment,@bashCComp,@bashCSimple,bashContinuation,bashOpCtrl
            \ matchgroup=bashSubComDel
            \ start="\$(\_s\+" skip="\\\\\|\\.\||\\" end=")"
syn region  bashSubArith
            \ contains=bashNumbers,@bashOpArith,bashQDbl,bashQBkslshDbl,@bashSubDollar,@bashIdentifier
            \ matchgroup=bashSubArithDel
            \ start="\$((" skip="\\\\\|\\." end="))"

" bashQ, bashContinuation {{{1
"

syn cluster bashQ
            \ contains=bashQSngl,bashQDbl,bashQBkslshSngl,bashQBkslshDbl,bashQEchar
syn region  bashQSngl
            \ matchgroup=bashQSngl
            \ start=+'+ end=+'+
syn region  bashQDbl
            \ contains=bashQEchar,@bashSubDollar
            \ matchgroup=bashQDbl
            \ start=+\%(\%(\\\\\)*\\\)\@<!"+ skip=+\\"+ end=+"+
syn region  bashQBkslshSngl
            \ contains=bashEcharSeq
            \ start=+\$'+ skip=+\\\\\|\\.+ end=+'+
syn region  bashQBkslshDbl
            \ start=+\$"+ skip=+\\\\\|\\.\|\\"+ end=+"+ contains=@bashSubDollar
syn match   bashQEchar
            \ contained
            \ display
            \ "\%(^\)\@!\%(\\\\\)*\\."
syn match   bashEcharSeq
            \ contained
            \ display
            \ '[^\\]\(\\\\\)*\zs\\\o\o\o\|\\x\x\x\|\\c[^"]\|\\\d\d\d\|\\[abeEfnrtv]'
syn match   bashEcharSeq
            \ contained
            \ display
            \ '^\(\\\\\)*\zs\\\o\o\o\|\\x\x\x\|\\c[^"]\|\\\d\d\d\|\\[abeEfnrtv]'

syn match   bashContinuation
            \ display
            \ "\s\+\\$"

" bashNumbers {{{1
"

syn case ignore
syn match   bashNumbers
            \ contained
            \ contains=bashNumber,bashNumberBase
            \ display
            \ transparent
            \ "\d"
syn match   bashNumber
            \ contained
            \ display
            \ "\d\+"
syn match   bashNumber
            \ contained
            \ display
            \ "0x\x\+"
" TODO: wann oktal?
syn match   bashNumber
            \ display
            \ contained
            \ "0\o\+"
" TODO: details
syn match   bashNumberBase
            \ contained
            \ display
            \ "\d\+#\w\+"
syn case match

" bashComment, bashTodo {{{1
"

syn match   bashComment
            \ contains=bashTodo,@Spell
            \ display
            \ "\%(^\|\s*\)\zs#.*$"

syn match   bashTodo
            \ contained
            \ "\<\%(COMBAK\|FIXME\|TODO\|XXX\):\=\>"

" bashOp {{{1
"

" bashOpCond {{{2
"

syn cluster bashOpCond
            \ contains=bashOpCondMeta,bashOpCondUnary,bashOpCondBinaryPattern,bashOpCondBinaryRegex,bashOpCondBinaryArith

syn match   bashOpCondMeta
            \ contained
            \ display
            \ "\%([!()]\|&&\|||\)"

syn region  bashOpCondUnary
            \ contained
            \ contains=@bashQ,bashSubTilde,bashSubProc,@bashSubDollar
            \ matchgroup=bashOpCond
            \ start="-[a-hknppr-zGLNORS]\>" skip="\\)" end="\%()\|&&\|||\)" end="\ze\_s\+\<\]\]\>"

syn region  bashOpCondBinaryPattern
            \ contained
            \ contains=@bashQ,@bashSub
            \ matchgroup=bashOpCond
            \ start="\%(==\|!=\|[<>]\)\s\+" skip="\\)" end="\%()\|&&\|||\)" end="\ze\_s\+\<\]\]\>"

syn region  bashOpCondBinaryRegex
            \ contained
            \ contains=@bashQ,@bashSub
            \ matchgroup=bashOpCond
            \ start="=\~\s\+" skip="\\)" end="\%()\|&&\|||\)" end="\ze\_s\+\<\]\]\>"

syn region  bashOpCondBinaryArith
            \ contained
            \ contains=@bashQ,@bashSub,@bashOpArith,bashNumbers
            \ matchgroup=bashOpCond
            \ start="\%(-e[fq]\|-g[et]\|-l[et]\|-n[et]\|-ot\)\>" skip="\\)" end="\%()\|&&\|||\)" end="\ze\_s\+\<\]\]\>"

"\%(=~\|-e[fq]\|-g[et]\|-l[et]\|-n[et]\|-ot\|\)"

" \ "\%(=[=~]\|!=\|-[a-hknppr-zGLNORS]\|[<>!()]\|-e[fq]\|-g[et]\|-l[et]\|-n[et]\|-ot\|&&\|||\)"

" bashOpCfor {{{2
"

syn cluster bashOpCfor
            \ contains=bashOpArithA,bashOpCforG,bashOpCforN,
" TODO: _
syn match bashOpCforN
            \ contained
            \ display
            \ "[-+!\~\*/%&^|?:=,<>;]"
" TODO transparent?
syn region  bashOpCforG
            \ contained
            \ contains=bashNumbers,@bashOpCfor,bashQDbl,bashQBkslshDbl,@bashSubDollar,bashIdentifier
            \ start="\$\@<!(" end=")"

" bashOpArith {{{2
"

syn cluster bashOpArith
            \ contains=bashOpArithA,bashOpArithG,bashOpArithN
" TODO: _
syn match bashOpArithN
            \ contained
            \ display
            \ "[-+!\~\*/%&^|?:=,<>]"
syn match bashOpArithA
            \ contained
            \ display
            \ "=\@<!==\@!"
syn match bashOpArithA
            \ contained
            \ display
            \ "\%([-+\*/%&^|]\|<<\|>>\)==\@!"
syn match bashOpArithA
            \ contained
            \ display
            \ "\%(--\|++\)"
" TODO transparent?
syn region  bashOpArithG
            \ contained
            \ contains=bashNumbers,@bashOpArith,bashQDbl,bashQBkslshDbl,@bashSubDollar,@bashIdentifier
            \ start="\$\@<!(" end=")"

" bashOpCtrl {{{2
"

syn match   bashOpCtrl
            \ display
            \ "\s\+\%(||\|&&\|&\||\)\_s\+"
syn match   bashOpCtrl
            \ display
            \ "\%(^\s*\)\@<!;\_s\+"

" bashOpRedir {{{2
"

syn cluster bashOpRedir
            \ contains=bashOpRedirN,@bashOpRedirHereDoc,bashOpRedirHereString

syn match   bashOpRedirN
            \ display
            \ "\%(^\|\s\+\)\%([0-9]\+\|{\h\w*}\|[<>]\)\@<!\%(<\|>\|<>\|>>\)\s\+"
syn match   bashOpRedirN
            \ display
            \ "\%(^\|\s\+\)\%(\<[1-9][0-9]*\>\|\<{\h\w*}\>\)<\s\+"
syn match   bashOpRedirN
            \ display
            \ "\%(^\|\s\+\)\<\%(\<[02-9]\>\|\<[1-9][0-9]\+\>\|\<{\h\w*}\>\)\%(>\|<>\|>>\)\s\+"
syn match   bashOpRedirN
            \ display
            \ "\%(^\|\s\+\)\%(\<\d\+\>\|\<{\h\w*}\>\)[<>]&\s*[0-9]\+-\="
syn match   bashOpRedirN
            \ display
            \ "\%(^\|\s\+\)\%(\<\d\+\>\|\<{\h\w*}\>\)>&\s*-"
syn match   bashOpRedirN
            \ display
            \ "\%(^\|\s\+\)\<{\h\w*}\><&\s*-"
syn match   bashOpRedirN
            \ display
            \ "\%(^\|\s\+\)&>>\=\s\+"

" TODO: multi here-docs
syn cluster bashOpRedirHereDoc
            \ contains=bashOpRedirHereDocN,bashOpRedirHereDocQ
syn region  bashOpRedirHereDocN
            \ contains=@bashSubDollar,@bashOpRedirHereDoc
            \ matchgroup=bashOpRedirHereDocNDel
            \ start="\%(^\|\s\+\)\%(\<[1-9][0-9]*\>\|\<{\h\w*}\>\|\)<\@<!<<\z([^[:cntrl:]|&;()<>$`\\#\*[:space:]""']\+\)" end="^\z1\s*$"
syn region  bashOpRedirHereDocN
            \ contains=@bashSubDollar,@bashOpRedirHereDoc
            \ matchgroup=bashOpRedirHereDocNDel
            \ start="\%(^\|\s\+\)\%(\<[1-9][0-9]*\>\|\<{\h\w*}\>\|\)<\@<!<<-\z([^[:cntrl:]|&;()<>$`\\#\*[:space:]""']\+\)" end="^\s*\z1\s*$"
syn region  bashOpRedirHereDocQ
            \ contains=@bashOpRedirHereDoc
            \ matchgroup=bashOpRedirHereDocQDel
            \ start="\%(^\|\s\+\)\%(\<[1-9][0-9]*\>\|\<{\h\w*}\>\|\)<\@<!<<\\\z([^[:cntrl:]|&;()<>$`\\#\*[:space:]""']\+\)" end="^\z1\s*$"
syn region  bashOpRedirHereDocQ
            \ contains=@bashOpRedirHereDoc
            \ matchgroup=bashOpRedirHereDocQDel
            \ start="\%(^\|\s\+\)\%(\<[1-9][0-9]*\>\|\<{\h\w*}\>\|\)<\@<!<<-\\\z([^[:cntrl:]|&;()<>$`\\#\*[:space:]""']\+\)" end="^\s*\z1\s*$"
syn region  bashOpRedirHereDocQ
            \ contains=@bashOpRedirHereDoc
            \ matchgroup=bashOpRedirHereDocQDel
            \ start=+\%(^\|\s\+\)\%(\<[1-9][0-9]*\>\|\<{\h\w*}\>\|\)<\@<!<<\(["']\)\z([^[:cntrl:]|&;()<>$`\\#\*[:space:]""']\+\)\1+ end='^\z1\s*$'
syn region  bashOpRedirHereDocQ
            \ contains=@bashOpRedirHereDoc
            \ matchgroup=bashOpRedirHereDocQDel
            \ start=+\%(^\|\s\+\)\%(\<[1-9][0-9]*\>\|\<{\h\w*}\>\|\)<\@<!<<-\(["']\)\z([^[:cntrl:]|&;()<>$`\\#\*[:space:]""']\+\)\1+ end='^\s*\z1\s*$'

syn match   bashOpRedirHereString
            \ display
            \ "\%(^\|\s\+\)\%(\<[1-9][0-9]*\>\|\<{\h\w*}\>\|\)<<<\s\+"

" bashFunc {{{1
"

syn region  bashFuncDef
            \ contains=@bashQ,@bashSub,@bashOpRedir,bashFuncNestedDefKey,bashComment,@bashCComp,@bashCSimple,bashContinuation,bashOpCtrl
            \ transparent
            \ matchgroup=bashFuncDefDel
            \ start="\<[^[:cntrl:]|&;()<>$`\\#\*[:space:]""']\+\>\s*()\_s*{" end="\<}\>"

syn keyword bashFuncNestedDefKey
            \ contained
            \ nextgroup=bashFuncDef
            \ skipwhite
            \ skipnl
            \ function

" bashIdentifier {{{1
"

syn cluster bashIdentifier
            \ contains=bashIdentifierScalar,bashIdentifierVector
syn match   bashIdentifierScalar
            \ contained
            \ display
            \ "\h\w*"
syn region  bashIdentifierVector
            \ contained
            \ contains=@bashQ,@bashSubDollar,bashNumbers,@bashOpArith,@bashIdentifier
            \ start="\h\w*\[" skip="\\]" end="\]"

syn match   bashIdentifierPositional
            \ contained
            \ display
            \ "\d\+"

syn match   bashIdentifierSpecial
            \ contained
            \ display
            \ "[!#$*@?_-]"

" bashAssignment {{{1
"

syn region  bashAssignmentVector
            \ contains=bashNumbers,@bashOpArith,bashQDbl,bashQBkslshDbl,@bashSubDollar,@bashIdentifier
            \ matchgroup=bashAssignmentVectorDel
            \ nextgroup=@bashQ,bashSubTilde,bashSubProc,@bashSubDollar
            \ start="=\@<!\<\h\w*\[" skip="\\]" end="\]+\=="
syn match   bashAssignmentScalar
            \ display
            \ nextgroup=@bashQ,bashSubTilde,bashSubProc,@bashSubDollar,bashAssignmentArray
            \ "=\@<!\<\h\w*+\=="
syn region  bashAssignmentArray
            \ contained
            \ contains=@bashQ,@bashSub,bashAssignmentArrayComp
            \ matchgroup=bashAssignmentArrayDel
            \ start="(" skip="\\)" end=")"
syn region  bashAssignmentArrayComp
            \ contained
            \ contains=bashNumbers,@bashOpArith,bashQDbl,bashQBkslshDbl,@bashSubDollar,@bashIdentifier
            \ matchgroup=bashAssignmentArrayCompDel
            \ nextgroup=@bashQ,bashSubTilde,bashSubProc,@bashSubDollar
            \ start="\[" skip="\\]" end="\]+\=="

" bashFiles {{{1
"

syn match   bashFiles
            \ contained
            \ "/dev/\(stdin\|stdout\|stderr\)\="

syn match   bashFiles
            \ contained
            \ "/dev/\(tcp\|udp\)/\(.\+\)\=/\(\d\+\)\="

syn match   bashFiles
            \ contained
            \ "/dev/fd/\(\d\+\)\="

" bashVariables {{{1
"

syn keyword bashVariable
            \ contained
            \ BASH BASHOPTS BASHPID BASH_ALIASES BASH_ARGC BASH_ARGV BASH_CMDS BASH_COMMAND BASH_COMPAT BASH_ENV BASH_EXECUTION_STRING BASH_LINENO BASH_LOADABLES_PATH BASH_REMATCH BASH_SOURCE BASH_SUBSHELL BASH_VERSINFO BASH_VERSION BASH_XTRACEFD CDPATH CHILD_MAX COLUMNS COMPREPLY COMP_CWORD COMP_KEY COMP_LINE COMP_POINT COMP_TYPE COMP_WORDBREAKS COMP_WORDS COPROC DIRSTACK EMACS ENV EUID EXECIGNORE FCEDIT FIGNORE FUNCNAME FUNCNEST GLOBIGNORE GROUPS HISTCMD HISTCONTROL HISTFILE HISTFILESIZE HISTIGNORE HISTSIZE HISTTIMEFORMAT HOME HOSTFILE HOSTNAME HOSTTYPE IFS IGNOREEOF INPUTRC LANG LC_ALL LC_COLLATE LC_CTYPE LC_MESSAGES LC_NUMERIC LC_TIME LINENO LINES MACHTYPE MAIL MAILCHECK MAILPATH MAPFILE OLDPWD OPTARG OPTERR OPTIND OSTYPE PATH PIPESTATUS POSIXLY_CORRECT PPID PROMPT_COMMAND PROMPT_DIRTRIM PS0 PS1 PS2 PS3 PS4 PWD RANDOM READLINE_LINE READLINE_POINT REPLY SECONDS SHELL SHELLOPTS SHLVL TIMEFORMAT TMOUT TMPDIR UID auto_resume histchars

" bashCSimple, bashBuiltin, bashUtil {{{1
"

syn cluster bashCSimple
            \ contains=bashBuiltinOnly,bashBuiltinRegular,bashBuiltinSpecial,bashBuiltinUtilS,bashBuiltinUtilU,bashUtilU,bashUtilS

" bash keyword
""coproc

" bash builtins
""[
syn keyword bashBuiltinOnly
            \ contained
            \ compopt enable getopts

" POSIX special builtins
"": .
syn keyword bashBuiltinSpecial
            \ contained
            \ break continue eval exec exit export readonly return set shift times trap unset

" POSIX regular builtins
""newgrp
syn keyword bashBuiltinRegular
            \ contained
            \ alias bg cd command false fc fg getopts hash jobs kill pwd read true type ulimit umask unalias wait

" POSIX unspecific utilities

"" bash builtins
syn keyword bashBuiltinUtilU
            \ contained
            \ bind builtin caller compgen complete declare dirs disown help history let local logout mapfile popd pushd readarray shopt source suspend typeset

"" file
syn keyword bashUtilU
            \ contained
            \ alloc autoload bindkey bye cap chdir clone comparguments compcall compctl compdescribe compfiles compgroups compquote comptags comptry compvalues disable dosh echotc echoti hist login map print repeat savehistory stop whence

" POSIX standard utilities

"" bash keyword
""time

"" bash builtin
syn keyword bashBuiltinUtilS
            \ contained
            \ echo printf test
"" file
syn keyword bashUtilS
            \ contained
            \ admin ar asa at awk basename batch bc c99 cal cat cflow chgrp chmod chown cksum cmp comm compress cp crontab csplit ctags cut cxref date dd delta df diff dirname du ed env ex expand expr file find fold fort77 fuser gencat get getconf grep head iconv id ipcrm ipcs join lex link ln locale localedef logger logname lp ls m4 mailx make man mesg mkdir mkfifo more mv nice nl nm nohup od paste patch pathchk pax pr prs ps qalter qdel qhold qmove qmsg qrerun qrls qselect qsig qstat qsub renice rm rmdel rmdir sact sccs sed sh sleep sort split strings strip stty tabs tail talk tee touch tput tr tsort tty uname uncompress unexpand unget uniq unlink uucp uudecode uuencode uustat uux val vi wc what who write xargs yacc zcat

" syn sync {{{1
"

syn sync minlines=200 maxlines=400

" hi def link {{{1
"

hi def link bashAssignmentArrayCompDel Type
hi def link bashAssignmentArrayDel Type
hi def link bashAssignmentScalar Type
hi def link bashAssignmentVectorDel Type
hi def link bashBuiltinOnly Statement
hi def link bashBuiltinRegular Statement
hi def link bashBuiltinSpecial Statement
hi def link bashBuiltinUtilS Statement
hi def link bashBuiltinUtilU Statement
hi def link bashCCompArithDel Conditional
hi def link bashCCompBraceDel Statement
hi def link bashCCompCaseDel Conditional
hi def link bashCCompCaseInDel bashCCompCaseDel
hi def link bashCCompCaseItemDel bashCCompCaseDel
hi def link bashCCompCasePatternListAlternation bashCCompCaseDel
hi def link bashCCompCasePatternListDel bashCCompCaseDel
hi def link bashCCompCforDel Repeat
hi def link bashCCompForDel Repeat
hi def link bashCCompIfDel Conditional
hi def link bashCCompSelectDel Conditional
hi def link bashCCompSubshellDel Statement
hi def link bashCCompTestDel Conditional
hi def link bashCCompUntilDel Repeat
hi def link bashCCompWhileDel Repeat
hi def link bashComment Comment
hi def link bashContinuation Special
hi def link bashDoDel Statement
hi def link bashEcharSeq Special
hi def link bashFiles Underlined
hi def link bashFuncDefDel Type
hi def link bashFuncNestedDefKey bashFuncDefDel
hi def link bashIdentifierPositional Identifier
hi def link bashIdentifierScalar Identifier
hi def link bashIdentifierSpecial Identifier
hi def link bashIdentifierVector Identifier
hi def link bashInDel Conditional
hi def link bashNumber Number
hi def link bashNumberBase Number
hi def link bashOpArithA Type
hi def link bashOpArithG bashOpArithN
hi def link bashOpArithN Operator
hi def link bashOpCforG bashOpArithG
hi def link bashOpCforN bashOpArithN
hi def link bashOpCond Operator
hi def link bashOpCondMeta bashOpCond
hi def link bashOpCtrl Operator
hi def link bashOpRedirHereDocN bashQDbl
hi def link bashOpRedirHereDocNDel bashOpRedirN
hi def link bashOpRedirHereDocQ bashQSngl
hi def link bashOpRedirHereDocQDel bashOpRedirN
hi def link bashOpRedirHereString Operator
hi def link bashOpRedirN Operator
hi def link bashPosixCharClass Special
hi def link bashPosixCollation Special
hi def link bashPosixSymbol Special
hi def link bashQBkslshDbl bashQDbl
hi def link bashQBkslshSngl bashQSngl
hi def link bashQDbl String
hi def link bashQEchar Special
hi def link bashQSngl String
hi def link bashSubArithDel Function
hi def link bashSubBraceDel Function
hi def link bashSubBraceRange bashSubBraceDel
hi def link bashSubBraceSeq bashSubBraceDel
hi def link bashSubComDel Function
hi def link bashSubGlobBracketDel Function
hi def link bashSubGlobBracketRange bashSubGlobBracketDel
hi def link bashSubGlobChar Function
hi def link bashSubGlobExtAlternation bashSubGlobExtDel
hi def link bashSubGlobExtDel Function
hi def link bashSubParaExpDel Function
hi def link bashSubParaRef Identifier
hi def link bashSubProcDel Function
hi def link bashSubTilde Function
hi def link bashTodo Todo
hi def link bashUtilS Statement
hi def link bashUtilU Statement
hi def link bashVariable Special
" finish {{{1
"

let b:current_syntax = "bash"

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: fdm=marker

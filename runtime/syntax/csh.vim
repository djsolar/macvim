" Vim syntax file
" Language:	C-shell (csh)
" Maintainer:	Charles E. Campbell <NdrOchipS@PcampbellAfamily.Mbiz>
" Version:	11
" Last Change:	Oct 23, 2014
" URL:	http://www.drchip.org/astronaut/vim/index.html#SYNTAX_CSH

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" clusters:
syn cluster cshQuoteList	contains=cshDblQuote,cshSnglQuote,cshBckQuote
syn cluster cshVarList	contains=cshExtVar,cshSelector,cshQtyWord,cshArgv,cshSubst

" Variables which affect the csh itself
syn match cshSetVariables	contained "argv\|histchars\|ignoreeof\|noglob\|prompt\|status"
syn match cshSetVariables	contained "cdpath\|history\|mail\|nonomatch\|savehist\|time"
syn match cshSetVariables	contained "cwd\|home\|noclobber\|path\|shell\|verbose"
syn match cshSetVariables	contained "echo"

syn case ignore
syn keyword cshTodo	contained todo
syn case match

" Variable Name Expansion Modifiers
syn match cshModifier	contained ":\(h\|t\|r\|q\|x\|gh\|gt\|gr\)"

" Strings and Comments
syn match   cshNoEndlineDQ	contained "[^\"]\(\\\\\)*$"
syn match   cshNoEndlineSQ	contained "[^\']\(\\\\\)*$"
syn match   cshNoEndlineBQ	contained "[^\`]\(\\\\\)*$"

syn region  cshDblQuote	start=+[^\\]"+lc=1 skip=+\\\\\|\\"+ end=+"+	contains=cshSpecial,cshShellVariables,cshExtVar,cshSelector,cshQtyWord,cshArgv,cshSubst,cshNoEndlineDQ,cshBckQuote,@Spell
syn region  cshSnglQuote	start=+[^\\]'+lc=1 skip=+\\\\\|\\'+ end=+'+	contains=cshNoEndlineSQ,@Spell
syn region  cshBckQuote	start=+[^\\]`+lc=1 skip=+\\\\\|\\`+ end=+`+	contains=cshNoEndlineBQ,@Spell
syn region  cshDblQuote	start=+^"+ skip=+\\\\\|\\"+ end=+"+		contains=cshSpecial,cshExtVar,cshSelector,cshQtyWord,cshArgv,cshSubst,cshNoEndlineDQ,@Spell
syn region  cshSnglQuote	start=+^'+ skip=+\\\\\|\\'+ end=+'+		contains=cshNoEndlineSQ,@Spell
syn region  cshBckQuote	start=+^`+ skip=+\\\\\|\\`+ end=+`+		contains=cshNoEndlineBQ,@Spell
syn cluster cshCommentGroup	contains=cshTodo,@Spell
syn match   cshComment	"#.*$" contains=@cshCommentGroup

" A bunch of useful csh keywords
syn keyword cshStatement	alias	end	history	onintr	setenv	unalias
syn keyword cshStatement	cd	eval	kill	popd	shift	unhash
syn keyword cshStatement	chdir	exec	login	pushd	source
syn keyword cshStatement	continue	exit	logout	rehash	time	unsetenv
syn keyword cshStatement	dirs	glob	nice	repeat	umask	wait
syn keyword cshStatement	echo	goto	nohup

syn keyword cshConditional	break	case	else	endsw	switch
syn keyword cshConditional	breaksw	default	endif
syn keyword cshRepeat	foreach

" Special environment variables
syn keyword cshShellVariables	HOME	LOGNAME	PATH	TERM	USER

" Modifiable Variables without {}
syn match cshExtVar	"\$[a-zA-Z_][a-zA-Z0-9_]*\(:h\|:t\|:r\|:q\|:x\|:gh\|:gt\|:gr\)\="		contains=cshModifier
syn match cshSelector	"\$[a-zA-Z_][a-zA-Z0-9_]*\[[a-zA-Z_]\+\]\(:h\|:t\|:r\|:q\|:x\|:gh\|:gt\|:gr\)\="	contains=cshModifier
syn match cshQtyWord	"\$#[a-zA-Z_][a-zA-Z0-9_]*\(:h\|:t\|:r\|:q\|:x\|:gh\|:gt\|:gr\)\="		contains=cshModifier
syn match cshArgv		"\$\d\+\(:h\|:t\|:r\|:q\|:x\|:gh\|:gt\|:gr\)\="			contains=cshModifier
syn match cshArgv		"\$\*\(:h\|:t\|:r\|:q\|:x\|:gh\|:gt\|:gr\)\="			contains=cshModifier

" Modifiable Variables with {}
syn match cshExtVar	"\${[a-zA-Z_][a-zA-Z0-9_]*\(:h\|:t\|:r\|:q\|:x\|:gh\|:gt\|:gr\)\=}"		contains=cshModifier
syn match cshSelector	"\${[a-zA-Z_][a-zA-Z0-9_]*\[[a-zA-Z_]\+\]\(:h\|:t\|:r\|:q\|:x\|:gh\|:gt\|:gr\)\=}"	contains=cshModifier
syn match cshQtyWord	"\${#[a-zA-Z_][a-zA-Z0-9_]*\(:h\|:t\|:r\|:q\|:x\|:gh\|:gt\|:gr\)\=}"		contains=cshModifier
syn match cshArgv		"\${\d\+\(:h\|:t\|:r\|:q\|:x\|:gh\|:gt\|:gr\)\=}"			contains=cshModifier

" UnModifiable Substitutions
syn match cshSubstError	"\$?[a-zA-Z_][a-zA-Z0-9_]*:\(h\|t\|r\|q\|x\|gh\|gt\|gr\)"
syn match cshSubstError	"\${?[a-zA-Z_][a-zA-Z0-9_]*:\(h\|t\|r\|q\|x\|gh\|gt\|gr\)}"
syn match cshSubstError	"\$?[0$<]:\(h\|t\|r\|q\|x\|gh\|gt\|gr\)"
syn match cshSubst	"\$?[a-zA-Z_][a-zA-Z0-9_]*"
syn match cshSubst	"\${?[a-zA-Z_][a-zA-Z0-9_]*}"
syn match cshSubst	"\$?[0$<]"

" I/O redirection
syn match cshRedir	">>&!\|>&!\|>>&\|>>!\|>&\|>!\|>>\|<<\|>\|<"

" Handle set expressions
syn region  cshSetExpr	matchgroup=cshSetStmt start="\<set\>\|\<unset\>" end="$\|;" contains=cshComment,cshSetStmt,cshSetVariables,@cshQuoteList

" Operators and Expression-Using constructs
"syn match   cshOperator	contained "&&\|!\~\|!=\|<<\|<=\|==\|=\~\|>=\|>>\|\*\|\^\|\~\|||\|!\|\|%\|&\|+\|-\|/\|<\|>\||"
syn match   cshOperator	contained "&&\|!\~\|!=\|<<\|<=\|==\|=\~\|>=\|>>\|\*\|\^\|\~\|||\|!\|%\|&\|+\|-\|/\|<\|>\||"
syn match   cshOperator	contained "[(){}]"
syn region  cshTest	matchgroup=cshStatement start="\<if\>\|\<while\>" skip="\\$" matchgroup=cshStatement end="\<then\>\|$" contains=cshComment,cshOperator,@cshQuoteList,@cshVarLIst

" Highlight special characters (those which have a backslash) differently
syn match cshSpecial	contained "\\\d\d\d\|\\[abcfnrtv\\]"
syn match cshNumber	"-\=\<\d\+\>"

" All other identifiers
"syn match cshIdentifier	"\<[a-zA-Z._][a-zA-Z0-9._]*\>"

" Shell Input Redirection (Here Documents)
if version < 600
  syn region cshHereDoc matchgroup=cshRedir start="<<-\=\s*\**END[a-zA-Z_0-9]*\**" matchgroup=cshRedir end="^END[a-zA-Z_0-9]*$"
  syn region cshHereDoc matchgroup=cshRedir start="<<-\=\s*\**EOF\**" matchgroup=cshRedir end="^EOF$"
else
  syn region cshHereDoc matchgroup=cshRedir start="<<-\=\s*\**\z(\h\w*\)\**" matchgroup=cshRedir end="^\z1$"
endif

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_csh_syntax_inits")
  if version < 508
    let did_csh_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink cshArgv		cshVariables
  HiLink cshBckQuote	cshCommand
  HiLink cshDblQuote	cshString
  HiLink cshExtVar	cshVariables
  HiLink cshHereDoc	cshString
  HiLink cshNoEndlineBQ	cshNoEndline
  HiLink cshNoEndlineDQ	cshNoEndline
  HiLink cshNoEndlineSQ	cshNoEndline
  HiLink cshQtyWord	cshVariables
  HiLink cshRedir		cshOperator
  HiLink cshSelector	cshVariables
  HiLink cshSetStmt	cshStatement
  HiLink cshSetVariables	cshVariables
  HiLink cshSnglQuote	cshString
  HiLink cshSubst		cshVariables

  HiLink cshCommand	Statement
  HiLink cshComment	Comment
  HiLink cshConditional	Conditional
  HiLink cshIdentifier	Error
  HiLink cshModifier	Special
  HiLink cshNoEndline	Error
  HiLink cshNumber	Number
  HiLink cshOperator	Operator
  HiLink cshRedir		Statement
  HiLink cshRepeat	Repeat
  HiLink cshShellVariables	Special
  HiLink cshSpecial	Special
  HiLink cshStatement	Statement
  HiLink cshString	String
  HiLink cshSubstError	Error
  HiLink cshTodo		Todo
  HiLink cshVariables	Type

  delcommand HiLink
endif

let b:current_syntax = "csh"

" vim: ts=18

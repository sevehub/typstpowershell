vim9script

# Vim syntax file
# Language: Typst
# Latest Revision: Jan 2025

syntax sync fromstart
syntax spell toplevel

syntax cluster typstCommon
    \ contains=@typstComment

syntax cluster typstComment
    \ contains=typstCommentBlock,typstCommentLine
syntax match typstCommentBlock
    \ #/\*\_.*\*/#
    \ contains=typstCommentTodo,@Spell
syntax match typstCommentLine
    \ #//.*$#
    \ contains=typstCommentTodo,@Spell
syntax keyword typstCommentTodo
    \ contained
    \ TODO 


syntax cluster typstCode
    \ contains=@typstCommon
            \ ,@typstCodeKeywords
            \ ,@typstCodeConstants
            \ ,@typstCodeIdentifiers
            \ ,@typstCodeFunctions
            \ ,@typstCodeParens

syntax cluster typstCodeKeywords
    \ contains=typstCodeConditional
            \ ,typstCodeRepeat
            \ ,typstCodeKeyword
            \ ,typstCodeStatement
syntax keyword typstCodeConditional
    \ contained
    \ if else
syntax keyword typstCodeRepeat
    \ contained
    \ while for
syntax keyword typstCodeKeyword
    \ contained
    \ not in and or return
syntax region typstCodeStatement
    \ contained
    \ matchgroup=typstCodeStatementWord start=/\v(let|set|show|import|include)>-@!/ end=/\v%(;|$)/
    \ contains=@typstCode

syntax cluster typstCodeConstants
    \ contains=typstCodeConstant
            \ ,typstCodeNumberInteger
            \ ,typstCodeNumberFloat
            \ ,typstCodeNumberLength
            \ ,typstCodeNumberAngle
            \ ,typstCodeNumberRatio
            \ ,typstCodeNumberFraction
            \ ,typstCodeString
syntax keyword typstCodeConstant
    \ contained
    \ none auto true false
syntax match typstCodeNumberInteger
    \ contained
    \ /\v<\d+>/
syntax match typstCodeNumberFloat
    \ contained
    \ /\v<\d+\.\d*>/
syntax match typstCodeNumberLength
    \ contained
    \ /\v<\d+(\.\d*)?(pt|mm|cm|in|em)>/
syntax match typstCodeNumberAngle
    \ contained
    \ /\v<\d+(\.\d*)?(deg|rad)>/
syntax match typstCodeNumberRatio
    \ contained
    \ /\v<\d+(\.\d*)?\%/
syntax match typstCodeNumberFraction
    \ contained
    \ /\v<\d+(\.\d*)?fr>/
syntax region typstCodeString
    \ contained
    \ start=/"/ skip=/\v\\\\|\\"/ end=/"/
    \ contains=@Spell

syntax cluster typstCodeIdentifiers
    \ contains=typstCodeIdentifier
            \ ,typstCodeFieldAccess
syntax match typstCodeIdentifier
    \ contained
    \ /\v\K\k*%(-+\k+)*>-@!(<%(let|set|show|import|include))@<![\.\[\(]@!/
syntax match typstCodeFieldAccess
    \ contained
    \ /\v\K\k*%(-+\k+)*>-@!(<%(let|set|show|import|include))@<!\.[\[\(]@!/
    \ nextgroup=typstCodeFieldAccess,typstCodeFunction

syntax cluster typstCodeFunctions
    \ contains=typstCodeFunction
syntax match typstCodeFunction
    \ contained
    \ /\v\K\k*%(-+\k+)*[\(\[]@=/
    \ nextgroup=typstCodeFunctionArgument
syntax match typstCodeFunctionArgument
    \ contained
    \ /\v%(.{-}%(\(.{-}\)|\[.{-}\]|\{.{-}\}))*/ transparent
    \ contains=@typstCode

syntax cluster typstCodeParens
    \ contains=typstCodeParen
            \ ,typstCodeBrace
            \ ,typstCodeBracket
            \ ,typstCodeDollar
syntax region typstCodeParen
    \ contained
    \ matchgroup=Noise start=/\v\(/ end=/\v\)/
    \ contains=@typstCode
syntax region typstCodeBrace
    \ contained
    \ matchgroup=Noise start=/\v\{/ end=/\v\}/
    \ contains=@typstCode
syntax region typstCodeBracket
    \ contained
    \ matchgroup=Noise start=/\v\[/ end=/\v\]/
    \ contains=@typstMarkup
syntax region typstCodeDollar
    \ contained
    \ matchgroup=Number start=/\v\$/ end=/\v\$/
    \ contains=@typstMath


syntax cluster typstHashtag
    \ contains=@typstHashtagKeywords
            \ ,@typstHashtagConstants
            \ ,@typstHashtagIdentifiers
            \ ,@typstHashtagFunctions
            \ ,@typstHashtagParens

syntax cluster typstHashtagKeywords
    \ contains=typstHashtagConditional
            \ ,typstHashtagRepeat
            \ ,typstHashtagKeywords
            \ ,typstHashtagStatement
syntax match typstHashtagConditional
    \ /\v#if>-@!/
    \ skipwhite nextgroup=@typstCode
syntax match typstHashtagRepeat
    \ /\v#(while|for)>-@!/
    \ skipwhite nextgroup=@typstCode
syntax match typstHashtagKeyword
    \ /\v#(return)>-@!/
    \ skipwhite nextgroup=@typstCode
syntax region typstHashtagStatement
    \ matchgroup=typstHashtagStatementWord start=/\v#(let|set|show|import|include)>-@!/ end=/\v%(;|$)/
    \ contains=@typstCode

syntax cluster typstHashtagConstants
    \ contains=typstHashtagConstant
syntax match typstHashtagConstant
    \ /\v#(none|auto|true|false)>-@!/

syntax cluster typstHashtagIdentifiers
    \ contains=typstHashtagIdentifier
            \ ,typstHashtagFieldAccess
syntax match typstHashtagIdentifier
    \ /\v#\K\k*%(-+\k+)*>-@!(<%(let|set|show|import|include|if|while|for|return))@<![\.\[\(]@!/
syntax match typstHashtagFieldAccess
    \ /\v#\K\k*%(-+\k+)*>-@!(<%(let|set|show|import|include|if|while|for|return))@<!\.[\[\(]@!/
    \ nextgroup=typstCodeFieldAccess,typstCodeFunction

syntax cluster typstHashtagFunctions
    \ contains=typstHashtagFunction
syntax match typstHashtagFunction
    \ /\v#\K\k*%(-+\k+)*[\(\[]@=/
    \ nextgroup=typstCodeFunctionArgument

syntax cluster typstHashtagParens
    \ contains=typstHashtagParen
            \ ,typstHashtagBrace
            \ ,typstHashtagBracket
            \ ,typstHashtagDollar
syntax region typstHashtagParen
    \ matchgroup=Noise start=/\v\#\(/ end=/\v\)/
    \ contains=@typstCode
syntax region typstHashtagBrace
    \ matchgroup=Noise start=/\v\#\{/ end=/\v\}/
    \ contains=@typstCode
syntax region typstHashtagBracket
    \ matchgroup=Noise start=/\v\#\[/ end=/\v\]/
    \ contains=@typstMarkup
syntax region typstHashtagDollar
    \ matchgroup=Noise start=/\v\#\$/ end=/\v\$/
    \ contains=@typstMath


syntax cluster typstMarkup
    \ contains=@typstCommon
            \ ,@Spell
            \ ,@typstHashtag
            \ ,@typstMarkupText
            \ ,@typstMarkupParens

syntax cluster typstMarkupText
    \ contains=typstMarkupRawInline
            \ ,typstMarkupRawBlock
            \ ,typstMarkupLabel
            \ ,typstMarkupReference
            \ ,typstMarkupHeading
            \ ,typstMarkupBulletList
            \ ,typstMarkupEnumList
            \ ,typstMarkupBold
            \ ,typstMarkupItalic
            \ ,typstMarkupLinebreak
            \ ,typstMarkupNonbreakingSpace
            \ ,typstMarkupShy
            \ ,typstMarkupDash
            \ ,typstMarkupEllipsis
            \ ,typstMarkupTermList

syntax match typstMarkupRawInline
    \ /`.\{-}`/
syntax region typstMarkupRawBlock
    \ start=/```/ end=/```/
syntax match typstMarkupLabel
    \ /\v\<\K%(\k*-*)*\>/
syntax match typstMarkupReference
    \ /\v\@\K%(\k*-*)*/
syntax match typstMarkupHeading
    \ /^=\{1,6}\s.*$/
syntax match typstMarkupBulletList
    \ /\v^\s*-\s+/
syntax match typstMarkupEnumList
    \ /\v^\s*(\+|\d+\.)\s+/
syn region typstMarkupItalic
    \ matchgroup=typstMarkupItalicDelimiter start=/\w\@<!_\S\@=/ skip=/\\_/ end=/\S\@<=_\w\@!\|^$/
syn region typstMarkupBold
    \ matchgroup=typstMarkupBoldDelimiter start=/\*\S\@=/ skip=/\\\*/ end=/\S\@<=\*\|^$/
syntax match typstMarkupLinebreak
    \ /\\\\/
syntax match typstMarkupNonbreakingSpace
    \ /\~/
syntax match typstMarkupShy
    \ /-?/
syntax match typstMarkupDash
    \ /-\{2,3}/
syntax match typstMarkupEllipsis
    \ /\.\.\./
syntax match typstMarkupTermList
    \ #\v^\s*\/\s+[^:]*:#
syntax cluster typstMarkupParens
    \ contains=typstMarkupDollar
syntax region typstMarkupDollar
    \ matchgroup=Number start=/\$/ end=/\$/
    \ contains=@typstMath


syntax cluster typstMath
    \ contains=@typstCommon
            \ ,@typstHashtag



highlight default link typstCommentBlock            Comment
highlight default link typstCommentLine             Comment
highlight default link typstCommentTodo             Todo
highlight default link typstCodeConditional         Conditional
highlight default link typstCodeRepeat              Repeat
highlight default link typstCodeKeyword             Keyword
highlight default link typstCodeConstant            Constant
highlight default link typstCodeNumberInteger       Number
highlight default link typstCodeNumberFloat         Number
highlight default link typstCodeNumberLength        Number
highlight default link typstCodeNumberAngle         Number
highlight default link typstCodeNumberRatio         Number
highlight default link typstCodeNumberFraction      Number
highlight default link typstCodeString              String
highlight default link typstCodeStatementWord       Statement
highlight default link typstCodeIdentifier          Identifier
highlight default link typstCodeFieldAccess         Identifier
highlight default link typstCodeFunction            Function
highlight default link typstCodeParen               Noise
highlight default link typstCodeBrace               Noise
highlight default link typstCodeBracket             Noise
highlight default link typstCodeDollar              Noise
highlight default link typstHashtagConditional      Conditional
highlight default link typstHashtagRepeat           Repeat
highlight default link typstHashtagKeyword          Keyword
highlight default link typstHashtagConstant         Constant
highlight default link typstHashtagStatementWord    Statement
highlight default link typstHashtagIdentifier       Identifier
highlight default link typstHashtagFieldAccess      Identifier
highlight default link typstHashtagFunction         Function
highlight default link typstHashtagParen            Noise
highlight default link typstHashtagBrace            Noise
highlight default link typstHashtagBracket          Noise
highlight default link typstHashtagDollar           Noise
highlight default link typstMarkupRawInline         Macro
highlight default link typstMarkupRawBlock          Macro
highlight default link typstMarkupLabel             Structure
highlight default link typstMarkupReference         Structure
highlight default link typstMarkupBulletList        Structure
highlight default link typstMarkupEnumList          Structure
highlight default link typstMarkupLinebreak         Structure
highlight default link typstMarkupNonbreakingSpace  Structure
highlight default link typstMarkupShy               Structure
highlight default link typstMarkupDash              Structure
highlight default link typstMarkupEllipsis          Structure
highlight default link typstMarkupTermList          Structure
highlight default link typstMarkupDollar            Noise

highlight default typstMarkupHeading                    term=underline,bold     cterm=underline,bold    gui=underline,bold
highlight default typstMarkupBold                       term=bold               cterm=bold              gui=bold
highlight default typstMarkupItalic                     term=italic             cterm=italic            gui=italic

highlight default link typstMarkupBoldDelimiter         typstMarkupBold
highlight default link typstMarkupItalicDelimiter       typstMarkupItalic




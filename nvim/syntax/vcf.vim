"General idea:
" highlights per column
" Some kind of alternating gray for info column or for keys?
"
"if exists('b:current_syntax') | finish|  endif

"syntax match header "##.*"
"syntax match chromHeader "#CHROM" nextgroup=posHeader
"syntax match chrom "^[^\t#]\+" nextgroup=pos
"syntax match posHeader "^\t]\+" contained
"syntax match pos "[^\t]\+"

"syntax region record start="^[^#]" end="$" contains=chrom,pos
"
"syntax match chrom "^[^#\t]*" nextgroup=pos containedin=record
"syntax match pos "[\t ][^\t]\+" nextgroup=id containedin=record
"syntax match id "[\t ][^\t]\+" nextgroup=ref containedin=record
"syntax match ref "[\t ][^\t]\+" nextgroup=alt containedin=record
"syntax match alt "[\t ][^\t]\+" nextgroup=qual containedin=record
"syntax match qual "[\t ][^\t]\+" nextgroup=filter containedin=record
"syntax match filter "[\t ][^\t]\+" nextgroup=infoInit containedin=record
"
"syntax match infoInit "[\t ][^;]\+" nextgroup=infoAlt containedin=record
"syntax match format "[\t ][^\t]\+" nextgroup=samples containedin=record

"syntax region header start="^##" end="$"
"
"syntax match generalInfo "^##.*$" containedin=header


" TODO alternate samples???

"hi def link generalInfo SpecialKey
"
"hi def link chrom Constant
"hi def link pos String
"hi def link id Operator
"hi def link ref @string.escape
"hi def link alt Typedef
"hi def link qual Error
"hi def link filter Removed
"hi def link infoInit SpecialKey

highlight clear

if exists("syntax_on")
  syntax reset
endif

set background=dark
let g:colors_name = "cyberpunk"

function! HighlightFor(group, fg, bg, attr)
  execute "hi ".a:group " guifg=".a:fg " guibg=".a:bg " gui=".a:attr
endfunction

" general
call HighlightFor("Normal", "@text.main@", "@base.bg@", "NONE")
call HighlightFor("Visual", "NONE", "@surface.selection@", "NONE")
call HighlightFor("ColorColumn", "NONE", "@surface.column_bg@", "NONE")
call HighlightFor("LineNr", "@text.main@", "NONE", "NONE")
call HighlightFor("SignColumn", "@accents.cyan@", "NONE", "NONE")

call HighlightFor("DiffAdd", "NONE", "NONE", "NONE")
call HighlightFor("DiffDelete", "NONE", "@accents.diff_delete@", "NONE")
call HighlightFor("DiffText", "NONE", "@accents.diff_text@", "NONE")
call HighlightFor("DiffChange", "NONE", "NONE", "NONE")

call HighlightFor("VertSplit", "@text.main@", "@surface.vert_split@", "NONE")

call HighlightFor("IncSearch", "NONE", "@surface.search_bg@", "NONE")
call HighlightFor("Search", "NONE", "@surface.search_bg@", "NONE")
call HighlightFor("Substitute", "NONE", "@surface.search_bg@", "NONE")

call HighlightFor("MatchParen", "@text.main@", "@accents.cyan@", "NONE")
call HighlightFor("NonText", "@surface.non_text@", "NONE", "NONE")
call HighlightFor("Whitespace", "@surface.non_text@", "NONE", "NONE")

call HighlightFor("WildMenu", "@accents.cyan@", "NONE", "bold")
call HighlightFor("Directory", "@accents.cyan@", "NONE", "NONE")
call HighlightFor("Title", "@text.heading@", "NONE", "NONE")

" Cursor
call HighlightFor("Cursor", "@accents.cyan@", "NONE", "NONE")
call HighlightFor("CursorLineNr", "@base.bg_deep@", "@accents.cyan@", "NONE")

" Cursorline - preserve conditional logic
if exists("g:cyberpunk_cursorline") && g:cyberpunk_cursorline == "black"
call HighlightFor("CursorLine", "NONE", "@base.bg_dark@", "NONE")
else
call HighlightFor("CursorLine", "@base.bg_deep@", "@text.main@", "NONE")
endif

call HighlightFor("CursorColumn", "NONE", "NONE", "NONE")

" Code
call HighlightFor("Comment", "@text.muted@", "NONE", "NONE")
call HighlightFor("String", "@accents.blue@", "NONE", "NONE")
call HighlightFor("Number", "@accents.yellow@", "NONE", "NONE")
call HighlightFor("Float", "@accents.yellow@", "NONE", "NONE")
call HighlightFor("Boolean", "@accents.yellow@", "NONE", "NONE")
call HighlightFor("Character", "@accents.yellow@", "NONE", "NONE")

call HighlightFor("Conditional", "@accents.blue@", "NONE", "NONE")
call HighlightFor("Repeat", "@accents.blue@", "NONE", "NONE")
call HighlightFor("Label", "@accents.blue@", "NONE", "NONE")
call HighlightFor("Exception", "@accents.blue@", "NONE", "NONE")
call HighlightFor("Operator", "@accents.blue@", "NONE", "NONE")
call HighlightFor("Keyword", "@accents.blue@", "NONE", "NONE")
call HighlightFor("StorageClass", "@accents.purple@", "NONE", "NONE")
call HighlightFor("Statement", "@accents.blue@", "NONE", "NONE")

call HighlightFor("Function", "@accents.purple@", "NONE", "NONE")
call HighlightFor("Identifier", "@text.light@", "NONE", "NONE")

call HighlightFor("PreProc", "@accents.green@", "NONE", "NONE")

call HighlightFor("Type", "@accents.green@", "NONE", "NONE")
call HighlightFor("Structure", "@accents.green@", "NONE", "NONE")
call HighlightFor("Typedef", "@accents.green@", "NONE", "NONE")

call HighlightFor("Underlined", "NONE", "NONE", "NONE")
call HighlightFor("Todo", "@accents.green@", "@surface.todo_bg@", "italic")
call HighlightFor("Error", "@accents.red@", "NONE", "undercurl")
call HighlightFor("WarningMsg", "@accents.teal@", "NONE", "NONE")
call HighlightFor("Special", "@accents.green@", "NONE", "italic")
call HighlightFor("Tag", "@accents.green@", "NONE", "undercurl")

" Pmenu
call HighlightFor("Pmenu", "@text.main@", "@base.bg_deep@", "NONE")
call HighlightFor("PmenuSel", "@base.bg_deep@", "@text.main@", "NONE")
call HighlightFor("PmenuSbar", "NONE", "@text.main@", "NONE")
call HighlightFor("PmenuThumb", "NONE", "NONE", "NONE")

" Status line
call HighlightFor("StatusLine", "@text.main@", "@surface.status_bg@", "bold")
call HighlightFor("StatusLineNC", "@text.main@", "@base.bg_dark@", "NONE")

" Tab pages
call HighlightFor("TabLine", "@accents.pink@", "NONE", "NONE")
call HighlightFor("TabLineFill", "NONE", "NONE", "NONE")
call HighlightFor("TabLineSel", "@accents.pink@", "NONE", "bold")

" Folds
call HighlightFor("Folded", "@accents.cyan@", "NONE", "italic")
call HighlightFor("FoldColumn", "@accents.cyan@", "NONE", "NONE")

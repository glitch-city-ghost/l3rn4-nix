#!/usr/bin/env python3
"""
Generate Vim colorscheme + Airline theme from cyberpunk-palette.yaml
Output: themes/cyberpunk/vim/
"""

import sys
import re
from pathlib import Path

REPO_ROOT = Path(__file__).parent.parent
PALETTE_PATH = REPO_ROOT / "cyberpunk-palette.yaml"
OUT_DIR = REPO_ROOT / "themes" / "cyberpunk" / "vim"

# Minimal YAML loader for our specific palette format
def load_palette():
    with open(PALETTE_PATH, 'r') as f:
        content = f.read()
    
    # Parse line by line, handling inline comments properly
    lines = []
    for line in content.split('\n'):
        # Remove inline comments but preserve quoted strings
        in_quote = False
        result = []
        i = 0
        while i < len(line):
            if line[i] == '"':
                in_quote = not in_quote
                result.append(line[i])
            elif line[i] == '#' and not in_quote:
                break  # Rest of line is comment
            else:
                result.append(line[i])
            i += 1
        cleaned = ''.join(result).rstrip()
        if cleaned.strip():
            lines.append(cleaned)
    
    # Parse using regex for our known structure
    data = {}
    current_section = None
    
    for line in lines:
        stripped = line.strip()
        indent = len(line) - len(stripped)
        
        # Section header (e.g., "base:", "surface:")
        if stripped.endswith(':') and indent == 0:
            current_section = stripped[:-1]
            data[current_section] = {}
        # Key: "value" (2-space indent)
        elif indent == 2 and current_section:
            match = re.match(r'(\w+):\s*"([^"]*)"', stripped)
            if match:
                key, value = match.groups()
                data[current_section][key] = value
    
    return data

def hi(group, fg, bg, attr="NONE"):
    fg = fg if fg != "NONE" else "NONE"
    bg = bg if bg != "NONE" else "NONE"
    return f'call HighlightFor("{group}", "{fg}", "{bg}", "{attr}")'

def generate_colorscheme(p):
    base = p["base"]
    surface = p["surface"]
    text = p["text"]
    accents = p["accents"]

    lines = [
        "highlight clear",
        "",
        'if exists("syntax_on")',
        "  syntax reset",
        "endif",
        "",
        "set background=dark",
        'let g:colors_name = "cyberpunk"',
        "",
        'function! HighlightFor(group, fg, bg, attr)',
        '  execute "hi ".a:group " guifg=".a:fg " guibg=".a:bg " gui=".a:attr',
        "endfunction",
        "",
        '" general',
        hi("Normal",        text["main"],    base["bg"]),
        hi("Visual",        "NONE",          surface["selection"]),
        hi("ColorColumn",   "NONE",          surface["column_bg"]),
        hi("LineNr",        text["main"],    "NONE"),
        hi("SignColumn",    accents["cyan"], "NONE"),
        "",
        hi("DiffAdd",       "NONE", "NONE"),
        hi("DiffDelete",    "NONE", accents["diff_delete"]),
        hi("DiffText",      "NONE", accents["diff_text"]),
        hi("DiffChange",    "NONE", "NONE"),
        "",
        hi("VertSplit",     text["main"], surface["vert_split"]),
        "",
        hi("IncSearch",     "NONE", surface["search_bg"]),
        hi("Search",        "NONE", surface["search_bg"]),
        hi("Substitute",    "NONE", surface["search_bg"]),
        "",
        hi("MatchParen",    text["main"], accents["cyan"]),
        hi("NonText",       surface["non_text"], "NONE"),
        hi("Whitespace",    surface["non_text"], "NONE"),
        "",
        hi("WildMenu",      accents["cyan"], "NONE", "bold"),
        hi("Directory",     accents["cyan"], "NONE"),
        hi("Title",         text["heading"], "NONE"),
        "",
        '" Cursor',
        hi("Cursor",        accents["cyan"], "NONE"),
        hi("CursorLineNr",  base["bg_deep"], accents["cyan"]),
        "",
        '" Cursorline - preserve conditional logic',
        'if exists("g:cyberpunk_cursorline") && g:cyberpunk_cursorline == "black"',
        hi("CursorLine", "NONE", base["bg_dark"]),
        "else",
        hi("CursorLine", base["bg_deep"], text["main"]),
        "endif",
        "",
        hi("CursorColumn", "NONE", "NONE"),
        "",
        '" Code',
        hi("Comment",      text["muted"], "NONE"),
        hi("String",       accents["blue"], "NONE"),
        hi("Number",       accents["yellow"], "NONE"),
        hi("Float",        accents["yellow"], "NONE"),
        hi("Boolean",      accents["yellow"], "NONE"),
        hi("Character",    accents["yellow"], "NONE"),
        "",
        hi("Conditional",  accents["blue"], "NONE"),
        hi("Repeat",       accents["blue"], "NONE"),
        hi("Label",        accents["blue"], "NONE"),
        hi("Exception",    accents["blue"], "NONE"),
        hi("Operator",     accents["blue"], "NONE"),
        hi("Keyword",      accents["blue"], "NONE"),
        hi("StorageClass", accents["purple"], "NONE"),
        hi("Statement",    accents["blue"], "NONE"),
        "",
        hi("Function",     accents["purple"], "NONE"),
        hi("Identifier",   text["light"], "NONE"),
        "",
        hi("PreProc",      accents["green"], "NONE"),
        "",
        hi("Type",         accents["green"], "NONE"),
        hi("Structure",    accents["green"], "NONE"),
        hi("Typedef",      accents["green"], "NONE"),
        "",
        hi("Underlined",   "NONE", "NONE"),
        hi("Todo",         accents["green"], surface["todo_bg"], "italic"),
        hi("Error",        accents["red"], "NONE", "undercurl"),
        hi("WarningMsg",   accents["teal"], "NONE"),
        hi("Special",      accents["green"], "NONE", "italic"),
        hi("Tag",          accents["green"], "NONE", "undercurl"),
        "",
        '" Pmenu',
        hi("Pmenu",      text["main"], base["bg_deep"]),
        hi("PmenuSel",   base["bg_deep"], text["main"]),
        hi("PmenuSbar",  "NONE", text["main"]),
        hi("PmenuThumb", "NONE", "NONE"),
        "",
        '" Status line',
        hi("StatusLine",   text["main"], surface["status_bg"], "bold"),
        hi("StatusLineNC", text["main"], base["bg_dark"]),
        "",
        '" Tab pages',
        hi("TabLine",     accents["pink"], "NONE"),
        hi("TabLineFill", "NONE", "NONE"),
        hi("TabLineSel",  accents["pink"], "NONE", "bold"),
        "",
        '" Folds',
        hi("Folded",     accents["cyan"], "NONE", "italic"),
        hi("FoldColumn", accents["cyan"], "NONE"),
    ]
    return "\n".join(lines)

def generate_airline(p):
    base = p["base"]
    surface = p["surface"]
    text = p["text"]
    accents = p["accents"]

    # Airline uses #EF4B51 for red accent (brighter than our accents.red)
    airline_red = "#EF4B51"

    return f'''function! airline#themes#cyberpunk#refresh()

  if get(g:, 'cyberpunk_termcolors', 256) == 16
    let s:term_red = 1
    let s:term_green = 2
    let s:term_yellow = 3
    let s:term_blue = 4
    let s:term_purple = 5
    let s:term_white = 7
    let s:term_black = 0
    let s:term_grey = 8
  else
    let s:term_red = 123
    let s:term_green = 10
    let s:term_yellow = 226
    let s:term_blue = 81
    let s:term_purple = 170
    let s:term_white = 15
    let s:term_black = 0
    let s:term_grey = 236
  endif

  let g:airline#themes#cyberpunk#palette = {{}}

  let g:airline#themes#cyberpunk#palette.accents = {{
        \\ 'red': [ '{airline_red}', '', s:term_red, 0 ]
        \\ }}

  let s:N1 = [ '{base["bg_deep"]}', '{text["main"]}', s:term_black, s:term_red ]
  let s:N2 = [ '{text["main"]}', '{surface["vert_split"]}', s:term_black, s:term_red ]
  let s:N3 = [ '{text["main"]}', '{base["bg_deep"]}', s:term_green, s:term_grey ]
  let g:airline#themes#cyberpunk#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)

  let group = airline#themes#get_highlight('vimCommand')
  let g:airline#themes#cyberpunk#palette.normal_modified = {{
        \\ 'airline_c': [ group[0], '', group[2], '', '' ]
        \\ }}

  let s:I1 = [ '{base["bg_deep"]}', '{accents["blue"]}', s:term_black, s:term_blue ]
  let s:I2 = s:N2
  let s:I3 = [ '{accents["blue"]}', '{base["bg_deep"]}', s:term_blue, s:term_grey ]
  let g:airline#themes#cyberpunk#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
  let g:airline#themes#cyberpunk#palette.insert_modified = g:airline#themes#onedark#palette.normal_modified

  let s:R1 = [ '{base["bg_deep"]}', '{accents["yellow"]}', s:term_black, s:term_red ]
  let s:R2 = s:N2
  let s:R3 = [ '{accents["yellow"]}', '{base["bg_deep"]}', s:term_red, s:term_grey ]
  let g:airline#themes#cyberpunk#palette.replace = airline#themes#generate_color_map(s:R1, s:R2, s:R3)
  let g:airline#themes#cyberpunk#palette.replace_modified = g:airline#themes#onedark#palette.normal_modified

  let s:V1 = [ '{base["bg_deep"]}', '{accents["purple"]}', s:term_black, s:term_purple ]
  let s:V2 = s:N2
  let s:V3 = [ '{accents["purple"]}', '{base["bg_deep"]}', s:term_purple, '' ]
  let g:airline#themes#cyberpunk#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)
  let g:airline#themes#cyberpunk#palette.visual_modified = g:airline#themes#onedark#palette.normal_modified

  let s:IA1 = [ '{base["bg_deep"]}', '{text["main"]}', s:term_black, s:term_white ]
  let s:IA2 = [ '{text["main"]}', '{base["bg_deep"]}', s:term_white, s:term_grey ]
  let s:IA3 = s:N2
  let g:airline#themes#cyberpunk#palette.inactive = airline#themes#generate_color_map(s:IA1, s:IA2, s:IA3)
  let g:airline#themes#cyberpunk#palette.inactive_modified = {{
        \\ 'airline_c': [ group[0], '', group[2], '', '' ]
        \\ }}

  let s:WI = [ '{text["main"]}', '{base["bg_deep"]}', s:term_black, s:term_yellow ]
  let g:airline#themes#cyberpunk#palette.normal.airline_warning = [ s:WI[0], s:WI[1], s:WI[2], s:WI[3] ]
  let g:airline#themes#cyberpunk#palette.normal_modified.airline_warning = g:airline#themes#cyberpunk#palette.normal.airline_warning
  let g:airline#themes#cyberpunk#palette.insert.airline_warning = g:airline#themes#cyberpunk#palette.normal.airline_warning
  let g:airline#themes#cyberpunk#palette.insert_modified.airline_warning = g:airline#themes#cyberpunk#palette.normal.airline_warning
  let g:airline#themes#cyberpunk#palette.visual.airline_warning = g:airline#themes#cyberpunk#palette.normal.airline_warning
  let g:airline#themes#cyberpunk#palette.visual_modified.airline_warning = g:airline#themes#cyberpunk#palette.normal.airline_warning
  let g:airline#themes#cyberpunk#palette.replace.airline_warning = g:airline#themes#cyberpunk#palette.normal.airline_warning
  let g:airline#themes#cyberpunk#palette.replace_modified.airline_warning = g:airline#themes#cyberpunk#palette.normal.airline_warning

  let s:ER = [ '{text["main"]}', '{base["bg_deep"]}', s:term_black, s:term_red ]
  let g:airline#themes#cyberpunk#palette.normal.airline_error = [ s:ER[0], s:ER[1], s:ER[2], s:ER[3] ]
  let g:airline#themes#cyberpunk#palette.normal_modified.airline_error = g:airline#themes#cyberpunk#palette.normal.airline_error
  let g:airline#themes#cyberpunk#palette.insert.airline_error = g:airline#themes#cyberpunk#palette.normal.airline_error
  let g:airline#themes#cyberpunk#palette.insert_modified.airline_error = g:airline#themes#cyberpunk#palette.normal.airline_error
  let g:airline#themes#cyberpunk#palette.visual.airline_error = g:airline#themes#cyberpunk#palette.normal.airline_error
  let g:airline#themes#cyberpunk#palette.visual_modified.airline_error = g:airline#themes#cyberpunk#palette.normal.airline_error
  let g:airline#themes#cyberpunk#palette.replace.airline_error = g:airline#themes#cyberpunk#palette.normal.airline_error
  let g:airline#themes#cyberpunk#palette.replace_modified.airline_error = g:airline#themes#cyberpunk#palette.normal.airline_error

endfunction

call airline#themes#cyberpunk#refresh()
'''

def main():
    palette = load_palette()
    
    # Ensure output directories exist
    colors_dir = OUT_DIR / "colors"
    airline_dir = OUT_DIR / "autoload" / "airline" / "themes"
    colors_dir.mkdir(parents=True, exist_ok=True)
    airline_dir.mkdir(parents=True, exist_ok=True)
    
    # Generate colorscheme
    colorscheme = generate_colorscheme(palette)
    (colors_dir / "cyberpunk.vim").write_text(colorscheme)
    
    # Generate Airline theme
    airline = generate_airline(palette)
    (airline_dir / "cyberpunk.vim").write_text(airline)
    
    print(f"✅ Generated Vim theme in {OUT_DIR}")
    print(f"   - {colors_dir}/cyberpunk.vim")
    print(f"   - {airline_dir}/cyberpunk.vim")

if __name__ == "__main__":
    main()
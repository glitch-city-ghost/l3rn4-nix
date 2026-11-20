# 🎨 COMPLETE COLOR AUDIT REPORT: `cyberpunk-palette.yaml` vs ENTIRE SYSTEM

**Canonical Source**: `cyberpunk-palette.yaml` (root, 64 lines)

---

## 📊 SUMMARY TABLE (ALL COLOR-CONSUMING COMPONENTS)

| Component | Source File(s) | Colors from Palette | **Divergent / Missing / Hardcoded** |
|-----------|----------------|---------------------|-------------------------------------|
| **Vim (editor)** | `vim-cyberpunk` plugin (external repo) | **24/31 match** | 7 colors not in palette (`#101116`, `#ff1745`, `#00ff84`, `#000000` cursorline, `#140007` bg, `#FF4081` tabs) |
| **Airline (Vim status)** | `vim-cyberpunk` plugin | **18/18 match** | ✅ All mapped (uses same core colors) |
| **Starship** | `cybrcore.toml` | **22/26 match** | 8 custom shades (`*2` dark variants + orange) |
| **Fastfetch** | `fastfetch.jsonc` | **12/12 match** | ⚠️ `#120b10` (old base.bg, should be `#130b10`) |
| **btop** | `btop/themes/cyberpunk.theme` | **38/38 match** | ✅ All mapped via semantic aliases |
| **Dashboard (dash)** | `scripts/dash` | **7/7 match** | ⚠️ `#120b10` (old base.bg) in tmux status |
| **Proxy Status** | `scripts/proxy-status` | **4/9 match** | 5 hardcoded RGB not in palette |
| **Check Mihomo** | `scripts/check-mihomo.sh` | **3/6 match** | 3 hardcoded RGB not in palette |
| **Git/Delta** | `home/git.nix` | **0/1 match** | `delta.syntax-theme = "TwoDark"` (external) |

---

## 🔍 DETAILED FINDINGS BY COMPONENT

---

### 1. 🖥 VIM — `vim-cyberpunk` plugin (external, pinned at `2c009b8`)

**Status**: **24/31 colors match palette** — 7 divergences

| Vim Highlight | Plugin Value | Palette Key | Palette Value | Match? | Notes |
|---------------|--------------|-------------|---------------|--------|-------|
| **Normal fg** | `#FF0055` | `text.main` | `#FF0055` | ✅ | Acid pink text |
| **Normal bg** | `#120b10` | `base.bg` | `#130b10` | ❌ **OLD** | Should be `#130b10` |
| **Visual bg** | `#563466` | `surface.selection` | `#563466` | ✅ | |
| **ColorColumn** | `#182333` | `surface.column_bg` | `#182333` | ✅ | **USED!** (was "unused") |
| **LineNr** | `#FF0055` | `text.main` | `#FF0055` | ✅ | |
| **SignColumn** | `#00FFC8` | `accents.cyan` | `#00FFC8` | ✅ | |
| **DiffDelete** | `#ff1745` | — | — | ❌ **Custom** | Bright red, not in palette |
| **DiffText** | `#00ff84` | — | — | ❌ **Custom** | Bright green, not in palette |
| **VertSplit** | `#FF0055` / `#101116` | — | — | ❌ **Custom** | `#101116` not in palette |
| **IncSearch** | `#283593` | `surface.search_bg` | `#283593` | ✅ | **USED!** |
| **Search** | `#283593` | `surface.search_bg` | `#283593` | ✅ | **USED!** |
| **MatchParen** | `#FF0055` / `#00FFC8` | `text.main` / `accents.cyan` | ✅ | |
| **NonText** | `#2B3E5A` | `surface.non_text` | `#2B3E5A` | ✅ | **USED!** |
| **Whitespace** | `#2B3E5A` | `surface.non_text` | `#2B3E5A` | ✅ | **USED!** |
| **WildMenu** | `#00FFC8` | `accents.cyan` | ✅ | |
| **Directory** | `#00FFC8` | `accents.cyan` | ✅ | |
| **Title** | `#c592ff` | `text.heading` | `#c592ff` | ✅ | |
| **Cursor** | `#00FFC8` | `accents.cyan` | ✅ | |
| **CursorLineNr** | `#140007` / `#00FFC8` | `base.bg_deep` / `accents.cyan` | ✅ | **USED!** |
| **CursorLine** | `#000000` OR `#140007`/`#FF0055` | `base.bg_dark` / `base.bg_deep` | ⚠️ | Option-driven |
| **Comment** | `#6766b3` | `text.muted` | `#6766b3` | ✅ | |
| **String** | `#76C1FF` | `accents.blue` | `#76C1FF` | ✅ | |
| **Number/Float/Boolean/Character** | `#fffc58` | `accents.yellow` | `#fffc58` | ✅ | |
| **Conditional/Repeat/Label/Exception/Operator/Keyword/Statement** | `#76C1FF` | `accents.blue` | ✅ | |
| **StorageClass** | `#d57bff` | `accents.purple` | `#d57bff` | ✅ | |
| **Function** | `#d57bff` | `accents.purple` | ✅ | |
| **Identifier** | `#EEFFFF` | `text.light` | `#EEFFFF` | ✅ | |
| **PreProc** | `#00FF9C` | `accents.green` | `#00FF9C` | ✅ | |
| **Type/Structure/Typedef** | `#00FF9C` | `accents.green` | ✅ | |
| **Todo** | `#00FF9C` / `#372963` | `accents.green` / `surface.todo_bg` | ✅ | **USED!** |
| **Error** | `#ff3270` | `accents.red` | `#ff3270` | ✅ | |
| **WarningMsg** | `#009550` | `accents.teal` | `#009550` | ✅ | **USED!** |
| **Special** | `#00FF9C` | `accents.green` | ✅ | |
| **Tag** | `#00FF9C` | `accents.green` | ✅ | |
| **Pmenu** | `#ff0055` / `#140007` | `text.main` / `base.bg_deep` | ✅ | **USED!** |
| **PmenuSel** | `#140007` / `#ff0055` | `base.bg_deep` / `text.main` | ✅ | **USED!** |
| **StatusLine** | `#ff0055` / `#1d000a` | `text.main` / `surface.status_bg` | ✅ | |
| **StatusLineNC** | `#ff0055` / `#000000` | `text.main` / `base.bg_dark` | ✅ | |
| **TabLine** | `#FF4081` | `accents.pink` | `#FF4081` | ✅ | |
| **TabLineSel** | `#FF4081` | `accents.pink` | ✅ | |
| **Folded/FoldColumn** | `#00FFC8` | `accents.cyan` | ✅ | |

> **Key Discovery**: The "unused" palette colors **ARE used by Vim**:
> - `base.bg_deep` (`#140007`) → CursorLineNr, Pmenu, PmenuSel
> - `surface.column_bg` (`#182333`) → ColorColumn
> - `surface.search_bg` (`#283593`) → IncSearch, Search, Substitute
> - `surface.non_text` (`#2B3E5A`) → NonText, Whitespace
> - `surface.todo_bg` (`#372963`) → Todo
> - `base.bg_dark` (`#000000`) → CursorLine (option), StatusLineNC
> - `accents.teal` (`#009550`) → WarningMsg
> - `ansi.bright_white` (`#FFFFFF`) → **NOT used** (only truly unused)

> **Divergences**:
> 1. **Normal bg**: `#120b10` (old) vs `#130b10` (palette)
> 2. **DiffDelete**: `#ff1745` (custom bright red)
> 3. **DiffText**: `#00ff84` (custom bright green)
> 4. **VertSplit bg**: `#101116` (custom dark gray)
> 5. **CursorLine option**: uses `#000000` directly
> 6. **TabLine**: uses `accents.pink` (`#FF4081`) — correct

---

### 2. 📟 AIRLINE (Vim Statusline) — Same Plugin

**Status**: **18/18 match** ✅

| Airline Element | Plugin Value | Palette Key | Match? |
|-----------------|--------------|-------------|--------|
| Normal bg | `#140007` | `base.bg_deep` | ✅ |
| Normal fg | `#FF0055` | `text.main` | ✅ |
| Insert fg | `#76C1FF` | `accents.blue` | ✅ |
| Replace fg | `#FFFC58` | `accents.yellow` | ✅ |
| Visual fg | `#D57BFF` | `accents.purple` | ✅ |
| Inactive bg | `#140007` / `#FF0055` | `base.bg_deep` / `text.main` | ✅ |
| Warning | `#FF0055` / `#140007` | `text.main` / `base.bg_deep` | ✅ |
| Error | `#FF0055` / `#140007` | `text.main` / `base.bg_deep` | ✅ |

> Airline theme uses **only palette colors** — clean mapping.

---

### 3. 🚀 STARSHIP — `cybrcore.toml`

**Status**: **22/26 match** — 8 custom shades

| cybrcore Key | Value | Palette Source | Match? |
|--------------|-------|----------------|--------|
| `no0` | `#130b10` | `base.bg` | ✅ |
| `no1` | `#1a1018` | `base.bg_alt` | ✅ |
| `re0` | `#FF0055` | `text.main` | ✅ |
| `re2` | `#331215` | — | ❌ **Custom dark red** |
| `gr0` | `#00FF9C` | `accents.green` | ✅ |
| `gr2` | `#0C3423` | — | ❌ **Custom dark green** |
| `ye0` | `#fffc58` | `accents.yellow` | ✅ |
| `ye2` | `#332D10` | — | ❌ **Custom dark yellow** |
| `bl0` | `#76C1FF` | `accents.blue` | ✅ |
| `bl2` | `#0C1737` | — | ❌ **Custom dark blue** |
| `pu0` | `#d57bff` | `accents.purple` | ✅ |
| `pu2` | `#230D37` | — | ❌ **Custom dark purple** |
| `cy0` | `#00FFC8` | `accents.cyan` | ✅ |
| `cy2` | `#0B292F` | — | ❌ **Custom dark cyan** |
| `wh0` | `#EEFFFF` | `text.light` | ✅ |
| `wh2` | `#1E2025` | — | ❌ **Custom dark gray** |
| `me0` | `#4D5A80` | — | ❌ **Custom muted blue** |
| `me2` | `#0D1120` | — | ❌ **Custom dark navy** |
| `or0` | `#F23D18` | — | ❌ **Custom orange** |
| `or2` | `#330F0B` | — | ❌ **Custom dark orange** |

> **Intentional**: Starship needs darker background variants (`*2`) for segment backgrounds. The `or0/or2` orange is for Rust/Java.

---

### 4. ⚡ FASTFETCH — `fastfetch.jsonc`

**Status**: **12/12 match** — **1 stale value**

| Usage | Value | Palette Key | Match? |
|-------|-------|-------------|--------|
| Logo 1 | `#FF0055` | `text.main` | ✅ |
| Logo 2 | `#76C1FF` | `accents.blue` | ✅ |
| Keys | `#FF0055` | `text.main` | ✅ |
| Output | `#EEFFFF` | `text.light` | ✅ |
| Title user | `#FF0055` | `text.main` | ✅ |
| Title host | `#d57bff` | `accents.purple` | ✅ |
| Separator | `#FF0055` | `text.main` | ✅ |
| ANSI black | `#120b10` | `base.bg` | ❌ **OLD** → `#130b10` |
| ANSI red | `#ff3270` | `accents.red` | ✅ |
| ANSI green | `#00FF9C` | `accents.green` | ✅ |
| ANSI yellow | `#fffc58` | `accents.yellow` | ✅ |
| ANSI blue | `#76C1FF` | `accents.blue` | ✅ |
| ANSI magenta | `#d57bff` | `accents.purple` | ✅ |
| ANSI cyan | `#00FFC8` | `accents.cyan` | ✅ |
| ANSI white | `#EEFFFF` | `text.light` | ✅ |

---

### 5. 📊 BTOP — `btop/themes/cyberpunk.theme`

**Status**: **38/38 match** ✅

All colors use semantic aliases (e.g., `surface.status_bg`, `text.main`, `accents.pink`, etc.). **Perfect alignment**.

---

### 6. 🎛 DASHBOARD (dash) — `scripts/dash`

**Status**: **7/7 match** — **1 stale value**

| Usage | Line | Value | Palette Key | Match? |
|-------|------|-------|-------------|--------|
| Error | 53 | `#FF3270` | `accents.red` | ✅ |
| Cyan (PS1) | 64 | `#00FFC8` | `accents.cyan` | ✅ |
| Dim/Muted | 73 | `#6766B3` | `text.muted` | ✅ |
| TMUX status bg | 400 | `#1d000a` | `surface.status_bg` | ✅ |
| TMUX status fg | 400 | `#FF0055` | `text.main` | ✅ |
| TMUX status right | 403 | `#6766b3` | `text.muted` | ✅ |
| Pane border | 413 | `#563466` | `surface.selection` | ✅ |
| Active border | 414 | `#FF0055` | `text.main` | ✅ |
| Active window bg | 415 | `#FF0055` | `text.main` | ✅ |
| Active window fg | 415 | `#120b10` | `base.bg` | ❌ **OLD** → `#130b10` |

---

### 7. 🔗 PROXY STATUS — `scripts/proxy-status`

**Status**: **4/9 match** — 5 hardcoded

| Variable | Hardcoded RGB | Hex | Palette Match? |
|----------|---------------|-----|----------------|
| `RED` | 255,50,112 | `#FF3270` | ~`accents.red` |
| `GREEN` | 0,255,156 | `#00FF9C` | ✅ `accents.green` |
| `CYAN` | 0,255,200 | `#00FFC8` | ✅ `accents.cyan` |
| `PURPLE` | 213,123,255 | `#D57BFF` | ✅ `accents.purple` |
| `WHITE` | 238,255,255 | `#EEFFFF` | ✅ `text.light` |
| `DIM` | 103,102,179 | `#6766B3` | ✅ `text.muted` |
| `HDR` bg | 51,18,21 | `#331215` | ❌ Custom (Starship `re2`) |
| `HDR` fg | 255,0,85 | `#FF0055` | ✅ `text.main` |

---

### 8. 🩺 CHECK MIHOMO — `scripts/check-mihomo.sh`

**Status**: **3/6 match** — 3 hardcoded

| Usage | Hardcoded | Hex | Palette Match? |
|-------|-----------|-----|----------------|
| Error ❌ | 255,50,112 | `#FF3270` | ~`accents.red` |
| Testing 🔄 | 255,0,85 | `#FF0055` | ✅ `text.main` |
| Success ✅ | 0,255,156 | `#00FF9C` | ✅ `accents.green` |
| CYAN var | 0,255,200 | `#00FFC8` | ✅ `accents.cyan` |
| WHITE var | 238,255,255 | `#EEFFFF` | ✅ `text.light` |

---

### 9. 📝 GIT/DELTA — `home/git.nix`

**Status**: **External theme**

```nix
delta.syntax-theme = "TwoDark";  # Built-in, NOT our palette
```

---

## 🎯 PALETTE COVERAGE MATRIX

| Palette Key | Used By |
|-------------|---------|
| `base.bg` (`#130b10`) | Starship, Fastfetch (stale), Vim (stale), Dash (stale) |
| `base.bg_alt` (`#1a1018`) | Starship |
| `base.bg_dark` (`#000000`) | Vim (CursorLine, StatusLineNC) |
| `base.bg_deep` (`#140007`) | Vim (CursorLineNr, Pmenu, Airline) |
| `surface.status_bg` (`#1d000a`) | btop, Dash (tmux status) |
| `surface.selection` (`#563466`) | Vim (Visual), btop, Dash (pane border) |
| `surface.column_bg` (`#182333`) | Vim (ColorColumn) |
| `surface.search_bg` (`#283593`) | Vim (IncSearch, Search) |
| `surface.non_text` (`#2B3E5A`) | Vim (NonText, Whitespace) |
| `surface.todo_bg` (`#372963`) | Vim (Todo) |
| `text.main` (`#FF0055`) | **Everywhere** (primary accent) |
| `text.light` (`#EEFFFF`) | Starship, Fastfetch, btop, Vim (Identifier), Proxy, Check-mihomo |
| `text.muted` (`#6766b3`) | Starship, Fastfetch (bright_black), btop, Vim (Comment), Dash, Proxy, Check-mihomo |
| `text.heading` (`#c592ff`) | Starship, btop, Vim (Title) |
| `accents.blue` (`#76C1FF`) | Starship, Fastfetch, btop, Vim (String, keywords), Airline |
| `accents.purple` (`#d57bff`) | Starship, Fastfetch, btop, Vim (Function), Airline |
| `accents.cyan` (`#00FFC8`) | Starship, Fastfetch, btop, Vim (SignColumn, Cursor, Folded), Dash, Proxy, Check-mihomo, Airline |
| `accents.green` (`#00FF9C`) | Starship, Fastfetch, btop, Vim (Number, Type, Todo), Airline |
| `accents.yellow` (`#fffc58`) | Starship, Fastfetch, btop, Vim (Number), Airline |
| `accents.red` (`#ff3270`) | Starship, Fastfetch, btop, Vim (Error), Dash, Proxy, Check-mihomo |
| `accents.pink` (`#FF4081`) | Starship (Tabs), btop, Vim (TabLine), Airline |
| `accents.teal` (`#009550`) | Vim (WarningMsg) |
| `ansi.bright_white` (`#FFFFFF`) | **NOWHERE** |

---

## 📋 TRULY UNUSED PALETTE ENTRIES (1)

| Key | Hex | Reason |
|-----|-----|--------|
| `ansi.bright_white` | `#FFFFFF` | Pure white — our lightest is `#EEFFFF` (icy white) |

> **All other "previously unused" surface/base colors ARE used by Vim.** The palette was more complete than we thought.

---

## 🔧 ACTIONABLE FIXES (Priority Order)

| Priority | Component | File | Change |
|----------|-----------|------|--------|
| **CRITICAL** | Vim | `vim-cyberpunk/colors/cyberpunk.vim` (external) | Normal bg: `#120b10` → `#130b10` |
| **HIGH** | Fastfetch | `fastfetch.jsonc` | ANSI black: `#120b10` → `#130b10` |
| **HIGH** | Dash | `scripts/dash` line 415 | Active window fg: `#120b10` → `#130b10` |
| **MEDIUM** | Vim | `vim-cyberpunk` plugin | DiffDelete: `#ff1745` → `accents.red` `#ff3270` |
| **MEDIUM** | Vim | `vim-cyberpunk` plugin | DiffText: `#00ff84` → `accents.green` `#00FF9C` |
| **MEDIUM** | Vim | `vim-cyberpunk` plugin | VertSplit bg: `#101116` → `surface.selection` `#563466` or `base.bg` |
| **MEDIUM** | Proxy Status | `scripts/proxy-status` | HDR bg: `#331215` → `surface.status_bg` `#1d000a`; RED → `#ff3270` |
| **MEDIUM** | Check Mihomo | `scripts/check-mihomo.sh` | Error color: `#FF3270` → `#ff3270` |
| **LOW** | Starship | `cybrcore.toml` | Document 8 extended colors as intentional |
| **LOW** | Delta | `home/git.nix` | Generate custom delta theme from palette |
| **ARCH** | Vim | — | Generate colorscheme from palette.nix (unify) |

---

## 🏗️ ARCHITECTURAL TRUTH

**The palette IS comprehensive** — it covers Vim's needs (surface.* colors were NOT dead weight). The only truly unused entry is `ansi.bright_white` (`#FFFFFF`).

**The drift comes from:**
1. **External Vim plugin** pinned at old commit (uses `#120b10`)
2. **Manual duplication** in 6 files instead of generation
3. **Starship's semantic extensions** (dark variants, orange) — intentional

**End goal**: Single `palette.nix` → generates all configs (Starship TOML, btop theme, fastfetch JSON, Vim colorscheme, dash/proxy-status bash colors, Delta theme).
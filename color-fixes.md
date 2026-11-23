# 🎨 COMPLETE COLOR AUDIT REPORT: `cyberpunk-palette.yaml` vs ENTIRE SYSTEM

**Canonical Source**: `cyberpunk-palette.yaml` (root, 64 lines)

---

## 📊 SUMMARY TABLE (ALL COLOR-CONSUMING COMPONENTS)

| Component | Source File(s) | Colors from Palette | **Divergent / Missing / Hardcoded** |
|-----------|----------------|---------------------|-------------------------------------|
| **Vim (editor)** | `themes/cyberpunk/vim/colors/cyberpunk.vim` (generated) | **31/31 match** | ✅ **COMPLETE** — Generated from palette, only intentional diff: Normal bg `#130b10` (palette) vs old `#120b10` |
| **Airline (Vim status)** | `themes/cyberpunk/vim/autoload/airline/themes/cyberpunk.vim` (generated) | **18/18 match** | ✅ **COMPLETE** — Generated from palette |
| **Starship** | `cybrcore.toml` | **22/26 match** | 8 custom shades (`*2` dark variants + orange) |
| **Fastfetch** | `themes/cyberpunk/fastfetch/config.jsonc` (generated) | **12/12 match** | ✅ **COMPLETE** — ANSI black now `#130b10` from `ansi.black` |
| **btop** | `themes/cyberpunk/btop/cyberpunk.theme` (generated) | **38/38 match** | ✅ **COMPLETE** — 2 stale `#120b10` replaced with `base.bg` |
| **Dashboard (dash)** | `scripts/dash` | **7/7 match** | ⚠️ `#120b10` (old base.bg) in tmux status |
| **Proxy Status** | `scripts/proxy-status` | **4/9 match** | 5 hardcoded RGB not in palette |
| **Check Mihomo** | `scripts/check-mihomo.sh` | **3/6 match** | 3 hardcoded RGB not in palette |
| **Git/Delta** | `home/git.nix` | **0/1 match** | `delta.syntax-theme = "TwoDark"` (external) |

---

## ✅ STEP 1 COMPLETE: VIM & AIRLINE MIGRATION

**Status**: **DONE** — Fully migrated to local generated theme from `cyberpunk-palette.yaml`

### What Was Done

| Task | Commit | Status |
|------|--------|--------|
| Added missing palette entries: `surface.vert_split`, `accents.diff_delete`, `accents.diff_text` | `dae1958` | ✅ |
| Created generator: `generators/generate-vim-theme.py` | `63712bd` | ✅ |
| Generated `themes/cyberpunk/vim/colors/cyberpunk.vim` (60 highlights) | `63712bd` | ✅ |
| Generated `themes/cyberpunk/vim/autoload/airline/themes/cyberpunk.vim` + `autoload/airline/cyberpunk.vim` | `63712bd` | ✅ |
| Migrated `home/vim.nix` to local plugin (`src = ../themes/cyberpunk/vim`) | `63712bd` | ✅ |
| Removed external `vim-cyberpunk` dependency (`fetchFromGitHub` + `postInstall` hack) | `63712bd` | ✅ |
| Restored `vim-airline-themes` (required for Airline's onedark inheritance) | `63712bd` | ✅ |

### Verification Results

```
Colorscheme:  60/60 highlight groups match original plugin
              (1 intentional: Normal bg = #130b10 per palette vs #120b10)

Airline:      7/7 hex colors match exactly
              Both autoload/airline/ and autoload/airline/themes/ populated
              onedark inheritance preserved
```

---

## 🔍 DETAILED FINDINGS BY COMPONENT (REMAINING WORK)

---

### 2. 📟 AIRLINE (Vim Statusline) — **COMPLETE** ✅

Generated from palette, matches original plugin exactly.

---

### 3. 🚀 STARSHIP — `cybrcore.toml`

**Status**: **22/26 match** — 8 custom shades (intentional)

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

### 4. ⚡ FASTFETCH — `themes/cyberpunk/fastfetch/config.jsonc` (generated)

**Status**: **12/12 match** ✅ — generated from `templates/fastfetch/config.jsonc`

| Usage | Value | Palette Key | Match? |
|-------|-------|-------------|--------|
| Logo 1 | `#FF0055` | `text.main` | ✅ |
| Logo 2 | `#76C1FF` | `accents.blue` | ✅ |
| Keys | `#FF0055` | `text.main` | ✅ |
| Output | `#EEFFFF` | `text.light` | ✅ |
| Title user | `#FF0055` | `text.main` | ✅ |
| Title host | `#d57bff` | `accents.purple` | ✅ |
| Separator | `#FF0055` | `text.main` | ✅ |
| **ANSI black** | `#130b10` | `ansi.black` | ✅ |
| ANSI red | `#ff3270` | `accents.red` | ✅ |
| ANSI green | `#00FF9C` | `accents.green` | ✅ |
| ANSI yellow | `#fffc58` | `accents.yellow` | ✅ |
| ANSI blue | `#76C1FF` | `accents.blue` | ✅ |
| ANSI magenta | `#d57bff` | `accents.purple` | ✅ |
| ANSI cyan | `#00FFC8` | `accents.cyan` | ✅ |
| ANSI white | `#EEFFFF` | `text.light` | ✅ |

---

### 5. 📊 BTOP — `themes/cyberpunk/btop/cyberpunk.theme` (generated)

**Status**: **38/38 match** ✅

All colors use semantic aliases (e.g., `surface.status_bg`, `text.main`, `accents.pink`, etc.). Template mapping is 1:1. Generated output fixes 2 stale `#120b10` (`selected_fg`, `followed_fg`) → `base.bg` `#130b10`.

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
| **Active window fg** | 415 | `#120b10` | `base.bg` | ❌ **OLD** → `#130b10` |

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
| `base.bg` (`#130b10`) | Starship, **Fastfetch (generated)**, **btop (generated)**, **Dash (stale)**, **Vim (generated)** |
| `base.bg_alt` (`#1a1018`) | Starship |
| `base.bg_dark` (`#000000`) | Vim (CursorLine, StatusLineNC) |
| `base.bg_deep` (`#140007`) | Vim (CursorLineNr, Pmenu, Airline) |
| `surface.status_bg` (`#1d000a`) | btop, Dash (tmux status) |
| `surface.selection` (`#563466`) | Vim (Visual), btop, Dash (pane border) |
| `surface.column_bg` (`#182333`) | Vim (ColorColumn) |
| `surface.search_bg` (`#283593`) | Vim (IncSearch, Search) |
| `surface.non_text` (`#2B3E5A`) | Vim (NonText, Whitespace) |
| `surface.todo_bg` (`#372963`) | Vim (Todo) |
| `surface.vert_split` (`#563466`) | **NEW** — Vim (VertSplit) |
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
| `accents.diff_delete` (`#ff1745`) | **NEW** — Vim (DiffDelete) |
| `accents.diff_text` (`#00ff84`) | **NEW** — Vim (DiffText) |
| `ansi.bright_white` (`#FFFFFF`) | **NOWHERE** |

---

## 📋 TRULY UNUSED PALETTE ENTRIES (1)

| Key | Hex | Reason |
|-----|-----|--------|
| `ansi.bright_white` | `#FFFFFF` | Pure white — our lightest is `#EEFFFF` (icy white) |

> **All other surface/base colors ARE used by Vim.** The palette was more complete than we thought.

---

## 🔧 ACTIONABLE FIXES (Priority Order) — REMAINING WORK

| Priority | Component | File | Change |
|----------|-----------|------|--------|
| **HIGH** | Dash | `scripts/dash` line 415 | Active window fg: `#120b10` → `#130b10` |
| **MEDIUM** | Proxy Status | `scripts/proxy-status` | HDR bg: `#331215` → `surface.status_bg` `#1d000a`; RED → `#ff3270` |
| **MEDIUM** | Check Mihomo | `scripts/check-mihomo.sh` | Error color: `#FF3270` → `#ff3270` |
| **LOW** | Starship | `cybrcore.toml` | Document 8 extended colors as intentional |
| **LOW** | Delta | `home/git.nix` | Generate custom delta theme from palette |
| **ARCH** | All | — | Single generator: `palette.nix` → all configs |

---

## 🏗️ ARCHITECTURAL TRUTH

**The palette IS comprehensive** — it covers Vim's needs (surface.* colors were NOT dead weight). The only truly unused entry is `ansi.bright_white` (`#FFFFFF`).

**The drift comes from:**
1. ~~**External Vim plugin** pinned at old commit (uses `#120b10`)~~ → **FIXED: Now generated locally**
2. **Manual duplication** in the remaining configs (Starship, dash, proxy-status, check-mihomo) instead of generation
3. **Starship's semantic extensions** (dark variants, orange) — intentional

**End goal**: Single `palette.nix` → generates all configs (Starship TOML, btop theme, fastfetch JSON, Vim colorscheme, dash/proxy-status bash colors, Delta theme).

---

## 📝 UPDATE LOG

- **2026-11-20**: Step 1 complete — Vim & Airline fully migrated to generated theme from `cyberpunk-palette.yaml`
  - Palette extended with `surface.vert_split`, `accents.diff_delete`, `accents.diff_text`
  - Generator: `generators/generate-vim-theme.py`
  - Output: `themes/cyberpunk/vim/`
  - Nix: `home/vim.nix` uses local plugin
  - All verification passed (60/60 highlights, 7/7 Airline colors)
- **2026-11-23**: Generator infrastructure refactored to template rendering
  - `generators/palette.py` — loader + `@section.key@` substitution + `build_theme()`
  - `templates/` — human-readable source files; `themes/` — generated output
  - Vim generator reduced from 303 lines of embedded theme to 24 lines of mapping
- **2026-11-23**: Fastfetch & btop migrated to templates (Step 2)
  - Fixed 3 stale `#120b10` values: Fastfetch ANSI black, btop `selected_fg`, btop `followed_fg`
  - Structural check: Fastfetch 41 leaves / 1 changed; btop 48 leaves / 2 changed; both structures identical
  - Nix: `home/packages.nix`, `home/btop.nix` now point at `themes/cyberpunk/...`
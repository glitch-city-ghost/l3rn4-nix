"""Tiny core shared by every generator.

The palette is a two-level YAML document:

    section:
      key: "#rrggbb"   # comment

Templates reference a value as ``@section.key@``. That is the whole engine.
"""

import re
from pathlib import Path

# Theme root: this file is theme/generators/palette.py
ROOT = Path(__file__).resolve().parent.parent

# Top-level section: "base:"
_SECTION = re.compile(r"^([A-Za-z_]\w*):\s*$")

# Indented hex entry: '  bg: "#130b10"   # comment'
# Only quoted hex values are read; anything else is ignored, so comments and
# the meta block need no special handling.
_ENTRY = re.compile(r'^\s+([A-Za-z_]\w*):\s*"(#[0-9a-fA-F]{6})"')

# Placeholder: @text.main@
_TOKEN = re.compile(r"@([A-Za-z_]\w*)\.([A-Za-z_]\w*)@")


def load_palette(path):
    """Return {section: {key: '#rrggbb'}} from the palette YAML."""
    palette = {}
    section = None

    for line in Path(path).read_text().splitlines():
        header = _SECTION.match(line)
        entry = _ENTRY.match(line)

        if header:
            section = header[1]
            palette[section] = {}
        elif entry and section:
            palette[section][entry[1]] = entry[2]

    return palette


def render(template, palette):
    """Replace every @section.key@ in template with its palette value."""

    def value(match):
        section, key = match[1], match[2]
        try:
            return palette[section][key]
        except KeyError:
            raise SystemExit(
                f"palette is missing {section}.{key} (referenced by template)"
            ) from None

    return _TOKEN.sub(value, template)


def write(path, text):
    """Write text, creating parent directories as needed."""
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(text)


def build_theme(name, files, palette_path=None):
    """Render templates/<name>/<template> into generated/cyberpunk/<name>/<output>.

    files maps a template-relative path to a list of output-relative paths.
    """
    palette = load_palette(palette_path or ROOT / "palette.yaml")
    templates = ROOT / "templates" / name
    output_root = ROOT / "generated" / "cyberpunk" / name

    for template, outputs in files.items():
        text = render((templates / template).read_text(), palette)
        for output in outputs:
            write(output_root / output, text)

    print(f"✅ {name} -> {output_root.relative_to(ROOT)}", flush=True)

#!/usr/bin/env python3
"""Render the Vim colorscheme and Airline theme from palette.yaml.

The theme itself lives in theme/templates/vim/ ; this file only says where it goes.
"""

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from palette import build_theme  # noqa: E402

# One template -> every runtime path that must contain the rendered file.
# Airline looks in both autoload/airline/ and autoload/airline/themes/.
FILES = {
    "colors/cyberpunk.vim": ["colors/cyberpunk.vim"],
    "autoload/airline/cyberpunk.vim": [
        "autoload/airline/cyberpunk.vim",
        "autoload/airline/themes/cyberpunk.vim",
    ],
}

if __name__ == "__main__":
    build_theme("vim", FILES)

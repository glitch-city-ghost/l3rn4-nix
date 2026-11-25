#!/usr/bin/env python3
"""Render the btop theme from palette.yaml.

Template: theme/templates/btop/cyberpunk.theme
Output:   theme/generated/cyberpunk/btop/cyberpunk.theme
"""

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from palette import build_theme  # noqa: E402

FILES = {"cyberpunk.theme": ["cyberpunk.theme"]}


if __name__ == "__main__":
    build_theme("btop", FILES)

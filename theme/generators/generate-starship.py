#!/usr/bin/env python3
"""Render the Starship prompt from palette.yaml.

Template: theme/templates/starship/cybrcore.toml
Output:   theme/generated/cyberpunk/starship/cybrcore.toml
"""

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from palette import build_theme  # noqa: E402

FILES = {"cybrcore.toml": ["cybrcore.toml"]}


if __name__ == "__main__":
    build_theme("starship", FILES)

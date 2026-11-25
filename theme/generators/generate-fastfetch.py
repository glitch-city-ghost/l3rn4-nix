#!/usr/bin/env python3
"""Render the Fastfetch config from palette.yaml.

Template: theme/templates/fastfetch/config.jsonc
Output:   theme/generated/cyberpunk/fastfetch/config.jsonc
"""

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from palette import build_theme  # noqa: E402

FILES = {"config.jsonc": ["config.jsonc"]}


if __name__ == "__main__":
    build_theme("fastfetch", FILES)

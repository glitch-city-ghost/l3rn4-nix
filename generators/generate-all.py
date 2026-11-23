#!/usr/bin/env python3
"""Run every generators/generate-*.py script in turn."""

import subprocess
import sys
from pathlib import Path

GENERATORS = Path(__file__).resolve().parent


def main():
    scripts = sorted(
        path for path in GENERATORS.glob("generate-*.py") if path.name != "generate-all.py"
    )

    for script in scripts:
        print(f"→ {script.name}", flush=True)
        subprocess.run([sys.executable, str(script)], check=True)


if __name__ == "__main__":
    main()

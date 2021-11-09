""" Script to update ssh config file for VSCode to make sure it points to compute node.
"""

import subprocess
from pathlib import Path

fn = Path("~/.ssh/config_vscode").expanduser()
with open(fn) as f:
    lines = f.readlines()

cp = subprocess.run(
    "ssh login4 cat .jupyter_hostname.txt", capture_output=True, shell=True, text=True
)
new_jupyter_host = cp.stdout.strip()

new_lines = [
    "Host hoff2_jupyter",
    f"  Hostname {new_jupyter_host}",
    "  User dincer",
    "  ProxyJump dincer@login4.hoffman2.idre.ucla.edu",
    "",
]

start, end = -1, -1
for i, l in enumerate(lines):
    if ">> hoff start <<" in l:
        start = i
    if ">> hoff end <<" in l:
        end = i

ll = lines[: start + 1] + ["\n".join(new_lines)] + lines[end:]

new_file_contents = "".join(ll)
with open(fn, "w") as f:
    f.write(new_file_contents)

print(new_file_contents)

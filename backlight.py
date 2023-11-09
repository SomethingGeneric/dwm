#!/usr/bin/env python3

import sys

BACKLIGHT_DEV="/sys/class/backlight/amdgpu_bl1"

if len(sys.argv) < 2:
    cmd = "get"
else:
    cmd = sys.argv[1]

min_v = 1
max_val = int(open(f"{BACKLIGHT_DEV}/max_brightness").read().strip())

if cmd == "get":
    print(open(f"{BACKLIGHT_DEV}/brightness").read().strip())
elif cmd == "mod":
    add = int(sys.argv[2])
    current = int(open(f"{BACKLIGHT_DEV}/brightness").read().strip())
    new = current + add
    if min_v < new < max_val:
        try:
            with open(f"{BACKLIGHT_DEV}/brightness","w") as f:
                f.write(str(new))
            print("done")
        except Exception as e:
            print(str(e))
    else:
        print("fail")
elif cmd == "set":
    new = int(sys.argv[2])
    if min_v < new < max_val:
        try:
            with open(f"{BACKLIGHT_DEV}/brightness","w") as f:
                f.write(str(new))
            print("done")
        except Exception as e:
            print(str(e))
    else:
        print("fail")


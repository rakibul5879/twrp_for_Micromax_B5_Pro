# TWRP for Micromax B5 Pro (MT6737M)

Custom Team Win Recovery Project (TWRP) device tree for the Micromax B5 Pro.

## Features

- Android 8.1 (OmniROM TWRP)
- MT6737M
- 64-bit
- Recovery partition optimized (16 MB)
- Bash support
- Nano editor
- MTP
- ADB
- F2FS
- EXT4

## Build

```bash
repo sync
source build/envsetup.sh
lunch omni_B5_Pro-eng
mka recoveryimage
```

Output:

```
out/target/product/B5_Pro/recovery.img
```

## Status

- Builds successfully
- Fits stock recovery partition
- Under active development

## Credits

- TeamWin
- OmniROM
- Android Open Source Project
- SebaUbuntu

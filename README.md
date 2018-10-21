# Overview

This project aims to build `GigaOrder`, which is simple browser app based on Chromium Content Shell which will open an url in a single webpage


# Prerequisites

- ubuntu 16.04 or higher
- git 1.8 or higher

# Content

- `all.sh`: This is an all-in-one script that will fetch Chromium sources, add the changes made to generate the GigaOrder app and build it.

- `patches`: This directory contains patches that contain the changes made to generate the GigaOrder app

# Instructions

Launch `all.sh` script to download, patch and build the GigaOrder app

```bash
./all.sh
```

Thes script will ask for the sudoer password at some point. It will also ask for a google play license approval


After the script finishes successfully, you will find the generated apk under `chromium/src/out/Release/apks` folder



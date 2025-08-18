# Cosmic client
This repository contains files and instructions on how to get started with the client for the [Cosmic MapleStory v83 server](https://github.com/P0nk/Cosmic).


## Overview

### Files
- **MapleGlobal-v83-setup.exe** - the original installer that you would download from mapleglobal.com to install the game back in the day 
- **HeavenMS-localhost-WINDOW.exe** (aka "the client") - a modified client to allow playing locally on your own server (and also containing some additional customizations)
- **cosmic-wz** - custom wz files required to play Cosmic properly (see explanation below)

> [!IMPORTANT]
> The client is flagged as a virus and will be automatically deleted by Windows Security. To work around this, you need to add your _Downloads_ and installation directories as _Exclusions_ in _Virus & threat protection settings_.

It is flagged as a virus because it's been modified for local play and other custom features. Many people have used it without issue, but use it at your own risk.

### About the wz files
Cosmic requires custom wz files due to legacy reasons. Cosmic is built on HeavenMS which customized many parts of the game. Part of this customization was wz editing (such as adjusting text, adding levels to equipment, etc.), so we are stuck with these custom wz files for now. 
However, the long term goal is to free ourselves from the custom wz files and only depend on the vanilla wz files (provided by the installer). This is an arduous process that will take some time.

### Git LFS
[Git LFS](https://git-lfs.com/) is used to store the .wz and .exe files. To get the full files when you clone the repo, you need to have Git LFS installed. You can also download the raw files individually via GitHub.

### Releases
The release versions correspond to tags in [Cosmic](https://github.com/P0nk/Cosmic). It is recommended to use the latest versions of _Cosmic-client_ and _Cosmic_ since they are tested to work together.

Releases only contain the client and the cosmic wz files. The setup/installer is excluded because it is static and will not change in between releases.

## Installation

### Guide
1. Run _MapleGlobal-v83-setup.exe_ and install in a directory of your choice or use the default location (C:\Nexon\MapleStory)
2. Remove the following files from the installation directory: 
   - _HShield_ (remove the entire directory)
   - _ASPLnchr.exe_
   - _MapleStory.exe_
   - _Patcher.exe_
3. Copy all the wz files from _cosmic-wz_ (_Character.wz_, _Etc.wz_, _Item.wz_, etc.) into the installation directory and replace.
4. Copy the client into the installation directory.
5. Done! Double-click the client to start the client. 
   - The server has to be running. If it's not running, you will see "We are unable to connect to the login server (...)".

### Troubleshooting
The client sometimes has trouble starting. If you see "Client connected (...)" in the server logs, but the client doesn't boot up or shows an error message, try spam double-clicking the client. If you're in luck, at least one client will start successfully.

## Client editing

### Client customizations
For more information about the client and its features, see [HeavenMS on GitHub](https://github.com/ronancpl/HeavenMS#download-items).

Some notable features:
* Opens in window mode by default
* Uncapped max speed

### Edit client ip
1. Download and install a hex editor: [HxD](https://mh-nexus.de/en/hxd/)
2. Start HxD and open your client exe (I recommend making a copy of it first). At this point you should see a bunch of hex codes and a "Decoded text" column to the right of it.
3. Ctrl+f and search for Text-string "127.0.0.1". You should find three occurrences right above each other.
4. Place your cursor before the first "127" and start typing the desired ip, overwriting what is already there. Do the same on the other two and click on Save.
5. Done! Now the client will attempt to connect to that ip address instead when you launch it.




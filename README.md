<img width="1485" height="879" alt="image" src="https://github.com/user-attachments/assets/d585584f-ca4d-4fba-805a-6c51d3cd0123" />



HUGE shoutout to [@Yunis](https://github.com/ynsrkn) for contributing his improved gui and maintainer functionality to this repo.


Basic knowledge of the mod is assumed

download by using: (press INSERT on your keyboard to paste it into the OC terminal)
```
wget https://raw.githubusercontent.com/chrisdk1234/OC_AE2_Maintainer/main/config.lua && wget https://raw.githubusercontent.com/chrisdk1234/OC_AE2_Maintainer/main/level_maintainer.lua && wget https://raw.githubusercontent.com/chrisdk1234/OC_AE2_Maintainer/main/craftables.lua && wget https://raw.githubusercontent.com/chrisdk1234/OC_AE2_Maintainer/main/ae2_helpers.lua
```

HOW TO USE:

craftables : shows all availible crafts in the AE2 system and gives the option to generate / refresh a config.lua file with all crafts in it with (threshold = defaultThreshold, batchSize = defaultBatchSize).
default values can be edited inside the file itself with .\edit craftables.lua

config : contains an array of all maintained items with the form {"item label", threhsold, batchsize}, sleeptimer that dictates how long the program waits until it does another parse, and a shuffle mode used to enable shuffling of the items choosed for crafting, usefull for ensuring even filling of buffers and for infinite crafting

level_maintainer : executes the program with mentioned settings, will run forever and print out various info to the terminal.

IMPORTANT:

THE PROGRAM NEEDS AN INTERFACE OR A MECONTROLLER CONNECTED TO AN OC ADAPTER BLOCK.

No need to reboot the oc-computer after updating config.lua anymore

ingame computers parts used (lower quality might work but not guaranteed):
- GPU tier 3
- Internet Card (NEEDED TO DOWNLOAD FROM GITHUB)
- CPU tier 3
- Memory tier 3.5
- Hard Disk Drive tier 2
- EEPROM with Lua BIOS (craft it ingame)
- OpenOS floppy (craft it ingame)


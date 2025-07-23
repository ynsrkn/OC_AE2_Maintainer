Basic knowledge of the mod is assumed

download by using: (press INSERT on your keyboard to paste it into the OC terminal)
 ```
wget https://raw.githubusercontent.com/chrisdk1234/OC_AE2_Maintainer/main/config.lua && wget https://raw.githubusercontent.com/chrisdk1234/OC_AE2_Maintainer/main/maintainer.lua && wget https://raw.githubusercontent.com/chrisdk1234/OC_AE2_Maintainer/main/craftables.lua
 ```

HOW TO USE:

.\craftables : shows all availible crafts in the AE2 system and gives the option to generate / refresh a config.lua file with all crafts in it with (threshold = defaultThreshold, batchSize = defaultBatchSize).
default values can be edited inside the file itself with .\edit craftables.lua

.\config : contains a table of all maintained items with the form {["item label"] = {threhsold, batchsize}} and also sleeptimer that dictates how long the program waits until it does another parse.

.\maintainer : executes the program with mentioned settings, will run forever and print out various info to the terminal.

IMPORTANT:

THE PROGRAM NEEDS AN INTERFACE OR A MECONTROLLER CONNECTED TO AN OC ADAPTER BLOCK.

reboot the (ingame) computer after changing / updating config.lua.

ingame computers parts used (lower quality might work but not guaranteed):
- GPU tier 3
- Internet Card (NEEDED TO DOWNLOAD FROM GITHUB)
- CPU tier 3
- Memory tier 3.5
- Hard Disk Drive tier 2
- EEPROM with Lua BIOS (craft it ingame)
- OpenOS floppy (craft it ingame)

SIDE NOTE: This is my first time doing something like this, dont expect perfection :3

Bla 



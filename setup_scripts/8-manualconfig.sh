#!/bin/bash
set -e

# ################################################################################ Import Variables
# Make sure you have edited this file
source "${HOME}/${DDD}/setup_scripts/CONFIG"
if [[ ${DEBUG} == true ]]; then set -x; fi

# Create example site.  This done after previous reboot to avoid error.
cd ~/websites
drush qc --domain=example7.dev
drush qc --domain=example6.dev --makefile=d6.make


firefox -CreateProfile temp &
sleep 10
firefox -CreateProfile Default &
sleep 5
zenity --info --text="Firefox started in order to create profiles.\n\nPlease CLOSE FIREFOX. "
firefox -P temp http://softwarebychuck.com/xpis/FEBE7.0.3.3.xpi &
sleep 5
zenity --info --text="Firefox is starting in order to install FEBE.

1) Install the FEBE extention.
2) Once FEBE is installed, choose the option to RESTART Firefox.
3) Next, choose Tools > FEBE > Restore Profile to restore the default profile using the file: ~/profileFx4{default}.fbu.\n
4) Finally, close Firefox "

firefox -ProfileManager &
sleep 5
zenity --info --text="Firefox profile manager will start.\n1) Delete temp profile.\n2) THEN CLOSE MANAGER."
#rm profileFx4{ddd}.fbu

# final size
df -h -T > ~/$DDD/setup_scripts/logs/size-end.log

# Manual config instructions.
firefox ~/$DDD/config/manualconfig.txt



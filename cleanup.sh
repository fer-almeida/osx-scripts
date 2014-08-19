#!/bin/bash

if [ $(id -u) -eq 0 ]; then
	echo -e "OS X Cleanup Script\n"

	# Power Management Settings
	echo -ne "\r[....] Power Management\r"
	pmset -a hibernatemode 0 > /dev/null 2>&1
	rm /private/var/vm/* > /dev/null 2>&1
	pmset -a hibernatefile /dev/null > /dev/null 2>&1
	echo -ne "\r[ OK ] Power Management\n"
	
	# Useless Files
	echo -ne "\r[....] Useless Files\r"
	rm -rf /System/Library/Speech/Voices/*
	rm -rf /usr/share/emacs
	rm -rf /private/var/folders/*
	rm -rf /private/var/log/*
	echo -ne "\r[ OK ] Useless Files\n"
	
	# Useless Apps
	echo -ne "\r[....] Useless Apps\r"
	if [ -d /Applications/Chess.app/ ]; then rm -rf /Applications/Chess.app/; fi
	if [ -d /Applications/Dashboard.app/ ]; then rm -rf /Applications/Dashboard.app/; fi
	if [ -d /Applications/Launchpad.app/ ]; then rm -rf /Applications/Launchpad.app/; fi
	if [ -d /Applications/Mission\ Control.app/ ]; then rm -rf /Applications/Mission\ Control.app/; fi
	if [ -d /Applications/Photo\ Booth.app/ ]; then rm -rf /Applications/Photo\ Booth.app/; fi
	if [ -d /Applications/Stickies.app/ ]; then rm -rf /Applications/Stickies.app/; fi
	if [ -d /Applications/DVD\ Player.app/ ]; then rm -rf /Applications/DVD\ Player.app/; fi
	if [ -d /Applications/Game\ Center.app/ ]; then rm -rf /Applications/Game\ Center.app/; fi
	if [ -d /Applications/Microsoft\ Messenger.app/ ]; then rm -rf /Applications/Microsoft\ Messenger.app/; fi
	if [ -d /Applications/Microsoft\ Communicator.app/ ]; then rm -rf /Applications/Microsoft\ Communicator.app/; fi
	if [ -d /Applications/Remote\ Desktop\ Connection.app/ ]; then rm -rf /Applications/Remote\ Desktop\ Connection.app/; fi
	echo -ne "\r[ OK ] Useless Apps\n"
	
	# Reorganize Apps
	echo -ne "\r[....] Reorganize Apps\r"
	if [ -d /Applications/Image\ Capture.app/ ]; then mv /Applications/Image\ Capture.app/ /Applications/Utilities/; fi
	if [ -d /Applications/Automator.app/ ]; then mv /Applications/Automator.app/ /Applications/Utilities/; fi
	if [ -d /Applications/Time\ Machine.app/ ]; then mv /Applications/Time\ Machine.app/ /Applications/Utilities/; fi
	if [ -d /Applications/The\ Unarchiver.app/ ]; then mv /Applications/The\ Unarchiver.app/ /Applications/Utilities/; fi
	if [ -d /Applications/TextWrangler.app/ ]; then mv /Applications/TextWrangler.app/ /Applications/Utilities/; fi
	if [ -d /Applications/Font\ Book.app/ ]; then mv /Applications/Font\ Book.app/ /Applications/Utilities/; fi
	if [ -d /Applications/Dictionary.app/ ]; then mv /Applications/Dictionary.app/ /Applications/Utilities/; fi
	if [ -d /Applications/QuickTime\ Player.app/ ]; then mv /Applications/QuickTime\ Player.app/ /Applications/Utilities/; fi
	if [ -d /Applications/Microsoft\ Remote\ Desktop.app/ ]; then mv /Applications/Microsoft\ Remote\ Desktop.app/ /Applications/Utilities/; fi
	echo -ne "\r[ OK ] Reorganize Apps\n"
	
	echo -e "\nFinished. It is highly recommended to restart OS X."
	read -p "Restart now? (y/n) "

	if [ $REPLY == "y" ] || [ $REPLY == "Y" ]; then
		reboot
	fi

	exit
else
	echo "You should be root in order to run this script."
	exit
fi

#!/bin/bash

if [ $(id -u) -eq 0 ]; then
	echo -e "OS X FTP Scanner ENABLE\n"
	
	# Disable FTP server
	echo -ne "\r[....] Disable FTP server\r"
	launchctl unload -w /System/Library/LaunchDaemons/ftp.plist
	echo -ne "\r[ OK ] Disable FTP server\n"

	# Create ACL group
	echo -ne "\r[....] Create ACL group\r"
	dseditgroup -o create -n /Local/Default -u $SUDO_USER com.apple.access_ftp
	echo -ne "\r[ OK ] Create ACL group\n"

	# Add users to group
	echo -ne "\r[....] Adding users to ACL group\r"
	dseditgroup -o edit -u $SUDO_USER -a $SUDO_USER com.apple.access_ftp
	dseditgroup -o edit -u $SUDO_USER -a _ftp com.apple.access_ftp
	echo -ne "\r[ OK ] Adding users to ACL group\n"

	# Create Scanner folder
	echo -ne "\r[....] Create Scanner folder\r"
	if [ ! -d /Users/$SUDO_USERS/Scanner/ ]; then mkdir /Users/$SUDO_USER/Scanner; fi
	if [ -d /Users/$SUDO_USERS/Scanner/ ]; then chmod 777 /Users/$SUDO_USER/Scanner; fi
	echo -ne "\r[ OK ] Create Scanner folder\n"

	# Enable Anonymous user
	echo -ne "\r[....] Enable Anonymous user\r"
	echo "# match umask from Mac OS X Server ftpd" > /etc/ftpd.conf
	echo "umask all 022" >> /etc/ftpd.conf
	echo "chroot GUEST /Users/$SUDO_USER/Scanner" >> /etc/ftpd.conf
	echo "modify guest off" >> /etc/ftpd.conf
	echo "umask  guest 0707">> /etc/ftpd.conf
	echo "upload guest on">> /etc/ftpd.conf
	echo -ne "\r[ OK ] Enable Anonymous user\n"

	# Enable FTP server
	echo -ne "\r[....] Enable FTP server\r"
	launchctl load -w /System/Library/LaunchDaemons/ftp.plist
	echo -ne "\r[ OK ] Enable FTP server\n"
else
	echo "You should be root in order to run this script."
	exit
fi

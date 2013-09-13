#!/bin/sh

# Run self-update #
if $1 ; then
  echo "Updating…!" ;
  ( "$0" )
  echo "Updated"
  exit 1 ;
  echo "Leaving"
fi


# Run Mac Updates #
echo "Updating Mac Software"
sudo softwareupdate -l -i -a -v

# Run Microsoft Word #
echo "Please update Microsoft Office"
/Applications/Microsoft\ Office\ 2008/Microsoft\ Word.app/Contents/MacOS/Microsoft\ Word

# Run Firefox #
echo "Please update Firefox"
/Applications/Firefox.app/Contents/MacOS/firefox

# Run Flash Updater #
echo "Updating Flash Player"
/Applications/Utilities/Adobe\ Flash\ Player\ Install\ Manager.app/Contents/MacOS/Adobe\ Flash\ Player\ Install\ Manager -update plugin

# Run Adobe Acrobat Reader #
echo "Please update Adobe Reader"
/Applications/Adobe\ Reader.app/Contents/MacOS/AdobeReader

# Run VLC #
echo "Please update VLC"
/Applications/VLC.app/Contents/MacOS/VLC

# Run Flip4Mac #
echo "Please update Flip4Mac"
open /Library/PreferencePanes/Flip4Mac\ WMV.prefPane

# Run Disk Utils #
echo "Running diskutils"
diskutil verifyPermissions Macintosh\ HD
diskutil repairPermissions Macintosh\ HD

EOF

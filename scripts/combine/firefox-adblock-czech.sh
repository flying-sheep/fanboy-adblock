#!/bin/bash
#
# Fanboy-Merge (Czech) Adblock list grabber script v1.0 (12/06/2011)
# Dual License CCby3.0/GPLv2
# http://creativecommons.org/licenses/by/3.0/
# http://www.gnu.org/licenses/gpl-2.0.html
#

# Make Ramdisk.
#
$GOOGLEDIR/scripts/ramdisk.sh
# Fallback if ramdisk.sh isn't excuted.
#
if [ ! -d "/tmp/ramdisk/" ]; then
  rm -rf /tmp/ramdisk/
  mkdir /tmp/ramdisk; chmod 777 /tmp/ramdisk
  mount -t tmpfs -o size=30M tmpfs /tmp/ramdisk/
  mkdir /tmp/ramdisk/opera/
fi




# Trim off header file (first 2 lines)
#
sed '1,2d' $GOOGLEDIR/firefox-regional/fanboy-adblocklist-cz.txt > $TESTDIR/fanboy-czech-temp.txt

# Seperage off Easylist filters
#
sed -n '/Czech-addon/,/For EasyList/{/For EasyList/!p}' $TESTDIR/fanboy-czech-temp.txt > $TESTDIR/fanboy-czech-temp2.txt

# Remove Empty Lines
#
sed '/^$/d' $TESTDIR/fanboy-czech-temp2.txt > $TESTDIR/fanboy-czech-temp.txt

# Remove Bottom Line
#
sed '$d' < $TESTDIR/fanboy-czech-temp.txt > $TESTDIR/fanboy-czech-temp2.txt

# Merge to the files together
#
cat $MAINDIR/fanboy-adblock.txt $TESTDIR/fanboy-czech-temp2.txt > $TESTDIR/fanboy-czech-merged.txt
perl $TESTDIR/addChecksum.pl $TESTDIR/fanboy-czech-merged.txt

# Copy Merged file to main dir
#
cp $TESTDIR/fanboy-czech-merged.txt $MAINDIR/r/fanboy+czech.txt

# Compress file
#
rm -f $MAINDIR/r/fanboy+czech.txt.gz
$ZIP a -mx=9 -y -tgzip $MAINDIR/r/fanboy+czech.txt.gz $MAINDIR/r/fanboy+czech.txt > /dev/null

#!/bin/sh
# this script list disks and partitions for operating systems based on Solaris
#
# by Ziga Zupanec, ziga.zupanec@gmail.com, agiz@github
# use at your own risk! I am not responsible for any data loss or any damage 
# whatsoever regardless of you using this or not. 
# You may not restribute this as a part of your project or as a stand-alone 
# script if you are making any money of your project. If you are not sure 
# whether you should redistribute or not send me an email and let me decide. 
# You agree to this terms by having this piece of code on your machine either 
# willingly or by accident.

for line in $( iostat -x | cut -d" " -f1 | tail -n +3 )
do
        disk=$( iostat -nE $line | sed "s/  /\n/g" | uniq | head -n 1)
        echo -e "\n\n-|  Information for device: $line disk: $disk"
        echo "-|"
        iostat -nE $line | sed "s/  /\n-| /g" | uniq | tail -n +3
        echo "-|"
        echo "-| Partition table for disk $disk"
        fdisk /dev/rdsk/${disk}p0 < tmp_42 | head --bytes=-488 | tail +5
        echo ""
        echo "-|    =============================================================="
done
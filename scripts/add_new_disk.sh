set -e
set -x

if [ -f /etc/disk_added_date ]
then
   echo "disk already added so exiting."
   exit 0
fi


sudo fdisk -u /dev/sdb <<EOF
n
p
1


t
8e
w
EOF

pvcreate /dev/sdb1
vgcreate vg1 /dev/sdb1
lvcreate -L 29G vg1
mkfs.ext4 /dev/vg1/lvol0
mkdir -p /var/hadoop
mount -t ext4 /dev/vg1/lvol0 /var/hadoop

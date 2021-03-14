#!/bin/bash
echo "Create systemd.mount unit for share directory"


cat <<'EOF1' | sudo tee /etc/systemd/system/mnt-share.mount
[Unit]
Description = Mount NFS Share
Requires=network-online.service
After=network-online.service

[Mount]
What=192.168.100.40:/home/vagrant/share
Where=/mnt/share
Type=nfs
Options=defaults
 
[Install]
WantedBy=multi-user.target
EOF1

echo "Create systemd.mount unit for upload directory"


cat <<'EOF1' | sudo tee /etc/systemd/system/mnt-share-upload.mount
[Unit]
Description = Mount NFS Share
Requires=network-online.service
After=mnt-share.mount

[Mount]
What=192.168.100.40:/home/vagrant/share/upload
Where=/mnt/share/upload
Type=nfs
Options=defaults
 
[Install]
WantedBy=multi-user.target
EOF1

echo "Enable nfs-mount units"


sudo systemctl enable mnt-share.mount
sudo systemctl enable mnt-share-upload.mount

echo "Rebooting system"



sudo reboot

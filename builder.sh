printf "\033c\n "
printf "\033[40;37m\ngive me disk image name ? "
read h
printf "\033[40;37m\ngive me disk image size in MB ? "
read g
dd if=/dev/zero of=$h bs=1M count=$g status=progress
chmod 777 $h
echo '.........................................'
mkfs.fat -F 12 $h
chmod 777 $h
echo '.........................................'
mkdir /mnt/rams 2>/dev/null
sudo umount /mnt/rams 2>/dev/null
sudo mount -o loop $h /mnt/rams
echo '.........................................'
printf "\033[40;37m\ngive me the files to include in main root ? "
read a
for b in $a
do
    sudo cp $b /mnt/rams
    sudo chmod 777 /mnt/rams/$b
done
sudo umount /mnt/rams 2>/dev/null
echo '.........................................'
g=14
h=boot.img
dd if=/dev/zero of=$h bs=1M count=$g status=progress
chmod 777 $h
echo '.........................................'
mkfs.fat -F 12 $h
chmod 777 $h
echo '.........................................'
syslinux  $h
chmod 777 $h
echo '.........................................'
mcopy -i $h syslinux.cfg ::/syslinux.cfg
mcopy -i $h initrd.gz ::/initrd.gz
mcopy -i $h vmlinuz ::/vmlinuz
chmod 777 $h
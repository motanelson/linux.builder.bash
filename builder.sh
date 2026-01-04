printf "\033c\n "

                umount /mnt/rams 2> /dev/null
                rm initrd 2> /dev/null
                cp init initrd
                mkdir /mnt/rams 2> /dev/null
                mount -o loop initrd /mnt/rams
echo '.........................................'
printf "\033[40;37m\ngive me the files to include in main root ? "
read a
for b in $a
do
    cp $b /mnt/rams
done
echo '.........................................'
chmod 777 /mnt/rams/*
umount /mnt/rams  2> /dev/null
printf "\033[40;37m\ngive me disk image size in MB ? "
read g
printf "\033[40;37m\ngive me disk image name ? "
read h
dd if=/dev/zero of=$h bs=1M count=$g status=progress
chmod 777 $h
echo '.........................................'
mkfs.fat -F 12 $h
chmod 777 $h
echo '.........................................'
syslinux  $h
chmod 777 $h
rm initrd.gz 2> /dev/null
gzip initrd 2> /dev/null
chmod 777 $h
echo '.........................................'
mcopy -i $h syslinux.cfg ::/syslinux.cfg
mcopy -i $h initrd.gz ::/initrd.gz
mcopy -i $h vmlinuz ::/vmlinuz
chmod 777 $h
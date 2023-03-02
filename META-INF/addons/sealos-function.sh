#!/sbin/sh
install_boot_anim() {
    package_extract_dir "system/media/BOOTANIMATION" "$TMP"/BOOTANIMATION
    cd "$TMP"/BOOTANIMATION
    sed -i 's/AVAILABLE/INSTALLED/g' sealos.txt
    zip -0qry -i \*.txt \*.png @ $native_anim *.txt part*
    ui_print "Installed Seal Os Boot Animation to ${n} ${native_anim}"
    cd -
}

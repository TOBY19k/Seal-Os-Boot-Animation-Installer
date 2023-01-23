#!/sbin/sh
#Uses code from BlassGo
bootanimation_find() {
    #Check if Samsung or Samsung based rom
    if [ -f /system/media/bootsamsung.qmg ]; then
       abort "You Are Using Samsung Or Samsung Based ROM"
    fi
    ifelse 'native_anim=$(find /system -type f -name bootanimation.zip) && exist "$native_anim" && ui_print "Found bootanimation.zip in /system"' 'exist /oem/media/bootanimation.zip && native_anim="/oem/media/bootanimation.zip" && ui_print "Found bootanimation.zip in /oem"'
    #check for result
    if undefined native_anim ; then
       abort "CANT FIND: bootanimation.zip"
    fi
}

bootanimation_backup() {
    for path in "$@"; do
        if undefined native_anim ; then
           bootanimation_find /
        fi
        mv $native_anim "$path"/BootAnimationBackup/bootanimation.zip
        ui_print "Backed Up Boot Animation To $path/BootAnimationBackup/bootanimation.zip"
    done
}

bootanimation_restore() {
    for path in "$@"; do
        if undefined native_anim ; then
           bootanimation_find /
        fi
        mv "$path"/BootAnimationBackup/bootanimation.zip $native_anim
        ui_print "Restored Boot Animation From $path/BootAnimationBackup/bootanimation.zip"
    done
}

run_uninstall_script() {
    package_extract_file "META-INF/com/google/android/uninstall-script" $TMP/uninstall-script && . $TMP/uninstall-script
}

#!/sbin/sh
#Uses code from BlassGo
bootanimation_find() {
    for path in "$@"; do
        native_anim=$(find "$path" -type f -name bootanimation.zip)
        if [ -f $native_anim ]; then
           ui_print "Found bootanimation.zip in $path"
           #close the for loop as soon as the bootanimation is found to save time
           break
        fi
    done
    #check if after the for loop finished got any result
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

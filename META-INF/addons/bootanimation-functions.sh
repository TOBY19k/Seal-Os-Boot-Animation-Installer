#!/sbin/sh
#Uses code from BlassGo
bootanimation_find() {
    [ -f /system/media/bootsamsung.qmg ] && abort "You Are Using Samsung Or Samsung Based ROM"
    ui_print "Finding bootanimation.zip"
    native_anim=$(find /system -type f -name bootanimation.zip | sed -n '1p')
    find /system -type f -name bootanimation.zip | sed -n '2p' | xargs rm -f
    if defined native_anim; then
       ui_print "Found bootanimation.zip in /system"
    else
       if [ -f /oem/media/bootanimation.zip ]; then
          native_anim="/oem/media/bootanimation.zip"
          ui_print "Found bootanimation.zip in /oem"
       else
          abort "CANT FIND: bootanimation.zip"
       fi  
    fi
}

bootanimation_backup() {
    ui_print "-- Backing Up Current Boot Animation --"
    for path in "$@"; do
        move "$native_anim" $path/BootAnimationBackup/bootanimation.zip && ui_print "Backed Up Boot Animation To $path/BootAnimationBackup/bootanimation.zip"
    done
}

bootanimation_restore() {
    ui_print "-- Restoring Previous Boot Animation --"
    for path in "$@"; do
        move $path/BootAnimationBackup/bootanimation.zip $native_anim && ui_print "Restored Boot Animation From $path/BootAnimationBackup/bootanimation.zip"
    done
}

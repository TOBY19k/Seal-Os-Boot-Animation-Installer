#!/sbin/sh
#Uses code from BlassGo's  Bootanimation_Maker[1.1] script
bootanimation() {
    #find_in system oem
    for find in "$@"; do
        if [[ "$find_in" == "system" ]]; then
           native_anim=$(find /system -type f -name bootanimation.zip)
           if exist "$native_anim"; then
              ui_print "Found bootanimation.zip"
           else
              abort "CANT FIND: bootanimation.zip"
           fi
        else [[ "$find_in" == "oem" ]]; then
             native_anim=$(find /oem -type f -name bootanimation.zip)
             if exist "$native_anim"; then
                ui_print "Found bootanimation.zip"
             else
                abort "CANT FIND: bootanimation.zip"
             fi
        fi
    done 
    #backup
    for backup in "$@"; do
        move $native_anim /sdcard/BootAnimationBackup/bootanimation.zip
    done
}

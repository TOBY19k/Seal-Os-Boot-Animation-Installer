#!/sbin/sh
#Uses code from BlassGo's  Bootanimation_Maker[1.1] script
bootanimation() {
    #-fi system oem
    local -fi return=1
    for -fi "$@"; do
        local native_anim=$(find /${2} -type f -name bootanimation.zip)
        if exist "$native_anim"; then
           ui_print "Found bootanimation.zip"
           export native_anim=$(find /${2} -type f -name bootanimation.zip)
        else
           abort "CANT FIND: bootanimation.zip"
        fi
    done 
    #backup
    for backup in "$@"; do
        move $native_anim /sdcard/BootAnimationBackup/bootanimation.zip
    done
    return $return
}

#!/sbin/sh
#Uses code from BlassGo's  Bootanimation_Maker[1.1] script
bootanimation() {
    for path in "$@"; do
        native_anim=$(find "$path" -type f -name bootanimation.zip)
        if exist "$native_anim"; then
           ui_print "Found bootanimation.zip in $path"

           #backup
           move "$native_anim" /sdcard/BootAnimationBackup/bootanimation.zip

           #close the for loop as soon as the bootanimation is found to save time
           break
        fi
    done

    #check if after the for loop finished got any result
    if undefined native_anim ; then
       abort "CANT FIND: bootanimation.zip"
    fi
}

#!/sbin/sh
#Uses code from BlassGo
bootanimation_find() {
    for path in "$@"; do
        native_anim=$(find "$path" -type f -name bootanimation.zip)
        if exist "$native_anim"; then
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
        move "$native_anim" /"$path"/BootAnimationBackup/bootanimation.zip
    done
}

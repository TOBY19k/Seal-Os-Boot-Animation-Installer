#!/sbin/sh
#Uses code from BlassGo
bootanimation_find() {
    [ -f /system/media/bootsamsung.qmg ] && abort "You Are Using Samsung Or Samsung Based ROM"
    ui_print "Finding bootanimation.zip"
    native_anim=$(find /system -type f -name bootanimation.zip | sed -n '1p')
    #deletes any unnecessary boot animations if there are
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
    ui_print " 1. Backup Boot Animation to sdcard aka internal storage"
    ui_print " 2. Backup Boot Animation to external_sd"
    ui_print " 3. Backup Boot Animation to usb-otg"
    ui_print "Volume up = yes | Volume down =  next option"
    multi_option "my_menu" 3 loop       
    [ -z $my_menu ] && abort "No valid selection was obtained"
    if [[ $my_menu == 1 ]]; then
       storage=/sdcard
    elif [[ $my_menu == 2 ]]; then
       storage=/external_sd
    elif [[ $my_menu == 3 ]]; then
       storage=/usb-otg
    fi
    ui_print "-- Backing Up Current Boot Animation --"
    move "$native_anim" $storage/BootAnimationBackup/bootanimation.zip && ui_print "Backed Up Boot Animation To $storage/BootAnimationBackup/bootanimation.zip"
}

bootanimation_restore() {
    ui_print " 1. Restore Boot Animation from sdcard aka internal storage"
    ui_print " 2. Restore Boot Animation from external_sd"
    ui_print " 3. Restore Boot Animation from usb-otg"
    ui_print "Volume up = yes | Volume down =  next option"
    multi_option "my_menu" 3 loop       
    [ -z $my_menu ] && abort "No valid selection was obtained"
    if [[ $my_menu == 1 ]]; then
       storage=/sdcard
    elif [[ $my_menu == 2 ]]; then
       storage=/external_sd
    elif [[ $my_menu == 3 ]]; then
       storage=/usb-otg
    fi
    ui_print "-- Restoring Previous Boot Animation --"
    move $storage/BootAnimationBackup/bootanimation.zip $native_anim && ui_print "Restored Boot Animation From $storage/BootAnimationBackup/bootanimation.zip"
}

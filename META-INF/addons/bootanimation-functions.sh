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
    ui_print " 1. Backup Boot Animation to sdcard aka ${n} Internal storage"
    ui_print " 2. Backup Boot Animation to external_sd"
    ui_print " 3. Backup Boot Animation to usb-otg"
    ui_print "Volume up = yes | Volume down =  next option"
    multi_option "my_menu" 3 loop       
    [ -z $my_menu ] && abort "No valid selection was obtained"
    if [[ $my_menu == 1 ]]; then
       local user_selection=/sdcard
    elif [[ $my_menu == 2 ]]; then
       local user_selection=/external_sd
    elif [[ $my_menu == 3 ]]; then
       local user_selection=/usb-otg
    fi
    ui_print "-- Backing Up Current Boot Animation --"
    move "$native_anim" $user_selection/BootAnimationBackup/bootanimation.zip && ui_print "Backed Up Boot Animation To ${n} $user_selection/BootAnimationBackup/bootanimation.zip"
}

bootanimation_restore() {
    ui_print " 1. Restore Boot Animation from sdcard aka ${n} Internal storage"
    ui_print " 2. Restore Boot Animation from external_sd"
    ui_print " 3. Restore Boot Animation from usb-otg"
    ui_print "Volume up = yes | Volume down =  next option"
    multi_option "my_menu" 3 loop       
    [ -z $my_menu ] && abort "No valid selection was obtained"
    if [[ $my_menu == 1 ]]; then
       local user_selection=/sdcard
    elif [[ $my_menu == 2 ]]; then
       local user_selection=/external_sd
    elif [[ $my_menu == 3 ]]; then
       local user_selection=/usb-otg
    fi
    ui_print "-- Restoring Previous Boot Animation --"
    move $user_selection/BootAnimationBackup/bootanimation.zip $native_anim && ui_print "Restored Boot Animation From ${n} $user_selection/BootAnimationBackup/bootanimation.zip"
}

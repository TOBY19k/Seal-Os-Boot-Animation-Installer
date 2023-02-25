#!/sbin/sh
# ba function by @TOBY19k
#Also uses Dynamic Installer functions and code from @BlassGo
ba() {
    local backup=false find=false restore=false backup_sd
    case $1 in
        -b|-backup) backup=true;;
        -f|-find) find=true;;
        -r|-restore) restore=true;;
        *) ui_print "Go to https://github.com/TOBY19k/Seal-Os-Boot-Animation-Installer/wiki/bootanimation-function.sh  for help useing this function" && return 1;;
    esac;
    if $find; then
       [ -f /system/media/bootsamsung.qmg ] && abort "You are using Samsung or Samsung based ROM"
       ui_print "Finding bootanimation.zip"
       native_anim=$(find /system -type f -name bootanimation.zip | sed -n '1p')
       #Deletes any unnecessary boot animations if there are
       find /system -type f -name bootanimation.zip | sed -n '{2..10}p' | xargs rm -f
       if [ -n $native_anim ]; then
          ui_print "Found bootanimation.zip in /system"
       else
          if [ -f /oem/media/bootanimation.zip ]; then
             native_anim="/oem/media/bootanimation.zip"
             ui_print "Found bootanimation.zip in /oem"
          else
             abort "CANT FIND: bootanimation.zip"
          fi  
       fi
       if [ -n $2 ]; then
          case $2 in
              -b|-backup) backup=true;;
              -r|-restore) restore=true;;
              *) ;;
          esac;
       fi
    fi
    if $backup; then
       ui_print " 1. Backup boot animation to sdcard aka ${n} internal storage"
       ui_print " 2. Backup boot animation to external_sd"
       ui_print " 3. Backup boot animation to usb-otg"
       ui_print "Volume up = yes | Volume down =  next option"
       multi_option "backup_menu" 3 loop       
       [ -z $backup_menu ] && abort "No valid selection was obtained"
       if [[ $backup_menu == 1 ]]; then
          backup_sd=/sdcard
       elif [[ $backup_menu == 2 ]]; then
          backup_sd=/external_sd
       elif [[ $backup_menu == 3 ]]; then
          backup_sd=/usb-otg
       fi
       ui_print "-- Backing up current boot animation --"
       move "$native_anim" "$backup_sd"/BootAnimationBackup/bootanimation.zip && ui_print "Backed up noot animation to ${n} $backup_sd/BootAnimationBackup/bootanimation.zip"
    fi
    if $restore; then
       ui_print " 1. Restore boot snimation from sdcard aka ${n} internal storage"
       ui_print " 2. Restore boot animation from external_sd"
       ui_print " 3. Restore boot animation from usb-otg"
       ui_print "Volume up = yes | Volume down =  next option"
       multi_option "restore_menu" 3 loop       
       [ -z $restore_menu ] && abort "No valid selection was obtained"
       if [[ $restore_menu == 1 ]]; then
          backup_sd=/sdcard
       elif [[ $restore_menu == 2 ]]; then
          backup_sd=/external_sd
       elif [[ $restore_menu == 3 ]]; then
          backup_sd=/usb-otg
       fi
       ui_print "-- Restoring previous boot animation --"
       move "$backup_sd"/BootAnimationBackup/bootanimation.zip "$native_anim" && ui_print "Restored Boot Animation From ${n} $backup_sd/BootAnimationBackup/bootanimation.zip"
       ui_print "Deleting BootAnimationBackup folder"
       rm -rf "$backup_sd"/BootAnimationBackup
    fi
}

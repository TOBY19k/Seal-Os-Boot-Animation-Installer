#Magisk modules use $MODPATH as main path
#Your script starts here:
ui_print "Seal Os Boot Animation Installer"
bootanimation_find
#check if seal os boot animation is installed 
if check_content "sealos.txt" "$native_anim"; then
   package_extract_file "sealos.txt" $TMP/sealos.txt "$native_anim"
   version=$(sed -n '1p' $TMP/sealos.txt | grep -Eo '[0-9].[0-9]' | sed 's/\.//g')
   if [ $version -ge 16 ] ; then
      ui_print "-- Seal Os Boot Animation Is Already Installed --"
   else
      ui_print "-- Updateing from Seal Os Boot Animation V${version%[0-9]}.${version#[0-9]} --"
      package_extract_file "system/media/SealOsBootAnimation.zip" $native_anim
      ui_print "Installed Seal Os Boot Animation To ${native_anim}"
   fi
else
   ui_print "-- Installing Seal Os Boot Animation --"
   package_extract_file "system/media/SealOsBootAnimation.zip" $native_anim
   ui_print "Installed Seal Os Boot Animation To ${native_anim}"
fi

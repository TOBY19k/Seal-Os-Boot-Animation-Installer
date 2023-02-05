#!/sbin/sh
#this script is designed for use in Dynamic Installer with import_addons on 
run_uninstall_script() {
    package_extract_file "META-INF/com/google/android/uninstall-script" $TMP/uninstall-script
    . $TMP/uninstall-script
}

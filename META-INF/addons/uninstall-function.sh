#!/sbin/sh
# run_uninstall_script function by @TOBY19k
#Also uses Dynamic Installer function package_extract_file
run_uninstall_script() {
    package_extract_file "META-INF/com/google/android/uninstall-script" $TMP/uninstall-script
    . $TMP/uninstall-script
}

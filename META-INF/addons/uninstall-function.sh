#!/sbin/sh
run_uninstall_script() {
    package_extract_file "META-INF/com/google/android/uninstall-script" $TMP/uninstall-script
    . $TMP/uninstall-script
}

#!/sbin/sh
# ADDOND_VERSION=2
# /system/addon.d/19-SealOsBootAnimation.sh
# During a System upgrade, this script backs up SealOsBootAnimation.zip,
# /system is formatted and reinstalled, then the file is restored.

. /tmp/backuptool.functions

# update-binary|updater <RECOVERY_API_VERSION> <OUTFD> <ZIPFILE>
OUTFD=$(ps | grep -v 'grep' | grep -oE 'update(.*) 3 [0-9]+' | cut -d" " -f3)
[ -z $OUTFD ] && OUTFD=$(ps -Af | grep -v 'grep' | grep -oE 'update(.*) 3 [0-9]+' | cut -d" " -f3)
# update_engine_sideload --payload=file://<ZIPFILE> --offset=<OFFSET> --headers=<HEADERS> --status_fd=<OUTFD>
[ -z $OUTFD ] && OUTFD=$(ps | grep -v 'grep' | grep -oE 'status_fd=[0-9]+' | cut -d= -f2)
[ -z $OUTFD ] && OUTFD=$(ps -Af | grep -v 'grep' | grep -oE 'status_fd=[0-9]+' | cut -d= -f2)
test "$verbose" -a "$OUTFD" && FD=$OUTFD
# This is a recovery only version of the ui_print function in @topjohnw's Magisk addon.d script 
ui_print() {
echo -e "ui_print $1\nui_print" >> /proc/self/fd/$OUTFD
}

list_files() {
cat <<EOF
EOF
}

case "$1" in
  backup)
    ui_print "- Backing up Seal Os Boot Animation"
    list_files | while read FILE DUMMY; do
      backup_file $S/"$FILE"
    done
  ;;
  restore)
    ui_print "- Restoring Seal Os Boot Animation"
    list_files | while read FILE REPLACEMENT; do
      R=""
      [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"
      [ -f "$C/$S/$FILE" ] && restore_file $S/"$FILE" "$R"
    done
  ;;
  pre-backup)
    # Stub
  ;;
  post-backup)
    # Stub
  ;;
  pre-restore)
    # Stub
  ;;
  post-restore)
    # Stub
  ;;
esac

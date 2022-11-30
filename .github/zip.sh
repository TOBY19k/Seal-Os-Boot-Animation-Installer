#!/bin/bash
find . -name "BOOTANIMATION" | while read BOOTANIMATION; do zip -r "${BOOTANIMATION}.zip" "${BOOTANIMATION}" ; rm -rf ${BOOTANIMATION} ; done

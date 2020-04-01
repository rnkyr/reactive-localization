#!/bin/sh

if [ "${PODS_ROOT+x}" ] && [ -x "${PODS_ROOT}/SwiftGen/bin/swiftgen" ]; then
    ${PODS_ROOT}/SwiftGen/bin/swiftgen
# swiftgen doesn't support multiple yml or multiple outputs per yml
# but the project need to have Strings and reactive Strings
    ${PODS_ROOT}/SwiftGen/bin/swiftgen strings Example/Supporting\ Files/en.lproj/Localizable.strings --templatePath rx_strings.stencil --output Example/Extensions/Swiftgen/RxStrings.swift
elif which swiftgen >/dev/null; then
    swiftgen
else
    echo "warning: SwiftGen not installed, download from https://github.com/SwiftGen/SwiftGen"
fi

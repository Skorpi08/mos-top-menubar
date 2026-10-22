#!/bin/bash
# install.sh für das 'mos-profile-button' Plugin

PLUGIN_DIR="/boot/optional/plugins/mos-profile-button"
TARGET_UI_DIR="/usr/share/nginx/html/assets/plugins"

echo "=== Installiere MOS-Plugin: Profile Quick Link ==="

# 1. Zielverzeichnis im Web-Root anlegen falls nicht vorhanden
mkdir -p "$TARGET_UI_DIR"

# 2. Kopiere die Vue-Komponente in den MOS-Frontend-Pfad
cp "$PLUGIN_DIR/ui/NavbarProfileButton.vue" "$TARGET_UI_DIR/mos-profile-button.vue"

# 3. Berechtigungen anpassen, damit Nginx die Datei lesen kann
chmod 644 "$TARGET_UI_DIR/mos-profile-button.vue"

echo "=== Plugin erfolgreich installiert! ==="
exit 0

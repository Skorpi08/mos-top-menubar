#!/bin/bash
# uninstall.sh - Macht die Änderungen der Menüleiste rückgängig

echo "Starte Deinstallation: Top-Menüleiste für MOS..."

TARGET_DIR=""
for path in "/var/www/html" "/usr/share/mos/frontend/dist" "/usr/share/mos/frontend"; do
    if [ -f "$path/index.html" ]; then
        TARGET_DIR=$path
        break
    fi
done

if [ -z "$TARGET_DIR" ]; then
    echo "Frontend-Verzeichnis nicht gefunden. Möglicherweise bereits entfernt."
    exit 0
fi

# Falls ein Backup existiert, spielen wir es zurück
if [ -f "$TARGET_DIR/index.html.bak" ]; then
    mv "$TARGET_DIR/index.html.bak" "$TARGET_DIR/index.html"
    echo "Originale index.html wiederhergestellt."
else
    # Falls kein Backup da ist, entfernen wir spezifisch unseren CSS-Block
    sed -i '/id="mos-top-menu-plugin"/,/<\/style>/d' "$TARGET_DIR/index.html"
    echo "Plugin-CSS aus index.html entfernt."
fi

# Nginx Cache leeren
if systemctl is-active --quiet nginx; then
    systemctl restart nginx
fi

echo "Plugin erfolgreich deinstalliert!"
exit 0

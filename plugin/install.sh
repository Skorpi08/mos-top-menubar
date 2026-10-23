#!/bin/bash
# install.sh - Fixiert die Menüleiste am oberen Bildschirmrand

echo "Starte Installation: Top-Menüleiste für MOS..."

# Pfad zur Frontend-Auslieferung ermitteln (Standard-Pfade bei MOS abfragen)
TARGET_DIR=""
for path in "/var/www/html" "/usr/share/mos/frontend/dist" "/usr/share/mos/frontend"; do
    if [ -f "$path/index.html" ]; then
        TARGET_DIR=$path
        break
    fi
done

if [ -z "$TARGET_DIR" ]; then
    echo "Fehler: MOS Frontend index.html konnte nicht gefunden werden!" >&2
    exit 1
fi

echo "Frontend gefunden unter: $TARGET_DIR"

# Backup der originalen index.html erstellen, falls noch keins existiert
if [ ! -f "$TARGET_DIR/index.html.bak" ]; then
    cp "$TARGET_DIR/index.html" "$TARGET_DIR/index.html.bak"
fi

# CSS-Injektion vorbereiten (Klassen decken gängige Flexbox/Sidebar-Layouts ab)
CSS_INJECT="<style id=\"mos-top-menu-plugin\">
  /* Erzwingt eine horizontale Ausrichtung am oberen Rand */
  nav, .v-navigation-drawer, .sidebar, .menu-container { 
    position: fixed !important; 
    top: 0 !important; 
    left: 0 !important; 
    width: 100% !important; 
    height: 60px !important; 
    flex-direction: row !important; 
    z-index: 9999 !important; 
  }
  /* Verschiebt den Hauptinhalt nach unten, damit nichts verdeckt wird */
  main, .main-content, #app-content { 
    margin-top: 60px !important; 
    margin-left: 0 !important; 
  }
</style>"

# CSS sauber in die index.html injizieren
# Entfernt vorherige Plugin-Instanzen, um Dopplungen zu vermeiden
sed -i '/id="mos-top-menu-plugin"/,/<\/style>/d' "$TARGET_DIR/index.html"
sed -i "s|<\/head>|${CSS_INJECT}\n<\/head>|g" "$TARGET_DIR/index.html"

# Nginx oder Web-Dienst neu starten, um Cache zu leeren falls nötig
if systemctl is-active --quiet nginx; then
    systemctl restart nginx
fi

echo "Top-Menüleiste erfolgreich installiert!"
exit 0

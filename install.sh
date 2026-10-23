#!/bin/bash
# Skript zur Installation der oberen Menüleiste

echo "Installiere Top-Menüleiste Plugin..."

# BEISPIEL: Wenn MOS ein Custom-CSS-Verzeichnis nutzt (Pfade ggf. anpassen)
# mkdir -p /usr/share/mos/frontend/custom/
# echo ".navbar { position: fixed; top: 0; width: 100%; z-index: 1000; }" > /usr/share/mos/frontend/custom/top-menu.css

# System-Dienst oder Webserver neu starten, falls nötig
# systemctl restart mos-frontend

echo "Installation abgeschlossen!"
exit 0

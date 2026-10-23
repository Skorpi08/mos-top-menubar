#!/bin/bash
# install.sh - Injektiert CSS für die obere Navigationsleiste

FRONTEND_DIR="/usr/share/mos/frontend/dist"

if [ -d "$FRONTEND_DIR" ]; then
    echo "MOS Frontend gefunden. Injektiere Top-Bar-Styles..."
    
    # Backup erstellen
    cp "$FRONTEND_DIR/index.html" "$FRONTEND_DIR/index.html.bak"

    # CSS Code, der die Sidebar oben fixiert und den Hauptinhalt nach unten schiebt
    CSS_OVERRIDE="<style id='mos-topbar-style'>
        nav, .v-navigation-drawer, .sidebar { 
            position: fixed !important; 
            top: 0 !important; 
            left: 0 !important; 
            width: 100% !important; 
            height: 55px !important; 
            flex-direction: row !important; 
            z-index: 999 !important; 
        }
        main, .v-main, .main-content { 
            padding-top: 70px !important; 
            padding-left: 15px !important; 
        }
    </style>"

    # Vor dem </head>-Tag einfügen
    sed -i "s|<\/head>|${CSS_OVERRIDE}\n<\/head>|g" "$FRONTEND_DIR/index.html"
    echo "Installation erfolgreich abgeschlossen."
else
    echo "Fehler: MOS Frontend-Pfad nicht gefunden!"
    exit 1
fi

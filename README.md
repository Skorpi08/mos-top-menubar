# Top Menu Bar für MOS

Das Plugin stellt die vorhandenen MOS-Navigationseinträge als horizontale Leiste direkt unter der Kopfzeile dar. Die Einträge bleiben mit den originalen MOS-Routen und Berechtigungen verbunden.

## Einstellungen und Startverhalten

Auf der Plugin-Seite kann zwischen den Themes **Standard**, **Kompakt** und **Akzent** gewählt werden. MOS speichert die Auswahl in `/boot/optional/plugins/unraid/settings.json`; Plugin-Updates übernehmen diese vorhandene Datei. Beim Installieren, Aktualisieren und bei jedem MOS-Start wird das gewählte Theme erneut auf das MOS-Frontend angewendet. Nach dem Speichern muss die Seite einmal neu geladen werden.

## Installation

Das Repository als MOS-Hub-Quelle hinzufügen, den Hub aktualisieren und **Top Menu Bar** unter Plugins installieren. MOS Hub installiert das passende `all.deb`-Paket für die jeweilige Systemarchitektur.

## Entwicklung

Das Plugin verwendet die MOS-Vue-Federation-Schnittstelle. Ein Release-Tag wie `v1.0.9` baut das Frontend-Remote und veröffentlicht das MOS-Pluginpaket samt Prüfsumme.

## Deinstallation

MOS Hub führt beim Entfernen des Plugins die Wiederherstellung des ursprünglichen `/var/www/index.html` aus.
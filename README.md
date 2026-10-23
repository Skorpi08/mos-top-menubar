# Top Menu Bar für MOS

Das Plugin stellt die vorhandenen MOS-Navigationseinträge als horizontale Leiste direkt unter der Kopfzeile dar. Die Einträge bleiben mit den originalen MOS-Routen und Berechtigungen verbunden.

## Einstellungen und Startverhalten

Auf der Plugin-Seite kann zwischen den Themes **Standard**, **Kompakt** und **Akzent** gewählt werden. MOS speichert die Auswahl in `/boot/optional/plugins/top-menubar/settings.json`; Plugin-Updates übernehmen diese vorhandene Datei. Beim Installieren, Aktualisieren und nach dem Start der MOS-Dienste wird das gewählte Theme erneut auf das MOS-Frontend angewendet. Nach dem Speichern muss die Seite einmal neu geladen werden.

## Installation

Das Repository als MOS-Hub-Quelle hinzufügen, den Hub aktualisieren und **Top Menu Bar** unter Plugins installieren. MOS Hub installiert das passende `all.deb`-Paket für die jeweilige Systemarchitektur.

### Wechsel von der alten Plugin-ID

Nach dem Umbenennen des GitHub-Repositories von `mos-unraid` zu `mos-top-menubar` die bisherige **Top Menu Bar**-Installation zuerst über MOS Hub entfernen und anschließend aus dem umbenannten Repository neu installieren. Danach das gewünschte Theme erneut auswählen.

## Entwicklung

Das Plugin verwendet die MOS-Vue-Federation-Schnittstelle. Release-Tags müssen dem Format `1.0.12` ohne führendes `v` entsprechen, damit MOS das Plugin beim Start erkennt. Ein neuer numerischer Release-Tag baut das Frontend-Remote und veröffentlicht das MOS-Pluginpaket samt Prüfsumme. Das Repository heißt `mos-top-menubar`, damit MOS-Repository-Slug und Plugin-ID `top-menubar` übereinstimmen.

## Deinstallation

MOS Hub führt beim Entfernen des Plugins die Wiederherstellung des ursprünglichen `/var/www/index.html` aus.
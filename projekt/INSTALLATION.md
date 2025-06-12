# Projekt-Dokumentation: MediaWiki, WordPress, Jira & Portainer in Docker

## Überblick

Dieses Projekt setzt eine vollständige Umgebung mit folgenden Services in Docker auf:

- **MediaWiki** – Wissensplattform
- **WordPress** – CMS/Blog
- **Jira** – Projektmanagement
- **Portainer** – Docker GUI zur Verwaltung
- **Datenbanken** – MariaDB, PostgreSQL, MySQL

---

## Projektstruktur

```text
modul347
    |-- dokumentation.pdf
    |-- praesentation.pdf
    `-- projekt
        |-- README.md
        |-- anleitungmediawiki.txt
        |-- jira
        |   `-- docker-compose.yml
        |-- mediawiki
        |   `-- docker-compose.yml
        |-- monitoring_portainer
        |   `-- docker-compose.yml
        |-- password.txt
        |-- run_all.sh
        |-- websites.txt
        `-- wordpress
            `-- docker-compose.yml


```

## Konfiguration: `docker-compose.yaml`

Die Konfiguration nutzt Docker **Compose v3.8** mit mehreren Netzwerken und Datenvolumes für Persistenz.

### Services

| Service     | Port   | Funktion                   |
| ----------- | ------ | -------------------------- |
| MediaWiki   | 8081   | Wissensplattform           |
| WordPress   | 8080   | CMS                        |
| Jira        | 8082   | Projektmanagement          |
| Portainer   | 9000   | Docker GUI                 |
| Datenbanken | intern | PostgreSQL, MariaDB, MySQL |

## Einrichtungsschritte

1. **Ordner erstellen** / **Repository klonen**

   ```bash
   mkdir projekt && cd projekt
   ```
   ```bash
   git clone "git Repository"
   ```

2. **`docker-compose.yaml`** einfügen

   Erstelle eine Datei `docker-compose.yaml` und füge die Konfiguration ein.

3. **Docker-Netzwerk erstellen** (falls nicht vorhanden)

    ```bash
    docker network create projekt-netzwerk
    ```

4. **Container starten**

    ```bash
    docker-compose up -d
    ```
## Zugriff auf die Services
| Service | URL |
| --- | --- |
| MediaWiki | http://localhost:8081 |
| WordPress | http://localhost:8080 |
| Jira | http://localhost:8082 |
| Portainer | http://localhost:9000 |

## MediaWiki Einrichtung

1. Nach dem Start gehe zu: http://localhost:8081

2. Folge dem Setup-Assistenten:

   - Datenbanktyp: MySQL

   - Host: `mediawiki_db`

   - Datenbankname: `wiki`

   - Benutzername: `remo`
- 
   - Passwort: `1234asdf`

1. Nach Abschluss: `LocalSettings.php` herunterladen und in dein Projektverzeichnis legen.
2. Mount sicherstellen:
```yaml
volumes: ./LocalSettings.php:/var/www/html/LocalSettings.php
```

## MediaWiki: Bilder & Uploads

### Schreibrechte setzen

```bash
docker exec -it mediawiki chown -R www-data:www-data /var/www/html/images
```

### ImageMagick Integration

Prüfen:

```bash
docker exec -it mediawiki which convert
# Sollte zurückgeben: /usr/bin/convert
```

In `LocalSettings.php` einfügen:

```php
$wgUseImageMagick = true;
$wgImageMagickConvertCommand = "/usr/bin/convert";
$wgEnableUploads = true;
```

# WordPress & Datenbank

- WP: http://localhost:8080

- Datenbankverbindung wird automatisch per `wordpress_db` hergestellt

- Benutzername/Passwort: `remo` / `123`

## Jira Einrichtung

1. Starte Setup unter: http://localhost:8082

2. Verwende folgende Datenbank-Einstellungen:

- Typ: PostgreSQL

- Host: `jira_db:5432`

- Benutzer: `jira_user`

- Passwort: `jira_pass`

- DB-Name: `jira_db`

## Portainer Zugriff

Portainer ist unter http://localhost:9000 erreichbar.
Bei der ersten Anmeldung musst du einen Benutzer anlegen.

## Nützliche Docker-Kommandos

```bash
docker-compose up -d                # Container >starten
docker-compose down                 # Container >stoppen
docker-compose logs -f mediawiki    # Live-Logs >für MediaWiki ansehen
docker exec -it mediawiki bash      # In >Container bash öffnen
```J
## Fehlerbehebung

- Upload-Fehler "lock file":
  Stelle sicher, dass `/images` beschreibbar ist:

```bash

docker exec -it mediawiki chown -R www-data:www-data /var/www/html/images
```

- **MySQL Fehler "Access Denied":**
  Prüfe Umgebungsvariablen in docker-compose.yml und LocalSettings.php

- **Jira Datenbankverbindung:**
  Jira braucht ein wenig länger zum Starten. Warte 1–2 Minuten oder prüfe Logs:

```bash,Copy,Edit
docker-compose logs -f jira
```

## ToDos nach Setup

- [ ] MediaWiki Upload testen

- [ ] WordPress konfigurieren

- [ ] Jira Projekte anlegen

- [ ] Portainer absichern (Admin-Passwort setzen)

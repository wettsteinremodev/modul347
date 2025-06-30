# Projekt-Dokumentation: MediaWiki, WordPress, Jira & Portainer in Docker
---
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
---

## Konfiguration:

Die Konfiguration nutzt Docker **Compose v3.8** mit einem Netzerk und Datenvolumes für Persistenz.

4x `docker-compose.yml` wurden erstellt zu jedem einzelen Service.
Die Datenbanken werden innerhalb der `.yml` files definiert.

&#127760; projekt-netzwerk 
Das Netzwerk wird über das **Bash-script** erstellt


### Services

| Service     | Port   | Funktion                   |
| ----------- | ------ | -------------------------- |
| MediaWiki   | 8081   | Wissensplattform           |
| WordPress   | 8080   | CMS                        |
| Jira        | 8082   | Projektmanagement          |
| Portainer   | 9000   | Docker GUI                 |
| Datenbanken | intern | PostgreSQL, MariaDB, MySQL |

---

## Systemvorbereitung
- **Ubuntu 24.04** LTS wird verwendet.
- **Docker / Docker Compose**
  - Docker überprüfen
  ```bash 
  docker --version
  # Docker version 28.2.2, build e6534b4

  docker compose version
  # Docker Compose version v2.36.2
  ```
  - Docker installieren
  ```bash
  sudo apt-get update
  sudo apt-get install ./docker-desktop-amd64.debr
  ```
   - Docker erneut überprüfen (wie oben)
 - **Git**
   - Git überprüfen
   ```bash
   git -v
   # git version 2.43.0
   ```
   - Git installieren wenn nicht vorhanden
   ```bash
   sudo apt install git
   ```
   - Git erneut überprüfen (wie oben)
 

---
## Einrichtungsschritte

1. **Ordner erstellen** / **Repository klonen**

   ```bash
   mkdir nameOfMyFolder && cd nameOfMyFolder
   ```
   ```bash
   git clone "git Repository"
   ```

2. Zum Folder mit dem **Bash-script:** `run_all.sh`
   ```bash 
   cd module347/projekt
   ```


3. **Bash-script** laufen lassen

    ```bash
    bash run_all.sh
    ```

4. **Container überprüfen**

    ```bash
    docker ps -a
    ```

### Alle Container sollten nun Aktiv sein und laufen

---
## Zugriff auf die Services &#127760;
| Service | URL |
| --- | --- |
| MediaWiki | &#127760; http://localhost:8081 |
| WordPress | &#127760; http://localhost:8080 |
| Jira | &#127760; http://localhost:8082 |
| Portainer | &#127760; http://localhost:9000 |
---
## MediaWiki Einrichtung

1. Nach dem Start gehe zu: http://localhost:8081

2. Folge dem Setup-Assistenten:

   - Datenbanktyp: MySQL

   - Host: `db`

   - Datenbankname: `wiki`

   - Benutzername: `remo`
- 
   - Passwort: `1234asdf`

1. Nach Abschluss: `LocalSettings.php` herunterladen und in dein Projektverzeichnis legen.
2. Mount sicherstellen:
```bash
docker cp LocalSettings.php mediawiki:/var/www/html/LocalSettings.php
docker restart mediawiki

```

---
## WordPress & Datenbank

- WP: http://localhost:8080

- Datenbankverbindung wird automatisch per `wp_db` hergestellt

- Benutzername/Passwort: `remo` / `123`

---

## Jira Einrichtung

1. Starte Setup unter: http://localhost:8082

2. Verwende folgende Datenbank-Einstellungen:

- Typ: PostgreSQL

- Host: `jira-db-1`

- Benutzer: `jira_user`

- Passwort: `jira_pass`

- DB-Name: `jira_db`
---

## Portainer Zugriff

Portainer ist unter http://localhost:9000 erreichbar.
Bei der ersten Anmeldung musst du einen Benutzer anlegen.

---

## Nützliche Docker-Kommandos

```bash
docker-compose up -d                # Container >starten
docker-compose down                 # Container >stoppen
docker-compose logs -f mediawiki    # Live-Logs >für MediaWiki ansehen
docker exec -it mediawiki bash      # In >Container bash öffnen
docker ps -a                        # Laufende Container
```

---

## ToDos nach Setup

- [ ] MediaWiki Upload testen

- [ ] WordPress konfigurieren

- [ ] Jira Projekte anlegen

- [ ] Portainer absichern (Admin-Passwort setzen)

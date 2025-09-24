# Flask Prosjektstarter Skript

Dette skriptet automatiserer oppsettet av et grunnleggende Flask-prosjekt. Det lager en prosjektmappe, setter opp et virtuelt miljø, installerer pakker, genererer standardfiler, og kan initialisere et Git-repository og koble det til GitHub.

## Forutsetninger

Før du kjører skriptet, sørg for at du har følgende installert på systemet ditt:

-   `zsh` (eller en annen kompatibel shell som kan kjøre skriptet)
-   `python3`
-   `pip`
-   `gh` (GitHub CLI) - for automatisk opprettelse av repository på GitHub.

## Bruk

1. **last ned med å gjøre**
   ```bash
   git clone https://github.com/nokoniko/flask-automatisk-oppsett.git
   ```
2.  **Gjør skriptet kjørbart:**
    Åpne en terminal og naviger til mappen der `flask.sh` ligger. Kjør følgende kommando for å gi skriptet kjøretillatelser:
    ```bash
    chmod +x flask.sh
    ```

3.  **Kjør skriptet:**
    Start skriptet ved å kjøre:
    ```bash
    ./flask.sh
    ```

4.  **Oppgi prosjektnavn:**
    Du vil bli bedt om å skrive inn et navn for prosjektmappen og om du vil sette opp Git.

## Hva skriptet genererer

Skriptet vil opprette en ny mappe med navnet du anga, og fylle den med følgende struktur og filer:

```
ditt-prosjektnavn/
├── .venv/                  # Virtuelt miljø for prosjektet
├── static/
│   └── css/
│       └── style.css       # Enkel CSS-fil for styling
├── templates/
│   └── index.html          # Grunnleggende HTML-template
├── .gitignore              # Standard .gitignore for Python/Flask-prosjekter
└── app.py                  # Enkel Flask-applikasjon med én rute
```

## Etter kjøring

Når skriptet er ferdig, er prosjektet ditt klart.

1.  Naviger inn i den nye prosjektmappen: `cd <ditt-prosjektnavn>`
2.  Det virtuelle miljøet er allerede aktivert av skriptet.
3.  Start Flask-utviklingsserveren ved å kjøre: `flask run` eller `python3 app.py`
4.  Åpne nettleseren din og gå til `http://127.0.0.1:5000` for å se den nyopprettede nettsiden.


## Kilder
gemini for å lage README.md og chatgpt til å gi meg alt får å ha i .gitignore
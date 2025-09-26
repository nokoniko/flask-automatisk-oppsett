# Flask Prosjektstarter-skript

Dette repoet inneholder to skript for å automatisere oppsettet av et Flask-prosjekt.

-   `full_flask.sh`: Et omfattende skript som setter opp et komplett prosjekt med virtuelt miljø, avhengigheter, valgfri Git-integrasjon med GitHub, og en konfigurasjonsmappe.
-   `basic_flask.sh`: Et minimalistisk skript som kun lager den grunnleggende mappestrukturen og de nødvendige filene for en enkel Flask-app.

## Forutsetninger

Før du kjører skriptet, sørg for at du har følgende installert på systemet ditt:

-   `zsh` (eller en annen kompatibel shell som kan kjøre skriptet)
-   `python3`
-   `pip`
-   `gh` (GitHub CLI) - *kun nødvendig for `full_flask.sh` hvis du vil opprette et GitHub-repo automatisk.*

## Bruk

1. **last ned med å gjøre**
   ```bash
   git clone https://github.com/nokoniko/flask-automatisk-oppsett.git
   ```
2.  **Gjør skriptet kjørbart:**
    Åpne en terminal og naviger til mappen der `flask.sh` ligger. Kjør følgende kommando for å gi skriptet kjøretillatelser:
    ```bash
    chmod +x full_flask.sh basic_flask.sh
    ```

3.  **Kjør skriptet:**
    Velg det skriptet som passer best for ditt behov.

    **For et komplett oppsett:**
    ```bash
    ./full_flask.sh
    ```
    Dette skriptet vil spørre deg om prosjektnavn, om du vil initialisere Git, og om du trenger en `.env`-fil for konfigurasjon.

    **For et basisoppsett:**
    ```bash
    ./basic_flask.sh
    ```
    Dette skriptet vil kun spørre om prosjektnavn.

## Hva skriptene genererer

### `full_flask.sh`
Dette skriptet setter opp en mer komplett struktur, klar for videre utvikling.

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
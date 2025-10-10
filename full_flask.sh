#!/usr/bin/env bash

# spør om navn på prosjekt
echo "Hva skal mappen/prosjektet hete:"
read fil
echo "Vil du at den skal sette opp git for deg (y/n):"
read gitvalg
echo "Vil du ha en config-folder med .env (y/n):"
read env

# erstatt mellomrom med bindestrek
fil_navn=$(echo "$fil" | sed 's/ /-/g')

# Lag prosjektmappe
mkdir -p "$fil_navn"
cd "$fil_navn" || exit 1

# Sett opp virtuell miljø
if command -v python3 >/dev/null 2>&1; then
    python3 -m venv .venv || { echo "Kunne ikke lage venv"; exit 1; }
    source .venv/bin/activate
else
    echo "python3 ikke funnet! Avbryter."
    exit 1
fi

# Lag undermapper + pip install
if [ "$env" = "y" ]; then
    mkdir -p static/{css,img,js} db templates config
    pip install flask flask-sqlalchemy python-dotenv
    cat <<EOF > config/.env
# Her har du alle api nøkklene dine
EOF
else
    mkdir -p static/{css,img,js} db templates
    pip install flask flask-sqlalchemy
fi

# Lag app.py
cat > app.py << 'EOF'
import os
from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

if __name__ == "__main__":
    app.run(debug=True)
EOF

# Lag CSS-fil
cat <<EOF > static/css/style.css
body {
    font-family: Arial, sans-serif;
    background: #f0f0f0;
    text-align: center;
}
h1 {
    color: #333;
}
EOF

# lager JS-fil
cat <<EOF > static/js/main.js
// javascript fil
EOF

# Lag HTML-template

cat <<EOF > templates/base.html
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>{% block title %}{% endblock %}</title>
        <link rel="stylesheet" href="{{ url_for('static', filename='css/style.css') }}">
    </head>
    <body>
        <div>
            <header>Min flask nettside</header>
            <nav>
                <a href="/">hejm hjem</a>
                <a href="/home">hjem</a>
                <a href="/contact">kontakt</a>
                <a href="/about">om</a>
            </nav>
        </div>
        {% block content %}{% endblock %}
    </body>
</html>
EOF

cat <<EOF > templates/index.html
{% extends "base.html"%}

{% block title  %}index{% endblock %}

{% block content %}
<p>Dett er inex jajaj</p>
{% endblock %}
EOF

# github repo
if [ "$gitvalg" = "y" ]; then
    cat <<EOF > .gitignore
# Virtual environment
.venv/
venv/

# Python cache
__pycache__/
*.pyc
*.pyo
*.pyd

# Flask instance folder
instance/
*.db
*.sqlite3

# Logs
*.log

# MacOS systemfiler
.DS_Store

# config folder for api
config/.env

# IDE/Editor filer
.vscode/
.idea/

# Bytecode / build
*.egg-info/
.eggs/
build/
dist/

# Testing
.coverage
.pytest_cache/
htmlcov/

# Environments
.env
.env.*
EOF

    git init
    git add .
    git commit -m "Initielt Flask-prosjekt"

    while true; do
        echo "Vil du ha GitHub repo som public eller private? "
        read visibility
        if [ "$visibility" = "public" ] || [ "$visibility" = "private" ]; then
            break
        else
            echo "Skriv 'public' eller 'private'."
        fi
    done

    if command -v gh >/dev/null 2>&1; then
        if ! gh auth status >/dev/null 2>&1; then
            echo "Du må logge inn i GitHub CLI først: gh auth login"
            exit 1
        fi
        gh repo create "$fil_navn" --"$visibility" --source=. --remote=origin --push
        echo "Lagde $fil_navn og pushet til GitHub som et $visibility repo."
    else
        echo "GitHub CLI (gh) er ikke installert. Hopper over GitHub-oppsett."
    fi
else
    echo "Lagde $fil_navn ferdig!"
fi
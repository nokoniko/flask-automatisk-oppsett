#!/usr/bin/env zsh

# spør om navn på prosjekt
echo "Hva skal mappen/prosjetet hete:"
read fil
echo "Vil du at den skall sette opp git for deg (y/n):"
read gitvalg

fil_navn="${fil// /-}"

# Lag prosjektmappe
mkdir $fil_navn
cd $fil_navn

# Lag undermapper
mkdir -p static/{css,img} db templates config

# Sett opp virtuell miljø
python3 -m venv .venv
source .venv/bin/activate

# Installer pakker
pip install flask flask-sqlalchemy python-dotenv

# Lag app.py
cat > app.py << 'EOF'
import os
from flask import Flask, render_template
from dotenv import load_dotenv

load_dotenv()

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

# Lag HTML-template
cat <<EOF > templates/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="{{ url_for('static', filename='css/style.css') }}">
    <title>Flask</title>
</head>
<body>
    <h1>Flask nettside</h1>
</body>
</html>
EOF

cat <<EOF > config/.env
# Her har du alle api nøkklene dine
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

# Flask instance folder (database, config, uploads)
instance/
*.db
*.sqlite3

# Logs
*.log

# MacOS systemfiler
.DS_Store

# config flder for api
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
    if [ "$visibility" = "public" ] || [ "$visibility" = "private" ] || [ "$visibility" = "priv" ] || [ "$visibility" = "privat" ]; then
            break
        else
            echo "Skriv 'public' eller 'private'."
        fi
    done

    gh repo create "$fil_navn" --$visibility --source=. --remote=origin --push
    
    echo "lagdt $fil_navn og lagt det ut på github som et $visibility repo."

elif [ "$gitvalg" = "n" ]; then
    echo "lagt $fil_navn ferdig!"
fi

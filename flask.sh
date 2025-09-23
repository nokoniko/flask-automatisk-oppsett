#!/usr/bin/env zsh

echo "Hva skal mappen hete?"
read fil

# Lag prosjektmappe
mkdir $fil
cd $fil

# Lag undermapper
mkdir -p static/css
mkdir -p templates

# Sett opp virtuell miljø
python3 -m venv .venv
source .venv/bin/activate

# Installer pakker
pip install flask flask-sqlalchemy

# Lag app.py
cat > app.py << 'EOF'
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
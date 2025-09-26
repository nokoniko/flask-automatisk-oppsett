#!/usr/bin/env zsh

# spør om navn på prosjekt
echo "Hva skal mappen/prosjetet hete:"
read fil

fil_navn="${fil// /-}"

# Lag prosjektmappe
mkdir $fil_navn
cd $fil_navn

# Sett opp virtuell miljø
python3 -m venv .venv
source .venv/bin/activate

# Lag undermapper
mkdir -p static/{css,img, js} templates

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
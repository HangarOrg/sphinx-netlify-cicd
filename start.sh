#!/bin/bash

git init
gh repo create # Note, this defaults to your folder name... if you want to name it something else, you'll need to change this command
echo "_build" > .gitignore


echo "3.7" > runtime.txt
poetry init
poetry add sphinx
poetry export -f requirements.txt -o requirements.txt

poetry run sphinx-quickstart


cat <<EOF > netlify.toml
[build]
    publish = "_build/html"
    command = "make html"
EOF
netlify init

git add .
git commit -am "initial commit"
git push origin main
#!/bin/bash

# Execute all scripts in te ext folder
# usage: extensions.sh foo,bar,baz

echo Proceding to install "$1"

extensions=()
while IFS='' read -r line; do extensions+=("$line"); done < <(echo "$1" | tr "," "\n")

for i in "${extensions[@]}"
do
  if [[ -e "/app/ext/$i.sh" ]]; then
      "/app/ext/$i.sh"
  fi
done

echo Install complete
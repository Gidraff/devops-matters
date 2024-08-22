!#/bin/bash

set -euo pipefail

VAR="script"

echo "This is a : $VAR"

echo "initiating script..."
echo "installing package updates..."

sudo apt-get update

if [ -e ./network_info.csv ]; then
    rm ./network_info.csv
fi

python3 ./network_ip.py

echo "Completed ..."

directory="."

for item in "$directory"/*; do
    if [ -x "$item" ] && [ -f "$item" ] ; then
	echo "File: $item is an executable"
    fi
done


find /etc -iname '*passwd*' > samplefile2.txt

for file in "$(cat samplefile2.txt)"; do
    echo "File:: $file"
done

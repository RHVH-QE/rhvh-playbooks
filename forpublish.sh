#!/bin/bash

PASSPHRASE=""

function encrypt() {
	files=$(find . -name "main.yml" | grep vars)

	for f in $files; do
		gpg --armor --yes --batch --symmetric --passphrase=$PASSPHRASE $f
	done

	gpg --armor --yes --batch --symmetric --passphrase=$PASSPHRASE production.inv.ini
	gpg --armor --yes --batch --symmetric --passphrase=$PASSPHRASE staging.inv.ini
}

function decrypt() {
	files=$(find . -name "*.asc")

	for f in $files; do
		gpg --yes --batch --passphrase=$PASSPHRASE $f
	done
}

if [ $# -eq 0 ]; then
	echo 'Usage::'
	echo
	echo "Encrypt vars:"
	echo "$0 -e -p [password]"
	echo
	echo "Restore vars:"
	echo "$0 -d -p [password]"
	exit 0
fi

while [ $# -gt 0 ]; do
	case "$1" in
	-e | --encrypt)
		MODE=0
		;;
	-d | --decrypt)
		MODE=1
		;;
	-p | --password)
		PASSPHRASE="$2"
		shift
		;;
	esac
	shift
done

if [ $MODE -eq 0 ]; then
	echo "encrypting vars"
	encrypt
elif [ $MODE -eq 1 ]; then
	echo "decrypting vars"
	decrypt
fi

#!/bin/bash
#autore Giulio Sorrentino <gsorre84@gmail.com>

if [[ $EUID -ne 0 ]]; then
	echo "Lo script va eseguito come root."
	exit 1;
fi

dnf install fedora-release-identity-workstation --allowerasing
dnf update

#!/bin/bash
#autore Giulio Sorrentino <gsorre84@gmail.com>

function prerequisti {
	dnf install dialog
}

function splashScreen {
	dialog --title "Informazioni" --backtitle "Informazioni" --msgbox "Giulio Sorrentino <gsorre84@gmail.com> copyright 2020\nIl programma viene concesso in licenza secondo la licenza GPL v3 o, secondo il tuo parere, qualsiasi versione successiva.\nIl programma viene concesso COME E', senza NESSUNA garanzia né esplicita né implicita.\nSe ti piace considera una donazione al mio paypal." 60 40
}

function isNotRoot  {
if  [[ $EUID -ne 0 ]]; then
	dialog --title "Errore" --backtitle "Errore" --msgbox "Il programma va avviato da root." 60 40
	return 1
fi
	return 0
}

function getDestkop {
dialog --title "Seleziona il desktop" --backtitle "Seleziona il desktop" --radiolist "Selezionare quale desktop installare" 60 40 9 \
1 "Gnome" true \
2 "Kde" false \
3 "Xfce" false \
4 "LXDE" false \
5 "LXQt" false \
6 "Cinnamon" false \
7 "Mate" false \
8 "Sugar" false \
9 "Deepin" false > /dev/tty 2>/tmp/result.txt
if [ $? -eq 0 ]; then
	desktop=`cat /tmp/result.txt`
else
	desktop=0;
fi
rm /tmp/result.txt
return $desktop
}

splashScreen

if [ ! -f "/etc/fedora-release" ]; then
	dialog --title "Errore" --backtitle "Errore" --msgbox "Non sei su fedora." 60 40
	exit 1
fi

prerequisti
isNotRoot
if [ $? -eq 1 ]; then
	exit 1
fi

getDestkop
case $? in
	1) desktop="Desktop Base";;
	2) desktop="Spazi di lavoro Plasma per KDE";;
	3) desktop="Desktop Xfce";;
	4) desktop="Desktop LXDE";;
	5) desktop="Desktop LXQt";;
	6) desktop="Desktop Cinnamon";;
	7) desktop="Desktop Mate";;
	8) desktop="Ambiente Desktop Sugar";;
	9) desktop="Deepin Desktop";;
	*) dialog --title "Attenzione" --backtitle "Attenzione" --msgbox "L'operazione e' stata annullata." 60 40
	exit 1;;
esac

dnf groupinstall "$desktop"
systemctl set-default graphical.target
dialog --title "OK" --backtitle "OK" --yesno "Il sistema e' stato installato. Vuoi riavviare?" 60 40
if [ $? -eq 0 ]; then
systemctl reboot
fi


#!/bin/bash
#autore Giulio Sorrentino <gsorre84@gmail.com>

if  [[ $EUID -ne 0 ]]; then
	echo "Lo script va avviato da root."
	exit 1;
fi

versione=`cat /etc/fedora-release | cut -d" " -f3`
if  [[ $versione -ne 33 ]]; then
	echo "Non sei su fedora 33. Il programma non può continuare."
	exit 1;
fi

echo "1. Gnome
2. KDE
3. Xfce
4. Lxde
5. LxQt
6. Cinnamon
7. Mate
8. Sugar
9. Deepin
Selezionare quale desktop installare: "

read desktop;

case $desktop in
	1) desktop="Desktop Base"
	;;
	2) desktop="Spazi di lavoro Plasma per KDE"
	;;
	3) desktop="Desktop Xfce"
	;;
	4) desktop="Desktop LXDE"
	;;
	5) desktop="Desktop LXQt"
	;;
	6) desktop="Desktop Cinnamon"
	;;
	7) desktop="Desktop Mate"
	;;
	8) desktop="Ambiente Desktop Sugar"
	;;
	9) desktop="Deepin Desktop"
	;;
	*) echo "Scelta non valida. Il programma esce."
		exit 1
	;;
esac

dnf groupinstall "$desktop"
systemctl set-default graphical.target
echo "Il sistema è stato installato. Riavviare per avere il login grafico."


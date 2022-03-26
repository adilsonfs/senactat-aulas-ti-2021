#Autor: Robson Vaamonde<br>
#Procedimentos em TI: http://procedimentosemti.com.br<br>
#Bora para Prática: http://boraparapratica.com.br<br>
#Robson Vaamonde: http://vaamonde.com.br<br>
#Linkedin Robson Vaamonde: https://www.linkedin.com/in/robson-vaamonde-0b029028/<br>
#Facebook Procedimentos em TI: https://www.facebook.com/ProcedimentosEmTi<br>
#Facebook Bora para Prática: https://www.facebook.com/BoraParaPratica<br>
#Instagram Procedimentos em TI: https://www.instagram.com/procedimentoem<br>
#YouTUBE Bora Para Prática: https://www.youtube.com/boraparapratica<br>
#Data de criação: 07/03/2022<br>
#Data de atualização: 07/03/2022<br>
#Versão: 0.01<br>
#Testado e homologado no Linux Mint 20.1 Ulyssa, 20.2 Uma e 20.3 Una x64

08/07/2021 - Linux Mint 20.2 “Uma” Cinnamon released!: https://blog.linuxmint.com/?p=4102<br>
08/07/2021 - How to upgrade to Linux Mint 20.2: https://blog.linuxmint.com/?p=4111<br>
New features in Linux Mint 20.2 Cinnamon: https://www.linuxmint.com/rel_uma_cinnamon_whatsnew.php<br>
Release Notes for Linux Mint 20.2 Cinnamon: https://www.linuxmint.com/rel_uma_cinnamon.phpp<br>
07/01/2022 - Linux Mint 20.3 “Una” Cinnamon released! https://blog.linuxmint.com/?p=4220<br>
Release Notes for Linux Mint 20.3 Cinnamon: https://www.linuxmint.com/rel_una_cinnamon.php

#Instalação do Linux Mint 64 Bits no Itautec InfoWay N8645 (2010)

#01_ Software para criação de Pen Drive Bootável<br>

	_ Rufus: https://rufus.ie/pt_BR/
	_ YUMI: https://www.pendrivelinux.com/yumi-multiboot-usb-creator/
	_ Etcher: https://www.balena.io/etcher/
	_ UNetbootin: https://unetbootin.github.io/
	_ Ventoy: https://www.ventoy.net/en/index.html
	_ Linux Live USC Creator: https://www.linuxliveusb.com/

#02_ Configurações do Hardware do Itautec InfoWay N8645<br>

	_ CPU Intel Core i7 M620 2.6Mhz, 8.0GB DDR-3 1333Mhz, HD Samsung 500GB,LCD 17", Webcam, 
	_ VGA, eSATA, USB 2.0, Ethernet Realtek RTL-8111, Wireless, Graphics AMD ATI Radeon 
	_ RV730/M96 4650/5165, Audio Intel Serie 3400

#03_ Configuração da BIOS (versão P5214_I-SL2.1)<br>

	_ Configuração Padrão de Fábrica, Hard Disk SATA em AHCI, VT-x habilitado, Audio, Wireless 
	_ e Bluetooth habilitados.
	
#04_ Inicialização da Instalação do Linux Mint 20.1, 20.2 e 20.3<br>

	_ Inicialização padrão, a falha de resolução de vídeo não acontece nesse modelo de notebook 
	_ devido a placa de vídeo e monitor atingir altas resoluções.

#05_ Driver da Placa de Rede Sem-Fio (Wi-Fi/Wireless)<br>

	_ Modelo Wireless, já reconhecido no Linux Mintsem necessidade de instalação de Driver/Módulos 
	_ para o seu funcionamento.

#06_ Hard Disk SATA HD Samsung 500GB 5400rpm<br>

	_ Modelo Samsung S227J56B410466 Hard Disk para a instalação do Linux Mint, sem necessidade de
	_ particionamento (instalação padrão).

#07_ Pós-Instalação do Linux Mint 20.1 Ulyssa, 20.2 Uma e 20.3 Una x64 Bits<br>

	_ Atualização do sistema utilizando o MintUpdate;
	_ Atualização do sistema utilizando o Apt;
		sudo apt update
		sudo apt upgrade
		sudo apt full-upgrade
		sudo apt dist-upgrade
		sudo apt autoremove
		sudo apt autoclean
		sudo apt clean
		sudo reboot (Reinicializar o Sistema)

#08_ Instalação do Linux Kernel OEM (versão do Kernel instalada >= 5.10.x suportado até 2025)<br>

		sudo apt update
		sudo uname -a
		sudo apt install linux-oem-20.04 fdutils
		sudo reboot (Reinicializar o Sistema)
		sudo uname -a

#09_ Instalação dos Aplicativos Básicos<br>

		sudo apt update
		sudo apt install software-properties-common build-essential lsb-core dkms
		sudo apt install htop nmon i8kutils psensor tlp tlp-rdw cpufrequtils cputool
		sudo apt install ttf-mscorefonts-installer cheese guvcview v4l-utils cairo-dock vim git p7zip-full p7zip-rar
		sudo reboot (Reinicializar o Sistema)

#10_ Instalação e Configuração dos Aplicativos utilizados no meu Dia-a-Dia<br>

	_ VirtualBOX: https://www.virtualbox.org/
		(link: https://github.com/vaamonde/dell-linuxmint/blob/master/software/virtualbox.md)

	_ NotepadQQ: https://notepadqq.com/s/
		sudo apt update && sudo apt install notepadqq

	_ Packet Tracer: https://www.packettracernetwork.com/
		(link: https://mega.nz/folder/Co9GHIyK#2kzNnN7XzImP01M1SyRm2g/folder/vll2iSDI)

	_ GNS3: https://www.gns3.com/
		(link: https://github.com/vaamonde/dell-linuxmint/blob/master/software/gns3.md)

	_ WPS Office: http://linux.wps.com/
		(link: https://linux.wps.com/)

	_ KolourPaint: https://kde.org/applications/en/graphics/org.kde.kolourpaint
		sudo apt update && sudo apt install kolourpaint

	_ VS Code: https://code.visualstudio.com/
		(extensions: Bash Beautify, BATS for VSCode, Brazilian Portuguese - Code Spell Checker 
		Pacote de Idioma Português Brasileiro para VS Code Shell-Format e Shell)

	_ Google Chrome: https://www.google.com/intl/pt-BR/chrome/

	_ Genymotion: https://www.genymotion.com/download/

	_ Kazam: https://launchpad.net/kazam
		sudo apt update && sudo apt install kazam

	_ Kdenlive: https://kdenlive.org/en/
		(link da versão AppImage >=20.08.2: https://kdenlive.org/en/download/)

	_ Audacity: https://www.audacityteam.org/
		sudo apt update && sudo apt install audacity

	_ OBS Studio: https://obsproject.com/pt-br
		(link da versão para Linux: https://obsproject.com/pt-br/download)
		
	_ Mega: https://mega.nz/
		(link da versão >=: https://mega.nz/sync)

	_ Teams: https://www.microsoft.com/pt-br/microsoft-365/microsoft-teams/download-app
		(link da versão >=1.3.00: https://www.microsoft.com/pt-br/microsoft-365/microsoft-teams/download-app#desktopAppDownloadregion)

	_ VLC: https://www.videolan.org/vlc/index.pt-BR.html
		sudo apt update && sudo apt install vlc

	_ Skype: https://www.skype.com/pt-br/
		(link da versão >=8.66.0.74: https://www.skype.com/pt-br/get-skype/)<br>

	_ Redshift: http://jonls.dk/redshift/
		(nativo no Linux Mint, versão >= 1.12)

	_ Timeshift: https://github.com/teejee2008/timeshift
		(nativo no Linux Mint, versão >= 20.03)

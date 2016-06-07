#!/bin/bash

LATINO_RUTA=/usr/local/bin/latino
CAT=/bin/cat
ECHO=/bin/echo
MAWK=/usr/bin/mawk
APT_GET=/usr/bin/apt-get
DNF=/usr/bin/dnf
DPKG=/usr/bin/dpkg
DPKG_RECONFIGURE=/usr/sbin/dpkg-reconfigure

# veriicar si ya esta instalado latino
# ver que version esta instalado, y 
# si la instalada es < solo actualizar
# si la instalada es = mensaje que ya esta instalado
# si la instalada es > mensaje de no instalar



MSG_APT_TITLE="Instalar Latino 0.5.0"
MSG_APT_WARN="Hola,\n\n Vamos a instalar latino\n\nDeseas continuar?"

if [ $(id -u) != 0 ] 
then
    ${ECHO} "Debes tener derechos de root."
    exit 1
fi

${DNF} install dialog mawk

FEDORA_VERSION_FILE=/etc/fedora-release
FEDORA_VERSION=`${CAT} ${FEDORA_VERSION_FILE} | ${MAWK} -F "." '{print $1;}'`

${DNF} install dialog

dialog --clear


if dialog --title "${MSG_APT_TITLE}" --yesno "${MSG_APT_WARN}" 18 70
then
    dialog --clear
    clear
else
    exit 0
fi

if [ "${FEDORA_VERSION_FILE}" > "23" ]
then
    
    ${ECHO} "**********************************"
    ${ECHO} "******   Latino 0.5.0   **********"
    ${ECHO} "* http://www.lengueje-latino.org *"
    ${ECHO} "* Fedora 23 "
	${ECHO} "**********************************"
    ${ECHO} ""
    ${DNF} update
    ${DNF} installgit
    ${DNF} install make automake gcc gcc-c++ kernel-devel
    ${DNF} install cmake
    ${DNF} groupinstall "Development Tools" "Development Libraries"
    
    git clone https://github.com/robincoello/latino.git
    
    cd latino
    cmake .
    make 
    make install
    cd ..
    clear
    latino -v
    cat latino/ayuda.txt
    
    latino patricia.lat
    ${ECHO} ""    
    ${ECHO} ""
    

    

elif [ "${DEB_VERSION}" = "6" ]
then
    ${ECHO} "Debian Squeeze"
    

elif [ "${DEB_VERSION}" = "5" ]
then
    ${ECHO} "Debian Lenny"

else
    UBUNTU_V_DATA=/etc/lsb-release
    if [ -f ${UBUNTU_V_DATA} ]
    then
	. ${UBUNTU_V_DATA}
	if [ "${DISTRIB_CODENAME}" = "precise" ]
	then

	    ${ECHO} "Ubuntu Precise Pangolin"
	    

	else
	    ${ECHO} "1 Debian version not supported"
	fi
    else
	${ECHO} - - ${DEB_VERSION} " 2 Debian version not supported"
    fi
fi


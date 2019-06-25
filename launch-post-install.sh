#!/bin/sh

## README
# /!\ Ce script d'installation est conçu pour mon usage. Ne le lancez pas sans vérifier chaque commande ! /!\

## Activation des logs
exec &> post-install.log

## La base : Homebrew
if test ! $(which brew)
then
	echo 'Installation de Homebrew'
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Vérifier que tout est bien à jour
brew update --verbose

echo 'Installation de Cask, pour installer les autres apps.'
brew tap caskroom/cask

## Installation de lastpass-cli pour récupèrer les accès
brew install lastpass-cli --verbose

lpass login benjamin.kaminski@outlook.com
lastpassstatus = lpass status

if [ == "Not logged in." ]; then
        echo "LastPass non connecté, exit"
        exit 1
fi
lpass logout
exit 0

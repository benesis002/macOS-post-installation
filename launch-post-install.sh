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


echo "30 9 * * * date >> /var/log/brew_auto_update.log && brew update --verbose >> /var/log/brew_auto_update.log && brew upgrade --verbose >> /var/log/brew_auto_update.log" > /tmp/matable
echo "30 10 * * * date >> /var/log/mas_auto_update.log && mas upgrade >> /var/log/mas_auto_update.log" >> /tmp/matable
echo "*/5 * * * * date >> /var/log/workspace_backup.log && gdrive sync upload --keep-local /Users/BENJAMIN/Workspace/* 1FeSKwf60nnl0sZFUQCoohbBMsFgw385h >> /var/log/workspace_backup.log" >> /tmp/matable
echo "30 9 * * * mkdir $HOME/Downloads/wallpaper && curl https://raw.githubusercontent.com/thejandroman/bing-wallpaper/master/bing-wallpaper.sh --output /tmp/bing-wallpaper.sh && chmod +x  /tmp/bing-wallpaper.sh && /tmp/bing-wallpaper.sh -p $HOME/Downloads/wallpaper -n monimage.jpg -f" >> /tmp/matable
crontab /tmp/matable
rm /tmp/matable

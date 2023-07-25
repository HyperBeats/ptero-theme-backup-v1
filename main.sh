#!/bin/bash

if (( $EUID != 0 )); then
    echo "Veuillez exécuter en tant que root"
    exit
fi

clear

BackupTheme(){
    cd /var/www/
    tar -cvf backup-panel.tar.gz pterodactyl
    echo "Installation du thème..."

}

restoreBackUp(){
    echo "Restauration de la sauvegarde..."
    cd /var/www/
    tar -xvf backup-panel.tar.gz

    cd /var/www/pterodactyl
    chmod -R 755 storage/* bootstrap/cache
    composer install --no-dev --optimize-autoloader
    yarn build:production
    sudo php artisan optimize:clear
}
echo "Copyright (c) 2023 Row-Hosting | row-hosting.fr"
echo ""
echo "Website: https://row-hosting.fr/"
echo ""
echo "[1] backup fichier panel"
echo "[2] Restaurer la sauvegarde"
echo "[3] Annuler"

read -p "Veuillez saisir un numéro: " choice
if [ $choice == "1" ]
    then
    BackupTheme
fi
if [ $choice == "2" ]
    then
    restoreBackUp
fi
if [ $choice == "3" ]
    then
    exit
fi

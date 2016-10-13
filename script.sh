#!/bin/bash

#VARIABLEN-LISTE(Bitte anpassen!)

#LISTE HIER DEINE SESSIONS AUF
#tmux ls ZEIGT DEINE SESSION MIT NAMEN AN
session_name='0'
#MINECRAFT ORDNER
minecraft_folder=/home/minecraft/server_private_tests
#BACKUP ORDNER
backup_folder=/private-backup
#BACKUP NAMEN
backup_name=serverbackup_full_test.tgz
#AKTUELLES DATUM
datum=$(date +%d.%m.%y)
echo $datum

echo "Script wird gestartet."
sleep 5s

echo "Server wird gestoppt"
#SERVER WIRD SICHER HERUNTERGEFAHREN!
tmux send-keys -t $session_name "stop" Enter
sleep 30s
echo "Server ist gestoppt."

#VERZEICHNIS WIRD GEWECHSELT
tmux send-keys -t $session_name "cd .." Enter
sleep 5s
							
#BACKUP WIRD ERSTELLT ---- SYNTAX: tar -czf Backupname.tgz			   Ordner der gepackt werden soll
tmux send-keys -t $session_name "tar -czf $backup_name $minecraft_folder " Enter
echo "Backup wird erstellt"
sleep 1m
echo "Backup wurde erstellt"

#BACKUP WIRD VERSCHOBEN ---- SYNTAX: mv Backupname.tgz			  Speicherort
tmux send-keys -t $session_name "mv $backup_name $backup_folder " Enter
echo "Backup verschoben"
sleep 5s

#VERZEICHNIS WIRD GEWECHSELT
tmux send-keys -t $session_name "cd $minecraft_folder " Enter
sleep 5s

#SERVER WIRD GESTARTET
tmux send-keys -t $session_name "./start.sh" Enter
sleep 5s
echo "Server gestartet"

#!/bin/bash

#VARIABLEN-LISTE(Bitte anpassen!)

#LISTE HIER DEINE SESSIONS AUF
#tmux ls ZEIGT DEINE SESSION MIT NAMEN AN
session_name=mc_server
#MINECRAFT ORDNER
minecraft_folder=/home/minecraft/server
#BACKUP ORDNER
backup_folder=/private-backup
#AKTUELLES DATUM
datum=$(date +%d_%m_%y)
#BACKUPNAME
backup_name=serverbackup_full_$datum.tgz
#SERVERNACHRICHT
server_message_30_min="Der Server wird in 30 Minuten neugestartet!"
server_message_15_min="Der Server wird in 15 Minuten neugestartet!"
server_message_5_min="Der Server wird in 5 Minuten neugestartet!"
server_message_1_min="Der Server wird in 1 Minuten neugestartet!"
server_message_30_sec="Der Server wird in 30 Sekunden neugestartet!"
server_message_10_sec="Der Server wird in 10 Sekunden neugestartet!"
server_message_5_sec="Der Server wird in 5 Sekunden neugestartet!"
################################################################################
echo "Script wird gestartet."
sleep 5s

echo "Servernachricht: t- 30 Minuten"
tmux send-keys -t $session_name "bc $server_message_30_min" Enter
sleep 30m
tmux send-keys -t $session_name "bc $server_message_15_min" Enter
sleep 15m
tmux send-keys -t $session_name "bc $server_message_5_min" Enter
sleep 5m
tmux send-keys -t $session_name "bc $server_message_1_min" Enter
sleep 1m
tmux send-keys -t $session_name "bc $server_message_30_sec" Enter
sleep 30s
tmux send-keys -t $session_name "bc $server_message_10_sec" Enter
sleep 10s
tmux send-keys -t $session_name "bc $server_message_5_sec" Enter
sleep 5s

echo "Server wird gestoppt"
#SERVER WIRD SICHER HERUNTERGEFAHREN!
tmux send-keys -t $session_name "stop" Enter
sleep 30s
echo "Server ist gestoppt."

#VERZEICHNIS WIRD GEWECHSELT
tmux send-keys -t $session_name "cd .." Enter
sleep 5s

#BACKUP WIRD ERSTELLT ---- SYNTAX: tar -czf Backupname.tgz Ordner_der_gepackt_werden_soll
tmux send-keys -t $session_name "tar -czf $backup_name $minecraft_folder " Enter
echo "Backup wird erstellt"
#!!EMPFEHLUNG!!!
#Zeit hochsetzen, sollte das Packen des Ordner nicht fertig sein und das Script läuft weiter
#kann es zu Datenverlust kommen!
sleep 1m
echo "Backup wurde erstellt"

#BACKUP WIRD VERSCHOBEN ---- SYNTAX: mv Backupname.tgz Speicherort
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

#!/bin/bash
# Prepare variables

FOLDER=data

echo "Checking if Folder $FOLDER exists ..."


# Check if folder exists
	if [ ! -d "/vault/$FOLDER" ]; then
	echo "Folder not found. Unzip data Folder ..."
        unzip /etc/vault/data.zip -d /vault/ 
	else
	echo "Folder Exists ..."
	fi


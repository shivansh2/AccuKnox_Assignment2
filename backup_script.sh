#!/bin/bash

SOURCE_DIR="pathToSourceDirectory"
REMOTE_USER="remote_user"
REMOTE_HOST="remote_host"
REMOTE_DIR="pathToRemoteDirectory"
LOG_FILE="pathToBackUpLogFile"

perform_backup() {
    echo "Starting backup of directory: $SOURCE_DIR"

    rsync -avz --delete "$SOURCE_DIR" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR" >> "$LOG_FILE" 2>&1

    if [ $? -eq 0 ]; then
        echo "Backup completed successfully."
    else
        echo "Backup failed. Check $LOG_FILE for details."
    fi
}

main() {
    if [ ! -d "$SOURCE_DIR" ]; then
        echo "Error: Source directory '$SOURCE_DIR' not found."
        exit 1
    fi

    LOG_DIR=$(dirname "$LOG_FILE")
    if [ ! -d "$LOG_DIR" ]; then
        mkdir -p "$LOG_DIR"
    fi

    perform_backup
}
main

#!/bin/bash
set -Eeuo pipefail

DOSSIER="${1:-}"
BACKUP_DIR="backups"

if [ -z "$DOSSIER" ]; then
    echo "Utilisation : ./backup.sh <dossier>"
    exit 1
fi

if [ ! -d "$DOSSIER" ]; then
    echo "Erreur : le dossier '$DOSSIER' n'existe pas." >&2
    exit 1
fi

mkdir -p "$BACKUP_DIR"

NOM_DOSSIER=$(basename "$DOSSIER")
DATE=$(date +%Y-%m-%d_%H-%M-%S)
ARCHIVE="$BACKUP_DIR/${NOM_DOSSIER}_${DATE}.tar.gz"

tar -czf "$ARCHIVE" "$DOSSIER"

echo "Sauvegarde créée : $ARCHIVE"

for fichier in "$BACKUP_DIR"/*.tar.gz; do
    [ -f "$fichier" ] || continue

    if find "$fichier" -maxdepth 0 -mtime +7 -print -quit | grep -q .; then
        rm "$fichier"
        echo "Ancienne sauvegarde supprimée : $fichier"
    fi
done

echo "Opération terminée."
exit 0

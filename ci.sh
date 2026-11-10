
#!/bin/bash
set -Eeuo pipefail

URL="${1:-}"
REPO_DIR="ci-repo"
LOG_FILE="ci.log"

# Fonction pour afficher et enregistrer les messages
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

# Vérifier si l'URL est vide
if [ -z "$URL" ]; then
    log "ERREUR : veuillez fournir l'URL du dépôt."
    exit 1
fi

# Cloner ou mettre à jour le dépôt
if [ -d "$REPO_DIR/.git" ]; then
    log "Mise à jour du dépôt..."
    if ! git -C "$REPO_DIR" pull; then
        log "ERREUR : impossible de mettre à jour le dépôt."
        exit 1
    fi
else
    log "Clonage du dépôt..."
    if ! git clone "$URL" "$REPO_DIR"; then
        log "ERREUR : impossible de cloner le dépôt."
        exit 1
    fi
fi

# Fonction qui exécute les tests
tests() {
    log "Début des tests..."

    for fichier in check_disk.sh backup.sh; do
        if [ ! -f "$REPO_DIR/$fichier" ]; then
            log "ÉCHEC : $fichier introuvable."
            return 1
        fi

        if ! bash -n "$REPO_DIR/$fichier"; then
            log "ÉCHEC : erreur de syntaxe dans $fichier."
            return 1
        fi

        log "TEST RÉUSSI : $fichier"
    done

    log "Tous les tests sont réussis."
    return 0
}

# Résultat final du pipeline
if tests; then
    log "PIPELINE RÉUSSI."
    exit 0
else
    log "PIPELINE ÉCHOUÉ."
    exit 1
fi

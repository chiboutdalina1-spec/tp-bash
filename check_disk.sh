
#!/bin/bash

SEUIL=${1:-80}
UTILISATION=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

if [ -z "$UTILISATION" ]; then
    echo "Erreur : impossible de lire l'utilisation du disque."
    exit 1
fi

if [ "$UTILISATION" -ge "$SEUIL" ]; then
    echo "ALERTE : espace disque utilisé à ${UTILISATION}% (seuil : ${SEUIL}%)."
    exit 1
else
    echo "Espace disque OK : ${UTILISATION}% utilisé."
    exit 0
fi

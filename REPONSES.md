# REPONSES.md
## TP N° 2 — Linux & Scripting Bash

### Exercice 2.1 — Navigation, recherche et permissions

**Question : Que donne chmod 644 sur un fichier ? Est-il exécutable par son propriétaire ?**

La commande chmod 644 donne les permissions suivantes :
- Propriétaire : lecture et écriture (rw-).
- Groupe : lecture uniquement (r--).
- Autres utilisateurs : lecture uniquement (r--).

Le fichier n'est donc pas exécutable par son propriétaire, car il ne possède pas la permission d'exécution (x).

### Exercice 2.2 — Vérification de l'espace disque

**Question : Pourquoi utilise-t-on des guillemets autour de "$UTILISATION" dans le test if ?**

On utilise les guillemets pour protéger la variable et éviter les problèmes si sa valeur est vide ou contient des espaces. Cela permet aussi d'éviter les erreurs lors de la comparaison.

### Exercice 2.3 — Script de sauvegarde avec boucle et gestion d'erreurs

**Question : Que se passe-t-il si vous enlevez set -Eeuo pipefail et que tar échoue ? Le script continue-t-il à tort ?**

Sans set -Eeuo pipefail, si la commande tar échoue, le script peut continuer à exécuter les instructions suivantes sans détecter correctement l'erreur. Il peut alors afficher que la sauvegarde est terminée alors que l'archive n'a pas été créée correctement.

Cette commande permet donc de mieux gérer les erreurs et d'arrêter le script lorsqu'une commande échoue.

### Exercice 2.4 — Planification avec cron

**Question : Pourquoi cron nécessite-t-il des chemins absolus alors qu'un script fonctionne très bien depuis votre terminal avec des chemins relatifs ?**

Cron exécute les tâches dans un environnement différent du terminal. Il ne se trouve pas forcément dans le même répertoire que notre script.

Un chemin relatif dépend du répertoire courant, tandis qu'un chemin absolu indique directement l'emplacement exact du fichier ou du dossier.

L'utilisation des chemins absolus permet donc d'éviter les erreurs et de garantir la bonne exécution automatique des scripts.

### Exercice 2.5 — Mini-projet d'intégration (préfiguration CI/CD)

**Question : Quelles étapes ajouteriez-vous pour transformer ce script en un vrai pipeline CI ? Quels seraient les points de défaillance à gérer avec des codes de retour ?**

Pour transformer ce script en un vrai pipeline CI, on pourrait ajouter plusieurs étapes :

1. Récupérer le code source depuis GitHub.
2. Installer les dépendances du projet.
3. Vérifier la qualité du code.
4. Exécuter les tests automatiquement.
5. Construire (build) le projet.
6. Générer et conserver les résultats des tests.
7. Déployer le projet si toutes les étapes réussissent.

Les points de défaillance possibles sont :
- Échec du clonage ou de la mise à jour du dépôt Git.
- Échec de l'installation des dépendances.
- Erreurs dans le code source.
- Échec des tests.
- Échec de la compilation.
- Échec du déploiement.

Le code de retour 0 indique que l'exécution a réussi, tandis qu'un code différent de 0 indique généralement une erreur. Le pipeline doit s'arrêter si une étape importante échoue.

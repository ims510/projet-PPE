---
layout: page
id: tableaux.md

---

# Tableaux 

Cette section regroupe trois tableaux contenant l'ensemble des données utilisées pour notre analyse linguistique. Chaque tableau correspond à une langue spécifique, nous avons donc un **tableau pour les liens en roumain**, un **tableau pour les liens en anglais** et un **tableau pour les liens en russe**. 

**Vous pouvez trouver le tableau créé pour le roumain** [ici](tableaux/tableau_roumain.html).

**Vous pouvez trouver le tableau créé pour l'anglais** [ici](tableaux/tableau_anglais.html).

**Vous pouvez trouver le tableau créé pour le russe** [ici](tableaux/tableau_russe.html).

En dehors des liens, tous nos tableaux sont identiques dans la forme.
**Chaque tableau contient 50 liens**, ils sont divisés par thématique : **20 liens pour la guerre en Ukraine**, **20 liens pour le conflit israélo-palestinien** et **10 pour la guerre en général**. Cette division des liens nous permet d'analyser plus précisement l'utilisation du mot "guerre" dans des contextes différents et ainsi confirmer ou non nos hypothèses linguistiques. Les colonnes de nos tableaux sont les suivantes :

- **Nombre** : cette colonne permet de numéroter nos lignes.

- **Code HTTP** : cette colonne extrait le code HTTP. Lorsqu'on utilise des outils qui requêtent des pages web (par exemple : un navigateur), le code HTTP permet d'avoir une idée du résultat d'une requête. Chaque code correspond à une réponse (1xx : information, 200 : réussite, 3xx : redirection, 4xx : erreur du client, 5xx : erreur du serveur).

- **URL** : cette colonne contient l'URL de chacun de nos liens.

- **Encodage** : cette colonne contient l'encodage de chaque page web. Si une cellule de cette colonne est vide, cela veut dire que la page web va utiliser l'encodage par défaut du navigateur.

- **Aspirations** : cette colonne sauvegarde chaque page web dans un fichier texte.

- **Dumps** : cette colonne sauvegarde uniquement le contenu textuel de chaque page web dans un fichier texte. 

- **Nombre d'occurences** : cette colonne affiche le nombre d'occurences des mots pris en compte par chacune de nos expressions régulières. 

- **Contexte** : cette colonne isole chaque occurence entourée d'une ligne de texte au dessus et en dessous. Ces contextes sont ensuite sauvegardés dans des fichiers textes (un fichier par lien).

- **Concordances** : cette colonne renvoie à une page représentant chaque occurence entourée de 5 mots à gauche et 5 mots à droite. 


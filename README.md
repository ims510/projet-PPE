# projet-PPE
Projet PPE sur le mot "guerre" 

## Choix du mot : 
Nous avons choisi le mot guerre à l’unanimité car il était très présent dans l’actualité que cela soit par rapport à la guerre en Ukraine ou bien au conflit Israélo-Palestinien. Initialement, nous avions prévu d’uniquement nous intéresser à la guerre en Ukraine mais l’escalade des affrontement au moyen-orient nous on fait nous rendre compte que ces deux conflits étaient traités de manière différente dans les médias. Nous avons donc trouvé intéressant de voir si notre intuition était averée ou non. 

Anglais :

Roumain :

Russe : 

## Choix des liens :
En faisant des recherches plus générales, nous avons remarqué qu’il y avait plusieurs types de sites pouvant contenir le mot « guerre ». La majorité étaient des sites d’actualités et le reste des informations plus générales sur les guerres (par conflit et dans le domaine culturel ou sportif). Nous nous sommes donc mises d’accord pour avoir 50 liens chacune dont 20 sur la guerre en Ukraine, 20 sur le conflit Israélo-Palestinien, et le reste sur généralités citées précedemment. 



## Script pour la création des tableaux :
Après avoir choisi notre mot, nous avons utilisé le script du mini-projet puis l’avons adapté aux besoins de notre projet. 

- Nous avons  commencé par ajouter une colonne « Aspirations » à notre tableau. Cette colonne contient un lien amenant à la page html de chacun de nos liens. Comme nous avions déjà une variable N qui comptait le nombre de liens dans la liste, nous l’avons ré-utilisé pour nommer tous nos fichiers html sous la forme « url_<langue>_$N.html ». 

```
ASPIRATION=$(curl -s -L ${line} > ../aspirations/url_en_$N.html)
```

- Nous avons ensuite ajouté une colonne "Dump" à notre tableau. Cette colonne contient un lien amenant à un fichier texte contenant uniquement le contenu textuel de chaque page web. Pour oibtenir ce contenu textuel, nous avons utilisé la commande lynx :

```
DUMP=$(lynx -dump -nolist --display_charset=utf-8 ../aspirations/url_en_$N.html > ../dumps-text/dump_en_$N.txt)
```

Kehina : 

Nous avons précisé à Lynx l'encodage d'affichage de chacun de nos fichiers essentiellement pour pouvoir afficher correctement les caractères diacrités du roumain et l'alphabet cyrillique. 

- Nous avons ensuite ajouté une autre colonne "Nombre d'occurences" à notre tableau. Cette colonne contient le nombre d'occurence du mot "guerre" dans chaque fichier dump crée précedemment. Pour obtenir ce nombre, nous avons utilisé les commandes egrep et wc associées à nos expressions régulières : 

```
WORDCOUNT=$(cat ../dumps-text/dump_en_$N.txt | egrep -o "(wars?)|(WARS?)"| wc -w)
```

- Enfin, nous avons ajouté une colonne "Contextes" à notre tableau. Cette colonen contient un lien menant à un fichier texte contenant toutes les occurences du mot "guerre" entouré par une ligne de la page web de chaque coté. Nous avons utilisé la commande sed pour supprimer les éventuelles lignes vides (avant ou après notre mot) :

```
cat ../dumps-text/dump_en_$N.txt | sed '/^$/d'| egrep -C 1 "(wars?)|(WARS?)" > ../contexte/contexte_en_$N.txt
```

## Création des pages HTML :
Nous avons choisi d'utiliser un template html à la place d'avoir les balises html dans notre script bash pour faciliter la lecture et éviter de relancer à chaque fois notre script lors des futures modifications de la page. 

Nous avons donc ajouté à la fin de chacun de nos scripts la ligne suivante : 

```
sed "s|<!-- Table -->|$TABLE|g" template_anglais.html > "$FILE_PATH_OUT"
```

Nous venons remplacer le commentaire < !-- Table -- > par le tableau que nous obtenons lorsque nous excécutons le script. 
Nous avons également remplacé les slashs par des pipes pour éviter les mauvaises interprétations. 


## Difficultés : 
Nous avons essayé de faire le dernier exercice de la fiche "Concordances". Nous avons premièrement cherché à garder uniquement jusqu'à 5 mots à gauche et à droite des occurences de notre mot cible. 
Nous avons crée un script spécifique pour cet exercice que nous avions prévu d'appeler dans notre script principal. 


Pour celà, nous avions utilisé sed pour essayer de supprimer le mot et le contexte droit (pour obtenir le contexte gauche) et inversement. Nous n'avons cependant pas réussi à remplacer notre commentaire $TABLE par le résultat de notre script "concordance". Nous obtenions l'erreur : 

![Alt text](image.png)

Nous avons essayé de remplacer les pipes par d'autres caractères. Nous avons également essayé d'ajuster notre expressions régulières car nous avons appris que sed ne prend pas plus de 9 groupes d'expressions régulières.

## À faire pour la prochaine fois : 
- Arriver à faire une page HTML pour les concordances de chaque lien.
- Ajouter les liens vers pages anglaises, roumaines et russes dans l'index html. 
- Trouver un thème général pour la présentation de nos pages. 
- Finaliser et affiner nos listes d'URL. 

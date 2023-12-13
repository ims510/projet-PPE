﻿# Projet PPE:
### - Elisa LEPLUVIER (Russe) 
### - Kehina MANSERI (Anglais) 
### - Ioana-Madalina SILAI (Roumain)

## Choix du mot : 
Nous avons choisi le mot guerre à l’unanimité car il était très présent dans l’actualité que cela soit par rapport à la guerre en Ukraine ou bien au conflit Israélo-Palestinien. Initialement, nous avions prévu d’uniquement nous intéresser à la guerre en Ukraine mais l’escalade des affrontement au moyen-orient nous a fait nous rendre compte que ces deux conflits étaient traités de manière différente dans les médias. Nous avons donc trouvé intéressant de voir si notre intuition était averée ou non. 

- **Anglais :**
    * J'ai considéré que le choix du mot "guerre" était intéressant car les médias anglophones (américains, britanniques ou autres) apportent le point de vu "occidental" ou de l'"ouest" par rapport à certains conflits. L'Angleterre comme les États-Unis ont par exemple apporté leurs soutiens au peuple ukrainien.
    * Dans le cas du conflit Israélo-Palestinien, les États-Unis ont apporté leur soutient à Israël. Nous nous sommes demandés si le traitement des deux conflits était traité différement dans les médias anglais.
    * Kehina : Pour ce qui est du mot, j'ai contrairement à mes camarades eu beaucoup moins de mal à créer une expression régulière pouvant prendre en compte toutes les occurences du mot guerre. Je n'ai eu par exemple qu'à prendre en compte une seule variation du mot, celle du pluriel. 
    * Les formes du mots que je vais chercher seront : 
    1. war = guerre
    2. WAR = guerre
    3. Wars = guerres
    4. WARS = guerres

- **Roumain (Ioana-Madalina Silai):** 
    * J'ai consideré que ce mot est intéressant pour le roumain dans le contexte de la guerre en Ukraine grâce à la position geographique du pays, ce qui a fait que cette guerre a était un evenement majeur pour la Roumaine aussi. 
    * Lorsque le conflit Israélo-Palestinien a commencé, c'était intéressant de voir la difference entre les mentions de cette guerre et celle de l'Ukraine dans les medias roumaines.
    * En ce qui concerne le mot en soi, il s'agit d'un nom du genre neutre (masculin au singulier, feminin au pluriel), qui fait que le mot change beaucoup en fonction du contexte. De plus, en roumain les articles sont des suffixes, donc on ne peut pas les ignorer quand on cherche le mot. 
    * Les formes du mots que je vais chercher donc seront:
    1. război = guerre 
    2. războaie = guerres
    3. războiul = la guerre
    4. războaiele = les guerres
    5. războiului = à la / de la guerre 
    6. războaielor = aux / des guerres

- Russe : 

## Choix des liens :
En faisant des recherches plus générales, nous avons remarqué qu’il y avait plusieurs types de sites pouvant contenir le mot « guerre ». La majorité étaient des sites d’actualités et le reste des informations plus générales sur les guerres (par conflit et dans le domaine culturel ou sportif). Nous nous sommes donc mises d’accord pour avoir 50 liens chacune dont 20 sur la guerre en Ukraine, 20 sur le conflit Israélo-Palestinien, et le reste sur généralités citées précedemment. 



## Script pour la création des tableaux :
Après avoir choisi notre mot, nous avons utilisé le script du mini-projet, que nous avons ensuite adapté aux besoins de notre projet. 

- Nous avons commencé par ajouter une colonne « Aspirations » à notre tableau. Cette colonne contient un lien amenant à la page html de chacun de nos liens. Comme nous avions déjà une variable N qui comptait le nombre de liens dans la liste, nous l’avons ré-utilisé pour nommer tous nos fichiers html sous la forme « url_<langue>_$N.html ». 

```
ASPIRATION=$(curl -s -L ${line} > ../aspirations/url_en_$N.html)
```

- Nous avons ensuite ajouté une colonne "Dump" à notre tableau. Cette colonne contient un lien amenant à un fichier texte contenant uniquement le contenu textuel de chaque page web. Pour oibtenir ce contenu textuel, nous avons utilisé la commande lynx :

```
DUMP=$(lynx -dump -nolist --display_charset=utf-8 ../aspirations/url_en_$N.html > ../dumps-text/dump_en_$N.txt)
```

Nous avons précisé à Lynx l'encodage d'affichage de chacun de nos fichiers essentiellement pour pouvoir afficher correctement les caractères diacrités du roumain et l'alphabet cyrillique. 

_Kehina MANSERI:_ 

_Ioana-Madalina SILAI :_ J'utilise Safari comme browser principal, qui n'ouvre pas les fichiers dumps avec l'encodage UTF-8, sauf si on fait un changement dans les paramètres du browser à chaque ouverture d'un nouveau fichier dump. Je ne sais pas s'il y a une autre commande que je devrais utiliser dans ce cas, car je n'ai trouvé pas une solution, à part utiliser un autre browser.


- Nous avons ensuite ajouté une autre colonne "Nombre d'occurences" à notre tableau. Cette colonne contient le nombre d'occurence du mot "guerre" dans chaque fichier dump crée précedemment. Pour obtenir ce nombre, nous avons utilisé les commandes egrep et wc associées à nos expressions régulières : 

_Kehina MANSERI:_ 
```
WORDCOUNT=$(cat ../dumps-text/dump_en_$N.txt | egrep -o "(wars?)|(WARS?)"| wc -w)
```
_Ioana-Madalina SILAI :_ 

```
WORDCOUNT=$(cat ../dumps-text/dump_ro_$N.txt | egrep -o "[Rr]ăzbo((iul)|(iului)|(aiele)|(aie)|(aielor)|i)"| wc -w)
```

- Enfin, nous avons ajouté une colonne "Contextes" à notre tableau. Cette colonne contient un lien menant à un fichier texte contenant toutes les occurences du mot "guerre" entouré par une ligne de la page web de chaque coté. Pour obtenir une ligne avant et après le mot nous avons utilisé l'option `-C 1` après la commande `egrep`. Nous avons aussi utilisé la commande sed pour supprimer les éventuelles lignes vides (avant ou après notre mot) :

_Kehina MANSERI:_ 
```
cat ../dumps-text/dump_en_$N.txt | sed '/^$/d'| egrep -C 1 "(wars?)|(WARS?)" > ../contexte/contexte_en_$N.txt
```

_Ioana-Madalina SILAI :_ 

```
cat ../dumps-text/dump_ro_$N.txt | sed '/^$/d'| egrep -C 1 "[Rr]ăzbo((iul)|(iului)|(aiele)|(aie)|(aielor)|i)" > ../contexte/contexte_ro_$N.txt
```

## Création des pages HTML :
Nous avons choisi d'utiliser un template html à la place d'avoir les balises html dans notre script bash pour faciliter la lecture et éviter de relancer à chaque fois notre script lors des futures modifications de la page. 

Nous avons donc ajouté à la fin de chacun de nos scripts la ligne suivante : 

```
sed "s|<!-- Table -->|$TABLE|g" template_anglais.html > "$FILE_PATH_OUT"
```

Nous venons remplacer le commentaire < !-- Table -- > qui se trouve dans le template par le tableau que nous obtenons lorsque nous excécutons le script. 
Nous avons également remplacé les slashs (la syntaxe initiale étant `sed "s/element_a_remplacer/element_remplaçant/g"`) par des pipes pour éviter les mauvaises interprétations. 


## Difficultés : 
Nous avons essayé de faire le dernier exercice de la fiche "Concordances". Nous avons premièrement cherché à garder uniquement jusqu'à 5 mots à gauche et à droite des occurences de notre mot cible. 
Nous avons crée un script spécifique pour cet exercice (`concordancier_roumain.sh`) que nous avions prévu d'appeler dans notre script principal. 

Pour celà, nous avions utilisé sed pour essayer de supprimer le mot et le contexte droit (pour obtenir le contexte gauche) et inversement. Nous n'avons cependant pas réussi à remplacer notre commentaire $TABLE par le résultat de notre script "concordance". Nous obtenions l'erreur : 

![Alt text](image.png)

Nous avons essayé de remplacer les pipes par d'autres caractères. Nous avons également essayé d'ajuster notre expressions régulières car nous avons appris que sed ne prend pas plus de 9 groupes d'expressions régulières. Même si cette commande fonctionne bien dans notre script principal, elle ne semble pas fonctionner ici.

## À faire pour la prochaine fois : 
- Arriver à faire une page HTML pour les concordances de chaque lien.
- Ajouter les liens vers pages anglaises, roumaines et russes dans l'index html. 
- Trouver un thème général pour la présentation de nos pages. 
- Finaliser et affiner nos listes d'URL. 

## Itrameur : 

Nous avons fait le script pour introduire les balises qui lui permettront d'être chargé sur Itrameur.

```
cat ../dumps-text/dump_${URL_LANG}_$N.txt | sed "s|&|&amp;|g" | sed "s|<|&lt;|g" | sed "s|>|&gt;|g" >> $FOLDER/dump-$URL_LANG.txt
cat ../contexte/contexte_${URL_LANG}_$N.txt | sed "s|&|&amp;|g" | sed "s|<|&lt;|g" | sed "s|>|&gt;|g" >> $FOLDER/contexte-$URL_LANG.txt
```

L'écriture de ce script s'est avéré assez simple car il nous a suffit de ré-utiliser des concepts appris auparavant. De plus, comme nous donnons le code de la langue en argument (ro, ru ou en), nous n'avons pas eu besoin de faire 3 scripts différents.

## Programmes Python Autonomous Lafon specificity Scripts (PALS) :

Nous avons eu beaucoup plus de mal avec cette partie du travail car elle n'était pas clairement expliquée sur la fiche d'exercices. Nous ne savions par exemple pas si elle était reservée aux groupes avec certaines langues ou non.

Nous avons initialement essayé d'uiliser le programme coocurrences avec les fichiers obtenus grâce au script Itrameur mais les résultats nous ont paru étranges. Nous avons donc relu la documentation plus attentivement et nous nous sommes rendues compte que les scripts python peuvent analyser des fichiers textes seulement s'ils sont déjà tockénisés et s'il y a au moins une ligne vide entre chaque phrase. 
Pour cela, nous avons écrit un script à partir d'une commande qui semblait fonctionner dans le terminal :

```
	cat ../dumps-text/dump_ro_1.txt | tr -cs "[:alpha:]." "\n" | sed "s/\./\n/g"
```

Notre script fonctionnait parfaitement pour l'anglais mais ne semblait pas fonctionner pour le roumain. Le fichier obtenu remplaçait les caractères diacrités par des sauts de ligne malgré l'encodage du fichier en UTF-8 (vu sur l'éditeur de texte et confirmé par les commandes `chardet` et `uchardet`).

Après de longues recherches, il s'est avéré que le problème résidait dans le nom que nous avions attribué à l'une de nos variables. En effet, nous avions appelé la variable qui correspondait à la langue du nom de notre fichier "LANG". Ce nom se confondait alors avec les paramètres de notre locale. Nous avons donc fini par la renommer "URL_LANG".

Nous avons ensuite lancé le programme coocurences avec le fichier obtenu. Il est compliqué de savoir si nos résultats sont bons car les données ne s'affichent pas correctement et que nous avons du mal à comprendre ce à quoi correspond chaque valeur et colonne.

Nous n'avons également pas énormement compris ce que l'on devait faire avec nos résultats I-trameur. Nous avons attentivement regardé les projets de l'année dernière et beaucoup avaient utilisés des captures d'écran mais il n'était précisé nulle-part dans la fiche que nous devions faire de même ou même ajouter des pages HTML ou écrire des analyses de nos résultats.

Nous ne sommes enfin pas sûre de comprendre s'il faut obtenir un seul fichier avec les contextes concaténés de chaque langue ou bien garder un fichier par langue.

Pour ce qui est de l'interface graphique, nous sommes inquiètes de ne pas avoir le temps de créer notre page. Nous ne savons pas s'il faut suivre les thèmes graphiques des années précédentes ou bien faire complétement autre chose.
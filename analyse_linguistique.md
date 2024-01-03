---
layout: page
id: analyse_linguistique.md

---
# Analyse linguistique

Cette section regroupe les analyses linguistiques **I-trameur**, **PALS** et **nuages de mots** de chacune de nos langues.

**Pour voir l'analyse linguistique du roumain, cliquez [ici](itrameur/analyse_linguistique_roumain.md).**

**Pour voir l'analyse linguistique de l'anglais, cliquez [ici](itrameur/analyse_linguistique_anglais.md).**

## Analyse I-trameur :

iTrameur est un outil et logiciel de textométrie utilisé pour l'analyse automatique, statistique et documentaire de textes en vue de leur profilage sémantique, thématique et de leur interprétation.

Les traitements statistiques nous ont permis d'intérpeter et commenter les résultats de nos analyses afin de les confronter à nos hypothéses de départ. L'hypothèse générale de notre étude était : **le contexte linguistique de nos occurrences varie en fonction des conflits étudiés**. 

I-trameur requiert un corpus préparé et délimité à l'aide de balises XML, par exemple : 

```
<lang=”fr”>
<page=”fr-1”>
<text>Ici, le contenu du fichier fr-1.</text> </page> §
<page=”fr-2”>
<text>Là, le contenu du fichier fr-2.</text> </page> §
</lang>
```

Ce balisage a été réalisé à l'aide de ce [script](programmes/make_itrameur_corpus.sh).

Les résultats pouvant être obtenus grâce à l'outil I-trameur sont notamment ceux concernant la fréquence du mot dans un corpus, la fréquence de cooccurrences d'un autre mot par rapport à ce dernier et les contextes linguistiques droit et gauche. 

**I-trameur connait cependant une limitation, il ne peut être utilisé qu'à partir d'un mot et non pas d'une expression régulière**. Dans le cadre de notre projet (et notamment au vue du roumain qui comporte plusieurs déclinaisons du même mot), nous avons donc dû avoir recours à un autre outil. 

## Programmes Python Autonomous Lafon specificity Scripts (PALS) :

Le script Programmes Python Autonomous Lafon specificity Scripts (PALS) nous a permis d'effectuer une analyse similaire à celle proposée par I-trameur mais avec la possibilité d'utiliser une expression régulière comme sujet d'analyse.

## Nuage de mot :

Le nuage de mot est une représentation visuelle de mots où la taille de chaque mot dépend de sa fréquence d'apparition dans un ensemble de données.



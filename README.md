# Trafic Bordellais
Bastien Metais
Nathan Greffier

# Version
Dart : 2.18.4 \
Flutter : 3.3.8

# Platerforme
Le développement à été effectué sur un Iphone 14 pro max sous iOS 16.1 \
Le test de lancement et de l'installation de l'application à été effectué sur un Pixel 4 sous l'API 33 (requise par certains plugins)

# Maquette
Une maquette a initialement été imaginé : https://www.figma.com/file/nfPsQXFBpGvkUZakFDH5FP/Application-Trafic-Bordelais?node-id=1%3A20&t=5YnKGnV77rJh3loV-1
# Features

## Getx
La gestion d'état a été faite avec Getx, amenant avec lui beaucoup de fonctionnalité (tel que les SnackBar ou encore l'internationalisation) 

## Shared preferences
Les préférences de l'utilisateur sont gérées avec shared preferences, tel que le thème de l'application ou encore la langue 

## Internationalisation
L'internationalisation a été gérée avec Getx, il est possible de passer l'application en français ou en anglais 

Liste des fonctionnalités implémentées : 

- Connexion / Inscription avec Firebase Authentication

- Changer le thème de l'application, nous avons implémenté un mode sombre. Le mode sombre est géré avec shared preferences.

- Recherchez un emplacement dans la ville de Bordeaux et obtenez des informations sur l'état de la circulation autour de cet emplacement après sa séléction. Nous utilisons une API de Bordeaux, cette API nous donne les informations sur l'état de la circulation pour chaque route de la ville. Nous avons défini quatre états : vert pour une circulation fluide, orange pour une circulation dense, gris pour un état inconnu et rouge pour des embouteillages.

- Rafrachissement des données de l'API toutes les 5 minutes. Possibilité de forcer le rafraichissement manuellement. (Blocage du bouton pendant le rafraichissement si celui-ci est cliqué trop de fois)

- Nous avons géré l'internationalisation. Il est possible de passer l'application en français ou en anglais. (également géré avec shared preferences)
# Sample - iOS

L'application permet de récupération des informations d'actualité (Article,émission,édition...) 

## Started
Dans le Sample , j'ai mis en place deux méthodologies de récupération de donnnées.
1-Soit on récupère les données à l'ouverture, c'est-à-dire on bloque l'ouverture de l'application jusqu'à avoir des informations disponibles, c'est le mode Synchrone.
2-Soit on charge la vue, et après on va charger les données avec un mode Asynchrone.

Vous pouvez commenter une et décommenter l'autre pour tester.

## Manager
Pour éviter plusieurs appels recursifs sur le serveur et aussi l'utilisation abusive de bonde passante d'internet, j'ai implémenté la solution suivante :
Récupération du programme avec mise en cache.
Si le programme est disponible en cache et qu'il a été rechargé il y a moins de <minIntervalReload> secondes alors on fait appel a l'utilisation de la cache et ne pas depuis le WS. 
Sinon on fait un appel au WS pour récupérer le programme et mise en cache.

Bien évidemment l'utilisateur peut raffléchire à tout manuellement le programme par un "pull to refresh" ou une autre solutions.

## User Interface

Inspirer de l'application disponblie actuelement sur le store..


## Getting Started

Pas d'instruction pour complier le projet

### Prerequisites

Version d'Xcode

```
Xcode Version 9.3 (9E145)   
SWIFT 4.1
```

### Installing

En cas d'erreur de complication 

```
Pod install
```

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON) - The better way to deal with JSON data in Swift
* [XCGLogger](https://github.com/DaveWoodCom/XCGLogger) - A debug log framework for use in Swift projects 
* [SDWebImage](https://github.com/rs/SDWebImage) - Asynchronous image downloader with cache support as a UIImageView category


## Authors

* **SELMI Oussama** - *Lead developer iOS* - [GITHUB](https://github.com/oselmiFrance24)


## License

FREE LICENSE


//
//  UrlsEnum.swift
//  SampleBFM
//
//  Created by SELMI Oussama on 06/04/2018.
//  Copyright © 2018 Next Radio TV. All rights reserved.
//

import Foundation

enum BaseURLs: String {
    
/// Exemple de cas reel ou peut avoir plusieur Target de chaine ou d'environement //
///
/*
     #if ENV_APPSTORE
        case WS_URL = "https://interview-project-api.firebaseio.com/contents.json"
        case WS_HTTPS_URL = "https://interview-project-api.firebaseio.com/contents.json"

      #elseif ENV_RECETTE
        case WS_URL = "https://interview-project-api.firebaseio.com/contents.json"
        case WS_HTTPS_URL = "https://interview-project-api.firebaseio.com/contents.json"

    #else
 */
    case WS_URL = "http://interview-project-api.firebaseio.com/contents.json"
    case WS_HTTPS_URL = "https://interview-project-api.firebaseio.com/contents.json"
    
//    #endif
}

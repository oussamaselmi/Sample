//
//  Product.swift
//  SampleBFM
//
//  Created by SELMI Oussama on 07/04/2018.
//  Copyright © 2018 Next Radio TV. All rights reserved.
//

import Foundation
import SwiftyJSON

class Product {
    
    var items : Array<Article>
    var type  : String?
    
    required init(json: JSON){
        
        self.type = json["type"].stringValue
        self.items = Array<Article>()
        if self.type == "article"{
        for article in json["items"].arrayValue{
            self.items.append(Article.init(json: article))
        }}else{
            // Un autre type , exemple : Edition - Video - Lien Externe...
        }
    }
}

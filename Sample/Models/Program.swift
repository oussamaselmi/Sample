//
//  Program.swift
//  SampleBFM
//
//  Created by SELMI Oussama on 07/04/2018.
//  Copyright © 2018 Next Radio TV. All rights reserved.
//

import Foundation
import SwiftyJSON

class Program {

    var elements : Array<Product>
    var template : String?
    var title    : String?

    required init(json: JSON){
        self.title = json["title"].stringValue
        self.template = json["template"].stringValue
        self.elements = Array<Product>()
        for elmt in json["elements"].arrayValue {
            self.elements.append(Product.init(json:elmt))
        }
    }
}

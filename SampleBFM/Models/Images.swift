//
//  Images.swift
//  SampleBFM
//
//  Created by SELMI Oussama on 07/04/2018.
//  Copyright © 2018 Next Radio TV. All rights reserved.
//

import Foundation
import SwiftyJSON

class Images {
    
    var imageTitle              : String
    var imageUrl                : String
    var imageCaption            : String
    var imageCopyright          : String
    var imageHeight             : Int
    var imageWidth              : Int

    required init(json: JSON){

        self.imageTitle = json["image_title"].stringValue
        self.imageUrl = json["image_url"].stringValue
        self.imageCaption = json["image_caption"].stringValue
        self.imageCopyright = json["image_copyright"].stringValue
        self.imageHeight = json["image_height"].intValue
        self.imageWidth = json["image_width"].intValue
                
    }
}

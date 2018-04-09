//
//  Article.swift
//  SampleBFM
//
//  Created by SELMI Oussama on 07/04/2018.
//  Copyright © 2018 Next Radio TV. All rights reserved.
//

import Foundation
import SwiftyJSON

class Article {
    
    var articleId    : Int?
    var chapo        : String?
    var comments     : Int?
    var content      : String?
    var dateArticle  : Date?
    var editDate     : Date?
    var images       : Images?
    var keywords     : String?
    var title        : String?
    var type         : String?
   
    var sectionTitle     : String?
    var sectionId        : AnyObject? // Int/String
    var subSectionTitle  : String?
    var subSectionId     : AnyObject? // Int/String
    
    required init(json: JSON){
    
        self.articleId = json["article"].intValue
        self.chapo = json["chapo"].stringValue
        self.comments = json["comments"].intValue
        self.content = json["content"].stringValue
        self.dateArticle = Date(timeIntervalSince1970: json["date"].doubleValue)
        self.editDate = Date(timeIntervalSince1970: json["edit_date"].doubleValue)
        self.keywords = json["keywords"].stringValue
        self.title = json["title"].stringValue
        self.type = json["type"].stringValue
        self.images = Images.init(json: json["image"])
    }
    }

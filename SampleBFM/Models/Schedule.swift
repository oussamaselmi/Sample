//
//  Schedule.swift
//  SampleBFM
//
//  Created by SELMI Oussama on 07/04/2018.
//  Copyright © 2018 Next Radio TV. All rights reserved.
//

import Foundation
import SwiftyJSON

class Schedule{
    
    var programs : Array<Program>
    var dateLastReloadWS: Date // Attribut permettant de connaître la date de la donnée, en effet le programme change au cours de la journée et est rechargé plussieurs fois

    required init(json: JSON){
        self.programs = Array<Program>()
        for prog in json.arrayValue {
            self.programs.append(Program.init(json: prog))
        }
        self.dateLastReloadWS = Date();

    }
}


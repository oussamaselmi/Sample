//
//  ProgrammeRequestor.swift
//  SampleBFM
//
//  Created by SELMI Oussama on 07/04/2018.
//  Copyright © 2018 Next Radio TV. All rights reserved.
//

import Foundation
import SwiftyJSON

class ProgrammeRequestor: RestApiManager {
    
    static let sharedInstance = ProgrammeRequestor()
    
    private override init() {
        super.init()
    }
    
    /// Identification du programme sur une date via appel WS
    /// Appel WS effectué de manière synchrone ou asynchrone
    ///
    /// - Parameters:
    ///   - jour: date du programme
    ///   - async: flag asynchrone ou synchrone
    ///   - completion: données de Programme / Erreur sur l'appel WS
    public func getProgramme(jour: Date, async:Bool, completion: @escaping (_ programme: Schedule?, _ error: Error?) -> Void){
        
        let path = BaseURLs.WS_HTTPS_URL.rawValue
        
        if(async){
            log.info("Début de récupération du programme de manière asynchrone");
            get(request: dataURLRequest(path: path, params:nil), async: true) { (success, object, error) -> () in
                DispatchQueue.main.async { () -> Void in
                    self.getProgrammeData(success, object, error, completion: completion)
                }
            }
        }
        else{
            log.info("Début de récupération du programme de manière synchrone");
            get(request: dataURLRequest(path: path, params: nil), async: false) { (success, object, error) -> () in
                self.getProgrammeData(success, object, error, completion: completion)
            }
        }
    }
    
    
    /// Parsing des données de programme
    /// A partir d'un objet standard retournée par le WS les données sont transformées en données Programme / Date de programme disponible / Erreur sur l'appel WS
    ///
    /// - Parameters:
    ///   - success: flag sur la réponse du WS en succès ou échec
    ///   - object: datas retournées par le WS
    ///   - error: erreur retournée par le WS
    ///   - completion: données de Programme /  Erreur sur l'appel WS
    public func getProgrammeData(_ success: Bool, _ object: AnyObject?, _ error: Error?, completion: @escaping (_ programme: Schedule?, _ error: Error?) -> Void){
        if (error==nil) {
            if success && (object != nil) {
                let responseDict = object as! NSArray
                let responseJSON = JSON.init(responseDict)
                let prog: Schedule = Schedule(json: responseJSON)
                
                completion(prog, nil)
            }
            else {
                completion(nil, nil)
            }
        }
        else {
            completion(nil, nil)
        }
    }
}

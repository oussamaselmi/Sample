//
//  ProgramRequestManager.swift
//  SampleBFM
//
//  Created by SELMI Oussama on 07/04/2018.
//  Copyright © 2018 Next Radio TV. All rights reserved.
//

import Foundation
private let sharedInstance = ProgramRequestManager()
class  ProgramRequestManager
{
    // Constantes
    // Intervale de temps en secondes minimum entre 2 reload de données programme
    let minIntervalReload:Int = 3*60 // 3 min
    
    // Variables de classes
    // Les programmes
    var programs:[String:Schedule];
    
    class var sharedInstance: ProgramRequestManager {
        struct Static {
            static let instance = ProgramRequestManager()
        }
        return Static.instance
    }
    
    init()
    {
        programs = [String:Schedule]();
    }
    
    /// Récupération du programme avec mise en cacheé rechargé depuis
    /// Si le programme est disponible en cache et qu'il a été rechargé il y a moins de <minIntervalReload> secondes alors utilisation de la cache et pas d'appel WS. Sinon appel WS pour récupérer le programme et mise en cache
    ///
    /// - Parameters:
    ///   - myDate: date du programme recherché
    ///   - async: load du programme en synchrone ou async
    ///   - completion: datas programme / success
    func loadProgramAtDate(myDate:Date,async:Bool,completion: @escaping (_ programme: Schedule?, _ success: Bool) -> Void)->Void
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd";
        let dateProgWithoutTime:String = dateFormatter.string(from: myDate);
        let isProgramInCache = self.programs.index(forKey: dateProgWithoutTime) != nil;
        
        // Le dernier reload des données n'a pas eu lieu il y a moins de <minIntervalReload> secondes ?
        // Il y a besoin d'un appel WS ?
        // i.e : le programme est déjà en cache et sa date de dernier reload date d'il y a moins de <minIntervalReload> secondes
        if !isProgramInCache || programNeedReload(program: self.programs[dateProgWithoutTime]){
            
            // Appel WS
            ProgrammeRequestor.sharedInstance.getProgramme(jour: myDate, async:async, completion: { prog, error in
                if (prog != nil && error == nil) {
                    // Mise à jour de la date de dernier rechargement des données
                    prog?.dateLastReloadWS = Date()
                    
                    // Programme : ajout dans le dictionnaire des programmes si n'existe pas et overwrite si existe
                    if(self.programs.index(forKey: dateProgWithoutTime) == nil){
                        self.programs[dateProgWithoutTime] = prog;
                        log.info("ADD CACHE programme à la date : \(dateProgWithoutTime)");
                    }
                    else{
                        self.programs.updateValue(prog!, forKey: dateProgWithoutTime);
                        log.info("UPDATE CACHE programme à la date : \(dateProgWithoutTime)");
                    }
                                        
                    completion(self.programs.index(forKey: dateProgWithoutTime) == nil ? nil : self.programs[dateProgWithoutTime],true);
                }
                else{
                    completion(nil,true);
                }
            })
        }
        else{
            log.info("Récupération du programme dans les données en cache");
            completion(self.programs.index(forKey: dateProgWithoutTime) == nil ? nil : self.programs[dateProgWithoutTime],true);
        }
    }
    

    /// Détermination de la nécessité de recharger un programme ou non
    /// Le programme doit être rechargé toutes les <minIntervalReload> secondes
    /// Rend vrai si le programme n'est pas null, si sa date de dernier reload date, date d'il y a moins de <minIntervalReload> secondes
    ///
    /// - Parameter program: Schedule
    /// - Returns: vrai si le programme a besoin d'être rechargé
    private func programNeedReload(program:Schedule?)->Bool{
        
        return program != nil && Date() > program!.dateLastReloadWS.addingTimeInterval(Double(minIntervalReload))
    }
}

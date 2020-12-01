//
//  AppDelegate.swift
//  SampleBFM
//
//  Created by SELMI Oussama on 06/04/2018.
//  Copyright © 2018 Next Radio TV. All rights reserved.
//

import UIKit
import XCGLogger

let log = XCGLogger.default

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var schedule : Schedule?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        log.setup(level: .info, showThreadName: true, showLevel: true, showFileNames: true, showLineNumbers: true)
        log.info("Lancement de l'application");

        /// *** Chargement synchrone pour attendre l'arrivée des datas pour lancer l'appli
        //self.getSchedule()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: Programme
    /// Chargement du programme correspondant à l'heure courrante
    // Chargement synchrone pour attendre l'arrivée des datas pour lancer l'appli
    func getSchedule() {
        let programmeManager:ProgramRequestManager = ProgramRequestManager.sharedInstance; // initialisation du singleton
        programmeManager.loadProgramAtDate(myDate: Date(),async:false, completion: {prog,success in
            if(success){
                log.debug("Chargement du programme dans App Delegate OK");
                self.schedule = prog
            }
            else{
                log.debug("Chargement du programme dans App Delegate KO");
            }
        });
    }

}


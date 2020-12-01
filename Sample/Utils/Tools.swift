//
//  Tools.swift
//  SampleBFM
//
//  Created by SELMI Oussama on 08/04/2018.
//  Copyright © 2018 Next Radio TV. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Dates/Time Methods

func setFormated(date: Date) -> String {

    let french       = DateFormatter()
    french.dateStyle = .medium 
    french.timeStyle = .short
    french.locale    = Locale(identifier: "FR-fr")
    
    return french.string(from: date as Date)
}

// MARK: - HELPER CLASS/METHODS

class AlertHelper {
    func showAlert(fromController controller: UIViewController, withTitle: String, andMessage: String) {
        let alert = UIAlertController(title: withTitle, message: andMessage, preferredStyle: .alert)
        let confirmAction = UIAlertAction(
        title: "OK", style: UIAlertActionStyle.default) { (action) in
            controller.dismiss(animated: true, completion: nil)
        }
        alert.addAction(confirmAction)
        controller.present(alert, animated: true, completion: nil)
    }
}

import SystemConfiguration

public class Reachability {
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
        
    }
}

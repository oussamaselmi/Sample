//
//  RestApiManager.swift
//  SampleBFM
//
//  Created by SELMI Oussama on 06/04/2018.
//  Copyright © 2018 Next Radio TV. All rights reserved.
//

import Foundation
import SwiftyJSON


class RestApiManager {
    
    
    init() {
        //TODO 
        
    }
    
    private func dataTask(request: NSMutableURLRequest, method: String, completion: @escaping (_ success: Bool, _ object: AnyObject?, _ error: Error?) -> ()) {
        request.httpMethod = method
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if (data != nil && error == nil) {
                
                let httpResponse: HTTPURLResponse = response as! HTTPURLResponse
                log.info(method+" "+(request.url?.absoluteString)!+": \(httpResponse.statusCode)")
                
                if let data = data {
                    let json = try? JSONSerialization.jsonObject(with: data, options: [])
                    log.verbose(json)
                    if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                        completion(true, json as AnyObject?, nil)
                    } else {
                        completion(false, json as AnyObject?, nil)
                    }
                }
            }
            else {
                log.error(error)
                completion(false, nil, error)
            }
            }.resume()
    }
    
    func synchronousDataTask(with request: NSMutableURLRequest, method: String,completion: @escaping (_ success: Bool, _ object: AnyObject?, _ error: Error?) -> ()) {
        request.httpMethod = method
        let semaphore = DispatchSemaphore(value: 0)
        
        var responseData: Data?
        var theResponse: URLResponse?
        var theError: Error?
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            
            responseData = data
            theResponse = response
            theError = error
            
            semaphore.signal()
            
            }.resume()
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        if (responseData != nil && theError == nil) {
            
            let httpResponse: HTTPURLResponse = theResponse as! HTTPURLResponse
            log.info(method+" "+(request.url?.absoluteString)!+": \(httpResponse.statusCode)")
            
            if let data = responseData {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                log.verbose(json)
                if let response = theResponse as? HTTPURLResponse, 200...299 ~= response.statusCode {
                    completion(true, json as AnyObject?, nil)
                } else {
                    completion(false, json as AnyObject?, nil)
                }
            }
        }
        else {
            log.error(theError)
            completion(false, nil, theError)
        }
    }
    
    func post(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?, _ error: Error?) -> ()) {
        dataTask(request: request, method: "POST", completion: completion)
    }
    
    func put(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?, _ error: Error?) -> ()) {
        dataTask(request: request, method: "PUT", completion: completion)
    }
    
    func get(request: NSMutableURLRequest,async:Bool, completion: @escaping (_ success: Bool, _ object: AnyObject?, _ error: Error?) -> ()) {
        if(!async){
            synchronousDataTask(with: request, method: "GET", completion: completion)
        }
        else{
            dataTask(request: request, method: "GET", completion: completion)
        }
    }
    
    func dataURLRequest(path: String, params: Dictionary<String, AnyObject>? = nil) -> NSMutableURLRequest {

        let request = NSMutableURLRequest(url: NSURL(string: path)! as URL)
        if let params = params {
            var paramString = ""
            for (key, value) in params {
                let escapedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                let escapedValue = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                paramString += "\(String(describing: escapedKey))=\(String(describing: escapedValue))&"
            }

            request.httpBody = paramString.data(using: String.Encoding.utf8)
        }
        
        return request
    }
    
    
    
}

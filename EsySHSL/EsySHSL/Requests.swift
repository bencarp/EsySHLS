//
//  Requests.swift
//  EsySHSL
//
//  Created by Peter Heynmöller on 15.10.16.
//  Copyright © 2016 p3h3. All rights reserved.
//

import Foundation

class Requests {

    func sendPostRequest(url: String, params: String){
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.httpBody = params.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                // check for http errors
                print("statusCode should be 200, but is "+String(httpStatus.statusCode))
                print("response = "+String(describing: response))
                
            }else{
                
                
                
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }
        task.resume()
        
    }
    
    func sendGetRequest(url: String){
    
        let req = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        req.httpMethod = "GET"
        req.httpBody = "key=\"value\"".data(using: String.Encoding.utf8) //This isn't for GET requests, but for POST requests so you would need to change `HTTPMethod` property
        URLSession.shared.dataTask(with: req as URLRequest) { data, response, error in
            if error != nil {
                //Your HTTP request failed.
                print(error?.localizedDescription)
            } else {
                //Your HTTP request succeeded
                print(String(data: data!, encoding: String.Encoding.utf8))
            }
            }.resume()
        
    }
    
}

//
//  APIHandler.swift
//  SampleTableView
//
//  Created by 922235 on 26/03/20.
//  Copyright © 2020 922235. All rights reserved.
//

import Foundation

class APIHandler {
    
    private init() {}
    static let shared = APIHandler()
    var modelstruct = [Modelobject]()
    var navTitle: String = ""
    
    // API handler to fetch data
    func fetchDetails(completion : @escaping () -> Void = {}) {
        
        guard let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json") else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET")
                print(error!)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                guard let rootJSON = try JSONSerialization.jsonObject(with: responseData, options: [])
                    as? [String: Any] else {
                        print("error trying to convert data to JSON")
                        return
                }
                
                guard let jsonArray = rootJSON["rows"] as? [[String: Any]] else {
                    return
                }
                self.navTitle = rootJSON["title"] as! String
                self.modelstruct = jsonArray.compactMap{return Modelobject(dict: $0)}
                
                completion()
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        task.resume()
    }
    
    // Data from Response.json stub
    func jsonData(completion : @escaping () -> Void = {}) {
        
        let url = Bundle.main.url(forResource: "Response", withExtension: "json")
        
        guard let jsonData = url else{return}
        guard let data = try? Data(contentsOf: jsonData) else { return }
        // parse the result as JSON, since that's what the API provides
        do {
            guard let rootJSON = try JSONSerialization.jsonObject(with: data, options: [])
                as? [String: Any] else {
                    print("error trying to convert data to JSON")
                    return
            }
            
            guard let jsonArray = rootJSON["rows"] as? [[String: Any]] else {
                return
            }
            self.navTitle = rootJSON["title"] as! String
            self.modelstruct = jsonArray.compactMap{return Modelobject(dict: $0)}
            
            completion()
        } catch  {
            print("error trying to convert data to JSON")
            return
        }
        
    }
}

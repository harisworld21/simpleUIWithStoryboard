//
//  ViewController.swift
//  simpleUIWithStoryboard
//
//  Created by Sunil Dutt on 30/09/17.
//  Copyright © 2017 Sunil Dutt. All rights reserved.
//

import Foundation

extension String
{
    func convertJSON(text: String) -> Any? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: [])
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func convertJSONToArray(text: String)->[Any]?
    {
        if let jsonArray = convertJSON(text: text) as? [Any]
        {
            return jsonArray
        }
        return nil
    }
    
    func convertJSONToDict(text: String)-> [String: Any]?
    {
        if let jsonDict = convertJSON(text: text) as? [String: Any]
        {
            return jsonDict
        }
        return nil
    }
    
    func jsonToString(json: AnyObject) -> String?{
        do {
            let data1 =  try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) // first of all convert json to the data
            let convertedString = String(data: data1, encoding: .utf8) // the data will be converted to the string
            return convertedString
            
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil
    }
    
    func getjsONFromFile(fileName:String) -> String
    {
        // Json file from the file system
        let path = Bundle.main.path(forResource: fileName, ofType: "json")
        do{
            let content = try! String.init(contentsOfFile: path!)
            return content
        }
    }
    
}



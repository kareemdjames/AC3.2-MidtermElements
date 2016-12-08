//
//  ElementObject.swift
//  ElementsMidterm
//
//  Created by Kareem James on 12/8/16.
//  Copyright © 2016 Kareem James. All rights reserved.
//

import Foundation

class ElementObject {
    
    let number: Int
    let weight: Double
    let name: String
    let symbol: String
    let melting: Int
    let boiling: Int
    
    init(number: Int, weight: Double, name: String, symbol: String, melting: Int, boiling: Int) {
        
        self.number = number
        self.weight = weight
        self.name = name
        self.symbol = symbol
        self.melting = melting
        self.boiling = boiling
        
    }
    
    convenience init?(from dict: [String:AnyObject]) {
        
        guard let number = dict["number"] as? Int,
            let weight = dict["weight"] as? Double,
            let name = dict["name"] as? String,
            let symbol = dict["symbol"] as? String,
            let melting = dict["melting_c"] as? Int,
            let boiling = dict["boiling_c"] as? Int else { return nil }
        
        self.init(number: number, weight: weight, name: name, symbol: symbol, melting: melting, boiling: boiling)
        
    }
    
    static func object(from data: Data) -> [ElementObject]? {
        
        var objectsToReturn: [ElementObject]? = []
        
        do {
            let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let jsonDataDictionary = jsonData as? [[String:AnyObject]] else { return nil }
            
                for elementDictionary in jsonDataDictionary {
                    if let newObject = ElementObject(from: elementDictionary) {
                        objectsToReturn?.append(newObject)
                    }
                }
            }
        
        
        catch {
            print(error)
        }
        
        return objectsToReturn
        
    }
    
}






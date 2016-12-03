//
//  Person.swift
//  TestProject
//
//  Created by Faisal Syed on 12/2/16.
//  Copyright © 2016 Faisal Syed. All rights reserved.
//

import Foundation
import UIKit

struct Person {
    
    let name: String
    
    let gender: String
    
    let location: String
    
    let imageUrl: String
    
}

extension Person {
    init?(json: [String: AnyObject]) {
        guard let name = json["name"] as? NSDictionary,
            let title = name["title"] as? String,
            let firstname = name["first"] as? String,
            let lastname = name["last"] as? String,
            let picture = json["picture"] as? NSDictionary,
            let gender = json["gender"] as? String,
            let location = json["location"] as? NSDictionary,
            let city = location["city"] as? String,
            let state = location["state"] as? String,
            let mediumImageUrlString = picture["medium"] as? String else { return nil }
        
        self.name = "\(title) \(firstname) \(lastname)"
        self.imageUrl = mediumImageUrlString
        self.gender = gender
        self.location = "\(city), \(state)"
    }
}
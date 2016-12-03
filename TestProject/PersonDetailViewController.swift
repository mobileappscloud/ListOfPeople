//
//  PersonDetailViewController.swift
//  TestProject
//
//  Created by Faisal Syed on 12/3/16.
//  Copyright © 2016 Faisal Syed. All rights reserved.
//

import UIKit

// Image cache to store images already downloaded
var imageCache = [String: UIImage]()

final class PersonDetailViewController: UIViewController {
    
    var person: Person! {
        didSet {
            
            // Handle Image Cache
            
            if let image = imageCache[person.imageUrl] {
                personImageView.image = image
            }
                
            else {
                
                NSURLSession.sharedSession().dataTaskWithURL(NSURL(string:person.imageUrl)!, completionHandler: { (data, response, error) in
                    
                    if error != nil {
                        print(error)
                        return
                    }
                    
                    let image = UIImage(data: data!)
                    
                    imageCache[self.person.imageUrl] = image
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.personImageView.image = image
                    }
                    
                }).resume()
            }
        }
    }
    
    @IBOutlet weak var personImageView: UIImageView!
    
    @IBOutlet weak var personName: UILabel!
    
    @IBOutlet weak var personGender: UILabel!
    
    @IBOutlet weak var personLocation: UILabel!
}

// MARK: - View Lifecycle 
extension PersonDetailViewController {
    
    override func viewDidLoad() {
        self.title = "Details"
        setLabels()
    }
    
    private func setLabels() {
        personName.text = person.name
        personGender.text = person.gender
        personLocation.text = person.location
    }
}
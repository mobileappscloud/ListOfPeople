//
//  PersonListTableViewController.swift
//  TestProject
//
//  Created by Faisal Syed on 12/2/16.
//  Copyright © 2016 Faisal Syed. All rights reserved.
//

import UIKit

final class PersonListTableViewController: UITableViewController {

    var people = [Person]()
        
    static let cellReuseIdentifier = "cell"
    
}

// MARK: - View Lifecycle
extension PersonListTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        // Fetch person upon load 
        fetchPerson()
    }
    
    private func fetchPerson() {
        
        let urlString = "https://randomuser.me/api/?results=20"
        let url = NSURL(string: urlString)
        let urlRequest = NSMutableURLRequest(URL: url!)
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(urlRequest) { (data, response, error) in
            
            if error != nil {
                print(error)
            }
            
            else {
                
                if let data = data {
            
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as! NSDictionary
                    let jsonDict = json["results"] as! [[String:AnyObject]]
                    for dict in jsonDict {
                        if let person = Person(json: dict) {
                            self.people.append(person)
                        }
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            self.tableView.reloadData()
                        }
                    }
                }
                    catch let err as NSError {
                        print("There was an error while parsing: \(err)")
                    }
                }
            }
        }
        task.resume()
    }
}

// MARK: - Table view Data Source
extension PersonListTableViewController {

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if people.count > 0 {
            return people.count
        }
        
        else {
            return 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(PersonListTableViewController.cellReuseIdentifier, forIndexPath: indexPath)
        
        let person = people[indexPath.row]
        cell.textLabel?.text = person.name
        return cell
    }
}

// MARK: - Navigation
extension PersonListTableViewController {

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let detailViewController = segue.destinationViewController as! PersonDetailViewController
            
            //Pass current person to detail VC
            if let indexPath = tableView.indexPathForSelectedRow {
                let selectedPerson = people[indexPath.row]
                detailViewController.person = selectedPerson
            }
        }
        
    }
}
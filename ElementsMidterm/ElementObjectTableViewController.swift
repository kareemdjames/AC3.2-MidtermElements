//
//  ElementObjectTableViewController.swift
//  ElementsMidterm
//
//  Created by Kareem James on 12/8/16.
//  Copyright © 2016 Kareem James. All rights reserved.
//

import UIKit

class ElementObjectTableViewController: UITableViewController {

    var elementObjectsArr = [ElementObject]()
    var endpoint = "https://api.fieldbook.com/v1/58488d40b3e2ba03002df662/elements"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIRequestManager.manager.getData(endPoint: endpoint) { (data: Data?) in
            if let validData = data,
                let validObjects = ElementObject.object(from: validData) {
                self.elementObjectsArr = validObjects
                DispatchQueue.main.async {
                    self.tableView?.reloadData()
                }
                
            }
        }

            }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return elementObjectsArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ElementObjectCell", for: indexPath)

        let currentObject = elementObjectsArr[indexPath.row]
        
        cell.textLabel?.text = currentObject.name
        cell.detailTextLabel?.text = "\(currentObject.symbol)(\(currentObject.number)) \(currentObject.weight)"
        
        APIRequestManager.manager.getData(endPoint: "https://s3.amazonaws.com/ac3.2-elements/\(currentObject.symbol)_200.png") { (data: Data?) in
            if let validData = data,
                let validImage = UIImage(data: validData) {
                DispatchQueue.main.async {
                    
                    cell.imageView?.image = validImage
                    cell.setNeedsLayout()
                }
            }
        }


        
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let newDetailNewController = segue.destination as? DetailViewController,
            
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell) {
            
            newDetailNewController.selectedObject = elementObjectsArr[indexPath.row]
        }

    }
}

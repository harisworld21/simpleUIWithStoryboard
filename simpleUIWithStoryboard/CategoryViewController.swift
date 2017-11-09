//
//  CategoryViewController.swift
//  simpleUIWithStoryboard
//
//  Created by HariRamya on 08/11/17.
//  Copyright © 2017 Sunil Dutt. All rights reserved.
//

import UIKit

class CategoryViewContoller: UITableViewController {
    var objects = [String]()
    
    override func viewDidLoad() {
        objects.append("Animals")
        objects.append("Fruits")
    }
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! customCell
        let object = objects[indexPath.row]
        cell.title.text = object
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "subCategorySegue"
        {
            if let indexPath = tableView.indexPathForSelectedRow
            {
                let viewC = segue.destination as! MenuViewController
                viewC.subCategoryName = objects[indexPath.row]
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}

class customCell: UITableViewCell
{
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    
}

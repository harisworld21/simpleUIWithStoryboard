//
//  CategoryViewController.swift
//  simpleUIWithStoryboard
//
//  Created by HariRamya on 08/11/17.
//  Copyright © 2017 Sunil Dutt. All rights reserved.
//

import UIKit

class CategoryViewContoller: UITableViewController {
    var objects = [TableCellContents]()
    
    
    override func viewDidLoad() {
        let category = "".getjsONFromFile(fileName: "Category")
        let arr = category.convertJSONToArray(text: category)
        for content in arr!
        {
            if let dict = content as? [String: String]
            {
                let cellContent = TableCellContents()
                cellContent.title = dict["name"]!
                if let img = UIImage(named: dict["image"]!)
                {
                    cellContent.img = img
                }
                objects.append(cellContent)
            }
        }

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
        cell.title.text = object.title
        cell.img.image = object.img
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
                let rootViewController = segue.destination as! UINavigationController
                let menuVC = rootViewController.topViewController as! MenuViewController
                menuVC.subCategoryName = objects[indexPath.row].title
                print(menuVC.subCategoryName)
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
    
    @IBAction func exitOut(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func onExit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

class customCell: UITableViewCell
{
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var img: UIImageView!
}

class TableCellContents
{
    var title = ""
    var img = UIImage()
}

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
    
    override func viewDidAppear(_ animated: Bool) {
        
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
        //cell.title.text = object.title
        cell.img.image = object.img
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var contentHeight = CGFloat(0)
        for row in (0 ..< objects.count) {
            let indexPath = NSIndexPath(row: row, section: 0)
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath)
            contentHeight += cell.frame.height
        }
        let tableHeight = tableView.frame.height
        let headerHeight = (tableHeight - contentHeight) / 2 - (contentHeight)
        return headerHeight
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
       
    }
    

 
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = UIColor.clear
        return view
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

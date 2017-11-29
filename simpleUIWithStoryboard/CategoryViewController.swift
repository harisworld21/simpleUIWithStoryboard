//
//  CategoryViewController.swift
//  simpleUIWithStoryboard
//
//  Created by HariRamya on 08/11/17.
//  Copyright © 2017 Sunil Dutt. All rights reserved.
//

import UIKit
import GoogleMobileAds

class CategoryViewContoller: UITableViewController,GADBannerViewDelegate {
    var objects = [TableCellContents]()
    var bannerView: GADBannerView!
    
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
        initAd()
        loadAd()
    }
    
    func initAd()
    {
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        addBannerViewToView(bannerView)
        bannerView.adUnitID = "ca-app-pub-6034271363001238/4534363426"
        bannerView.delegate = self
        bannerView.rootViewController = self
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
    
    func loadAd()
    {
        bannerView.load(GADRequest())
    }
    
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }
    
    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }
    
    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
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

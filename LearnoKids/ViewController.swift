//
//  ViewController.swift
//  LearnoKids
//
//  Created by HariRamya on 11/12/17.
//  Copyright © 2017 Sunil Dutt. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
        @IBOutlet weak var bannerView: UIView!
    
    override func viewDidLoad() {
        AdPreview.sharedInstance.setUpAd()
    }
    
    func initAd()
    {
        //        tableView.tableFooterView = bannerView
        AdPreview.sharedInstance.loadAd(viewC: self, banner: bannerView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initAd()
    }
}

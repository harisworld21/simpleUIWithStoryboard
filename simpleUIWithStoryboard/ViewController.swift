//
//  ViewController.swift
//  simpleUIWithStoryboard
//
//  Created by Sunil Dutt on 30/09/17.
//  Copyright © 2017 Sunil Dutt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginToCollection(_ sender: Any) {
        performSegue(withIdentifier: "collectionView", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "collectionView"
        {
            print("CollectionView")
        }
    }


}


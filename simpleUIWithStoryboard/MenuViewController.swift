//
//  MenuViewController.swift
//  simpleUIWithStoryboard
//
//  Created by HariRamya on 20/10/17.
//  Copyright © 2017 Sunil Dutt. All rights reserved.
//

import UIKit
import AVFoundation

class MenuViewController: UIViewController {
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        container.alpha = 1
        imageView.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "containerSegue"
        {
           let viewC = segue.destination as! FlowerViewController
           viewC.masterView = self
        }
    }
    
    func playSound(fileName: String) {
        let url = Bundle.main.url(forResource: fileName, withExtension: "mp3")!
        
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            player.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    @IBAction func userTappedImage(_ sender: Any) {
        if !imageView.isHidden
        {
            container.alpha = 1
            imageView.isHidden = true
        }
    }
    
    func selectedSegue(obj: objects)
    {
        imageView.isHidden = false
        container.alpha = 0.4
        imageView.image = obj.img
    }
    
}

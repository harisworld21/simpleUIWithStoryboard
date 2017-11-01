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
    @IBOutlet weak var displayView: UIView!
    
    override func viewDidLoad() {
        container.alpha = 1
        displayView.isHidden = true
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
        if !displayView.isHidden
        {
            displayView.isHidden = true
            container.alpha = 1
        }
    }
    
    @IBAction func closeClicked(_ sender: Any) {
        userTappedImage(sender)
    }
    
    func selectedSegue(obj: objects, frame:CGRect)
    {
        displayView.isHidden = false
        container.alpha = 0.4
        imageView.image = obj.img
        let oldCenter = imageView.frame
        imageView.frame = frame
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            self.imageView.frame = oldCenter
            
        }) { (success: Bool) in
            print("Done moving image")
        }
    }
    
}

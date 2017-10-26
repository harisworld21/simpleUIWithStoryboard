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
//        if !imageView.isHidden
//        {
            let newCenter = CGPoint(x: 0, y: 0)
            let newSize = CGSize(width:0, height:0)
            UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
                self.imageView.center = newCenter
                self.imageView.frame.size = newSize
            }) { (success: Bool) in
                print("Done moving image")
            }
            
            UIView.animate(withDuration: 2.0, delay: 2.0, options: .curveEaseOut, animations: {
                self.imageView.alpha = 1.0
            }, completion: {_ in
                
            })
            container.alpha = 1
            imageView.isHidden = true
//    }
        
    }
    
    func selectedSegue(obj: objects)
    {
        imageView.isHidden = false
        container.alpha = 0.4
        imageView.image = obj.img
    }
    
}

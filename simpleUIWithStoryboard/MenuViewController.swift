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
    var childView : FlowerViewController!
    
    override func viewDidLoad() {
        container.alpha = 1
        displayView.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "containerSegue"
        {
           let viewC = segue.destination as! FlowerViewController
           viewC.masterView = self
            childView = viewC
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
    
    @IBAction func pageSwiped(_ sender: Any) {
        if displayView.isHidden
        {
            return
        }
        if let swipe = sender as? UISwipeGestureRecognizer
        {
            switch swipe.direction
            {
            case UISwipeGestureRecognizerDirection.left:
            findPrevious();
            case UISwipeGestureRecognizerDirection.right:
            findNext();
            default:
                break
            }
        }
    }
    
    @IBAction func findPrevious()
    {
        if let obj = childView.object as? [objects]
        {
            let curIndex = childView.currentIndex
            let imgFrame = imageView.frame
            let frame = CGRect(x:imgFrame.size.width,y:imgFrame.origin.y,width:imgFrame.size.width,height:imgFrame.size.height)
            
            if curIndex - 1 > 0
            {
                if let prev = obj[curIndex-1] as? objects
                {
                    childView.currentIndex -= 1
                    selectedSegue(obj: prev, frame: frame)
                }
            }
            else
            {
                if let prev = obj.last as? objects
                {
                    childView.currentIndex = obj.count - 1
                    selectedSegue(obj: prev, frame: frame)
                }
            }
        }
    }
    
    @IBAction func findNext()
    {
        if let obj = childView.object as? [objects]
        {
            var curIndex = childView.currentIndex
            curIndex += 1
            let imgFrame = imageView.frame
            let frame = CGRect(x:-imgFrame.size.width,y:imgFrame.origin.y,width:imgFrame.size.width,height:imgFrame.size.height)

            if curIndex < obj.count-1
            {
                if let prev = obj[curIndex+1] as? objects
                {
                childView.currentIndex += 1
                selectedSegue(obj: prev, frame: frame)
                }
            }
            else
            {
                if let prev = obj[0] as? objects
                {
                    childView.currentIndex = 0
                    selectedSegue(obj: prev, frame: frame)
                }
            }
        }
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

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
    @IBOutlet weak var labelText: UILabel!
    var childView : FlowerViewController!
    var tmpImgView = UIImageView()
    var subCategoryName = ""
    
    override func viewDidLoad() {
        container.alpha = 1
        displayView.isHidden = true
        self.navigationItem.title = subCategoryName
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "containerSegue"
        {
           let viewC = segue.destination as? FlowerViewController
           viewC?.masterView = self
            childView = viewC
            viewC?.categoryName = subCategoryName
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
        //closeClicked(sender)
    }
    
    @IBAction func closeClicked(_ sender: Any) {
        if !displayView.isHidden
        {
            displayView.isHidden = true
            container.alpha = 1
            self.navigationController?.isNavigationBarHidden = false
        }
        
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
        if let obj = childView.object as [objects]!
        {
            let curIndex = childView.currentIndex
            let imgFrame = imageView.frame
            let start = UIScreen.main.bounds.width
            let frame = CGRect(x:start,y:imgFrame.origin.y + (imgFrame.height/2),width:0,height:0)
            let oldFrame = CGRect(x:-imgFrame.size.width,y:UIScreen.main.bounds.height/2,width:0,height:0)
            tmpImgView.image = imageView.image
            tmpImgView.frame = imageView.frame
            view.addSubview(tmpImgView)

            if curIndex - 1 >= 0
            {
                if let prev = obj[curIndex-1] as objects!
                {
                    childView.currentIndex -= 1
                    selectedSegue(obj: prev, imgFrame: frame, oldImgFrame: oldFrame)
                }
            }
            else
            {
                if let prev = obj.last as objects!
                {
                    childView.currentIndex = obj.count - 1
                    selectedSegue(obj: prev, imgFrame: frame, oldImgFrame: oldFrame)
                }
            }
        }
    }
    
    @IBAction func findNext()
    {
        if let obj = childView.object as [objects]!
        {
            var curIndex = childView.currentIndex
            curIndex += 1
            let imgFrame = imageView.frame
            let end = UIScreen.main.bounds.width
            let frame = CGRect(x:UIScreen.main.bounds.origin.x,y:imgFrame.origin.y + (imgFrame.height/2),width:0,height:0)
            let oldFrame = CGRect(x:end ,y: imgFrame.origin.y + (imgFrame.height/2) ,width:0,height:0)
            tmpImgView.image = imageView.image
            tmpImgView.frame = imageView.frame
            view.addSubview(tmpImgView)
            if curIndex < obj.count
            {
                if let prev = obj[curIndex] as objects!
                {
                childView.currentIndex += 1
                    selectedSegue(obj: prev, imgFrame: frame, oldImgFrame: oldFrame)
                }
            }
            else
            {
                if let prev = obj[0] as objects!
                {
                    childView.currentIndex = 0
                    selectedSegue(obj: prev, imgFrame: frame, oldImgFrame: oldFrame)
                }
            }
        }
    }
    
    func selectedSegue(obj: objects, imgFrame:CGRect, oldImgFrame:CGRect)
    {
        displayView.isHidden = false
        container.alpha = 0.4
        imageView.image = obj.img
        self.navigationController?.isNavigationBarHidden = true
        let color = UIColor.clear
        if let textColor = color.getColor(obj.titleColor)
        {
            self.labelText.textColor = textColor
        }
        startImageAnimation(startPos: imgFrame, endPos: imageView.frame, aspect: imageView, disappear: false)
        startImageAnimation(startPos: tmpImgView.frame, endPos: oldImgFrame, aspect: tmpImgView, disappear: true)
        startLabelAnimation(aspect: self.labelText, name: obj.name)
       
    }
    
}

extension MenuViewController
{
    func startImageAnimation(startPos: CGRect, endPos: CGRect, aspect: UIImageView, disappear:Bool) -> () {
        aspect.frame = startPos
        UIView.animate(withDuration: 0.5, animations: {
            aspect.frame = endPos
        }){ (success: Bool) in
            UIView.animate(withDuration: 0.2, animations: {
                aspect.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            })
            {(success: Bool) in
                UIView.animate(withDuration: 0.3, animations: {
                aspect.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                if disappear
                {
                    aspect.removeFromSuperview()
                }
                })
            }
        }
        
    }
    
    func startLabelAnimation(aspect: UILabel, name: String) -> () {
        
        UIView.animate(withDuration: 0.3, animations: {
            aspect.transform = CGAffineTransform.init(scaleX: 0, y: 0)
        }){ (success: Bool) in
            aspect.text = name
            UIView.animate(withDuration: 0.4, animations: {
            aspect.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
            }){(success: Bool) in
                UIView.animate(withDuration: 0.3, animations: {
                    aspect.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                })
            }
            
        }
    }
}

//
//  MenuViewController.swift
//  simpleUIWithStoryboard
//
//  Created by HariRamya on 20/10/17.
//  Copyright © 2017 Sunil Dutt. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox


class MenuViewController: UIViewController{
    
    @IBOutlet weak var soundOnOff: UIButton!
    @IBOutlet weak var autoOnOff: UIButton!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var displayView: UIView!
    @IBOutlet weak var labelText: UILabel!
    var autoTimer =  Timer()
    var childView : FlowerViewController!
    var tmpImgView = UIImageView()
    var subCategoryName = ""
    
    @IBOutlet weak var bannerView: UIView!
    override func viewDidLoad() {
        container.alpha = 1
        displayView.isHidden = true
        self.navigationItem.title = subCategoryName
        soundMuteState()
    }
    
    
    func soundMuteState()
    {
        if let state = UserDefaults.standard.value(forKey: "mute_state") as? Bool
        {
            if Bool(state)
            {
                soundOnOff.setImage(#imageLiteral(resourceName: "btn_sound_on"), for: .normal)
            }
            else
            {
                soundOnOff.setImage(#imageLiteral(resourceName: "btn_sound_off"), for: .normal)
            }
        }
        else
        {
            UserDefaults.standard.set(true, forKey: "mute_state")
        }
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
        if let state = UserDefaults.standard.value(forKey: "mute_state") as? Bool
        {
            if !state
            {
                return
            }
        }
        if let soundUrl = Bundle.main.url(forResource: fileName, withExtension: "mp3") {
            var soundId: SystemSoundID = 0
            
            AudioServicesCreateSystemSoundID(soundUrl as CFURL, &soundId)
            
            AudioServicesAddSystemSoundCompletion(soundId, nil, nil, { (soundId, clientData) -> Void in
                AudioServicesDisposeSystemSoundID(soundId)
            }, nil)
            
            AudioServicesPlaySystemSound(soundId)
        }
        /*let url = Bundle.main.url(forResource: fileName, withExtension: "mp3")!
        
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            player.play()
        } catch let error as NSError {
            print(error.description)
        }*/
    }
    
    @objc func somAction() {
        if childView.currentIndex+1 == childView.object.count
        {
            stopAutoPlay()
            return
        }
        next()
        if !autoTimer.isValid
        {
            autoTimer.fire()
        }
    }
    
    func startAutoPlay()
    {
        stopAutoPlay()
        autoOnOff.setImage(#imageLiteral(resourceName: "btn_pause"), for: .normal)
        autoTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(MenuViewController.somAction), userInfo: nil, repeats: true)
    }
    
    func stopAutoPlay()
    {
        if autoTimer.isValid
        {
            autoTimer.invalidate()
        }
        autoOnOff.setImage(#imageLiteral(resourceName: "btn_play"), for: .normal)
        autoTimer.invalidate()
    }
    
    @IBAction func autoPlay(_ sender: Any) {
        let state = autoOnOff.imageView?.image
        if state == #imageLiteral(resourceName: "btn_pause")
        {
            stopAutoPlay()
        }
        else
        {
            childView.currentIndex += 1
            next()
            startAutoPlay()
        }
    }
    
    @IBAction func soundOnOff(_ sender: Any) {
        if let state = UserDefaults.standard.value(forKey: "mute_state") as? Bool
        {
            if Bool(state)
            {
                soundOnOff.setImage(#imageLiteral(resourceName: "btn_sound_off"), for: .normal)
                UserDefaults.standard.set(false, forKey: "mute_state")
            }
            else
            {
                soundOnOff.setImage(#imageLiteral(resourceName: "btn_sound_on"), for: .normal)
                UserDefaults.standard.set(true, forKey: "mute_state")
            }
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
            stopAutoPlay()
        }
        else
        {
             self.performSegue(withIdentifier: "homeVC", sender: self)
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
                stopAutoPlay()
            previous();
            case UISwipeGestureRecognizerDirection.right:
                stopAutoPlay()
            next();
            default:
                break
            }
        }
    }
    
    func previous()
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
    
    func next()
    {
        if let obj = childView.object as [objects]!
        {
            if childView.currentIndex+1 == childView.object.count
            {
                stopAutoPlay()
            }
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
    
    @IBAction func findPrevious()
    {
        stopAutoPlay()
        previous()
    }
    
    @IBAction func findNext()
    {
        stopAutoPlay()
        next()
    }
    
    func selectedSegue(obj: objects, imgFrame:CGRect, oldImgFrame:CGRect)
    {
        displayView.isHidden = false
        container.alpha = 0
        imageView.image = obj.img
        //self.navigationController?.isNavigationBarHidden = true
        let color = UIColor.clear
        if let textColor = color.getColor(obj.titleColor)
        {
            self.labelText.textColor = textColor
        }
        startImageAnimation(startPos: imgFrame, endPos: imageView.frame, aspect: imageView, disappear: false, obj: obj)
        startImageAnimation(startPos: tmpImgView.frame, endPos: oldImgFrame, aspect: tmpImgView, disappear: true, obj: obj)
        startLabelAnimation(aspect: self.labelText, name: obj.name)
    }
    
}

extension MenuViewController
{
    func startImageAnimation(startPos: CGRect, endPos: CGRect, aspect: UIImageView, disappear:Bool, obj: objects) -> () {
        aspect.frame = startPos
        UIView.animate(withDuration: 0.5, animations: {
            aspect.frame = endPos
        }){ (success: Bool) in
            if disappear{
                self.playSound(fileName: obj.sound)}
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
            aspect.transform = CGAffineTransform.init(scaleX: 0.2, y: 0.2)
        }){ (success: Bool) in
            aspect.text = name
            UIView.animate(withDuration: 0.4, animations: {
            aspect.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
                let curId = self.childView.currentIndex
                self.navigationItem.title = "\(curId+1)/\(self.childView.object.count) - \(name)"
            }){(success: Bool) in
                UIView.animate(withDuration: 0.3, animations: {
                    aspect.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                })
            }
            
        }
    }
}

//
//  FLowerViewController.swift
//  simpleUIWithStoryboard
//
//  Created by HariRamya on 17/10/17.
//  Copyright © 2017 Sunil Dutt. All rights reserved.
//

import UIKit
import AVFoundation

class FlowerViewController : UICollectionViewController
{
    let collectionLayout = CustomImageFlowLayout()
    var object = [objects]()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.collectionViewLayout = collectionLayout
        parseJSON()
        //collectionView?.backgroundColor = .black
    }
    
    func parseJSON()
    {
       let str = getjsONFromFile(fileName: "fruits")
       let arr = convertJSONToArray(text: str)
        for dict in arr!
       {
        if let dict1 = dict as? [String:Any]
        {
            let obj = objects()
            let imageName = dict1["image"] as! String
            if let img = UIImage(named: imageName)
            {
                obj.img = img
            }
            obj.name = dict1["name"] as! String
            obj.sound = dict1["sound"] as! String
            object.append(obj)
        }
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! flowerCell
        cell.img.image = object[indexPath.row].img
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return object.count
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! flowerCell
        cell.img.image = object[indexPath.row].img
        return cell
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
    
   
    
}

class flowerCell: UICollectionViewCell
{
    @IBOutlet weak var img: UIImageView!
    
}

class objects
{
    var img = UIImage()
    var name = ""
    var sound = ""
}

extension FlowerViewController
{
    func convertJSON(text: String) -> Any? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: [])
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func convertJSONToArray(text: String)->[Any]?
    {
        if let jsonArray = convertJSON(text: text) as? [Any]
        {
            return jsonArray
        }
        return nil
    }
    
    func convertJSONToDict(text: String)-> [String: Any]?
    {
        if let jsonDict = convertJSON(text: text) as? [String: Any]
        {
            return jsonDict
        }
        return nil
    }
    
    func jsonToString(json: AnyObject) -> String?{
        do {
            let data1 =  try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) // first of all convert json to the data
            let convertedString = String(data: data1, encoding: .utf8) // the data will be converted to the string
            return convertedString
            
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil
    }
    
    func getjsONFromFile(fileName:String) -> String
    {
        // Json file from the file system
        let path = Bundle.main.path(forResource: fileName, ofType: "json")
        do{
            let content = try! String.init(contentsOfFile: path!)
            return content
        }
    }
    
}



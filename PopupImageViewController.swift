//
//  PopupImageViewController.swift
//  inPixtagram
//
//  Created by Admin on 7/18/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class PopupImageViewController: UIViewController {


    @IBOutlet weak var largeImageView: HSxUIImageView!
    @IBOutlet weak var saveButton: UIButton!
    
//    var allImagesIdArrayInSaved : [Int] = []
    
    var imageAddress = ""
    var imageSize = 400
    var imageId : Int? {
        didSet{
             imageAddress =  "https://picsum.photos/id/\(imageId!)/\(imageSize)/\(imageSize)"
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        largeImageView.downloadImageFromWeb(urlString: imageAddress, imageId: imageId!, imageSize: imageSize)
    }


    @IBAction func saveImage(_ sender: UIButton) {
        if largeImageView.image != nil && imageAddress != "" {
            var allImagesIdArrayInSaved = loadSavedImagesId()
            if searchId(id: imageId! , array: allImagesIdArrayInSaved){
                dismiss(animated: true, completion: nil)
            }else {
                 allImagesIdArrayInSaved.append(imageId!)
                let defaults = UserDefaults.standard
                defaults.set(allImagesIdArrayInSaved, forKey: "SavedImagesId")
                dismiss(animated: true, completion: nil)
            }
           
            
            
        }else{
            print("there is no picture")
        }
        
    }
    

    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func loadSavedImagesId() -> [Int]{
        let defaults = UserDefaults.standard
       let allImagesIdArrayInSaved =    defaults.array(forKey: "SavedImagesId")  as? [Int] ?? [Int]()
        
        return allImagesIdArrayInSaved
    }
    
    func searchId(id : Int , array : [Int]) -> Bool {
        var exist = false
        for _ in array {
            if array.contains(id){
                exist = true
                return exist
            }
        }
        return exist
    }
    
}

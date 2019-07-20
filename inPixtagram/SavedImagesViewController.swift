//
//  SavedImagesViewController.swift
//  inPixtagram
//
//  Created by Admin on 7/16/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import VegaScrollFlowLayout

class SavedImagesViewController: UIViewController {

    var imageArray : [UIImage] = []
    
    var allImagesIdArrayInSaved : [Int] = []
   
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         collectionView.register(UINib(nibName: "ImageCVCell", bundle: nil), forCellWithReuseIdentifier: "ImageCVCell")
        
        loadSavedImagesId()
        cvDelegates()
        setupLayout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       loadSavedImagesId()
        collectionView.reloadData()
    }
    
    func loadSavedImagesId(){
        let defaults = UserDefaults.standard
        allImagesIdArrayInSaved =    defaults.array(forKey: "SavedImagesId")  as? [Int] ?? [Int]()
    }
    
    
   
 
    
 

}


extension SavedImagesViewController {
    func cvDelegates() {
        collectionView.delegate = self
        collectionView.dataSource  = self
    }
    
}


extension SavedImagesViewController  : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allImagesIdArrayInSaved.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCVCell", for: indexPath) as! ImageCVCell
        
        cell.imageId = allImagesIdArrayInSaved[indexPath.item]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell =  collectionView.cellForItem( at: indexPath) as! ImageCVCell
        let imageId : Int = cell.imageId!
                
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let popupImageViewController = storyBoard.instantiateViewController(withIdentifier: "PopupImageViewController") as! PopupImageViewController // identifier is not name of ViewController
        
        popupImageViewController.imageId =  imageId
        present(popupImageViewController, animated: true, completion: nil)
        
    }
    
}


extension SavedImagesViewController {
    func setupLayout(){
        
        let layout = VegaScrollFlowLayout()
        collectionView.collectionViewLayout = layout
        layout.minimumLineSpacing = 20
        layout.itemSize = CGSize(width: collectionView.frame.width / 2 , height: collectionView.frame.width / 2)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
}

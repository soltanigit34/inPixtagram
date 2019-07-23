//
//  HomeViewController.swift
//  inPixtagram
//
//  Created by Admin on 7/16/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import SquareFlowLayout


class HomeViewController: UIViewController  {

    enum CellType {
        case normal
        case expanded
    }
    
    var offset = 0

    private var layoutValues: [CellType] = []
    
    var refreshControl = UIRefreshControl()

    
    @IBOutlet weak var collectionView: UICollectionView!
    var imageIdArray = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetDefaults()
        collectionView.register(UINib(nibName: "ImageCVCell", bundle: nil), forCellWithReuseIdentifier: "ImageCVCell")
   
        cvDelegates()
        initiationOfImages()
        setupLayoutValues()
        setLayout()
        refresh()
     
    }
    

}



extension HomeViewController  :  UICollectionViewDelegate , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageIdArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCVCell", for: indexPath) as! ImageCVCell
    
        cell.imageId = imageIdArray[indexPath.item]
        cell.backgroundColor  = .yellow
       

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


extension HomeViewController : SquareFlowLayoutDelegate {
    func shouldExpandItem(at indexPath: IndexPath) -> Bool {
        return self.layoutValues[indexPath.row] == .expanded
        
    }
}


extension HomeViewController {
    func setLayout(){
        let flowLayout = SquareFlowLayout()
        flowLayout.flowDelegate = self
        self.collectionView.collectionViewLayout = flowLayout
    }
    
    func cvDelegates() {
        collectionView.delegate = self
        collectionView.dataSource  = self
    }
    
    func setupLayoutValues(){
        for i in 0 + offset ..< imageIdArray.count + offset {
            if i % 8 == 0 {

                layoutValues.append(.expanded)
            }else {

                layoutValues.append(.normal)
            }
            
        }
    }
  
}


extension HomeViewController {
    
    func fetchImageAddress(){
        
        let imageId = Int.random(in: 0 ..< 899)
        imageIdArray.append(imageId)

    }
    
    func initiationOfImages(){
        for _ in 0 ..< 120 {
           fetchImageAddress()
        }
    }
    
    func fetchNewData(){
        for _ in 0 ..< 6 {
            fetchImageAddress()
            offset = offset + 1
        }
        
    }
}


extension HomeViewController {
    func refresh(){
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshData), for: UIControl.Event.valueChanged)
        collectionView.addSubview(refreshControl)
    }
    
   @objc func refreshData(){
    fetchNewData()
    updateLayout()
    reverseImageData()
    collectionView.reloadData()
    refreshControl.endRefreshing()
    }
    
    func updateLayout(){
        setupLayoutValues()
    }
    func reverseImageData(){
        imageIdArray =  Array(imageIdArray.sorted().reversed())
    }
    
    
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
}


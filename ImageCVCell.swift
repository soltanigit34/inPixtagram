//
//  ImageCVCell.swift
//  inPixtagram
//
//  Created by Admin on 7/17/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class ImageCVCell: UICollectionViewCell {

    @IBOutlet weak var imageThumb: UIImageView!

    
    
    var imageId : Int? {
        didSet{
        let imageAddress = "https://picsum.photos/id/\(imageId!)/200/200"
//            imageThumb.downloadImage(imageURL: imageAddress)
            imageThumb.downloaded(from: imageAddress)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
        
    }
    
    
    

}

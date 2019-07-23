//
//  ImageCVCell.swift
//  inPixtagram
//
//  Created by Admin on 7/17/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class ImageCVCell: UICollectionViewCell {

    @IBOutlet weak var imageThumb: HSxUIImageView!

    let imageSize = 200
    
    
    var imageId : Int? {
        didSet{
        let imageAddress = "https://picsum.photos/id/\(imageId!)/\(imageSize)/\(imageSize)"
            
            imageThumb.downloadImageFromWeb(urlString: imageAddress, imageId: imageId!, imageSize: imageSize)
           
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
        
    }
}

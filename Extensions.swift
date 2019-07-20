//
//  Extensions.swift
//  inPixtagram
//
//  Created by Admin on 7/18/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

extension UIImageView {
    
    func downloadImage(imageURL : String?){
        
        let url : URL
        if imageURL != nil {
            url = URL(string: imageURL!)!
        }else {
            
            let sample = "https://www.fnordware.com/superpng/pnggrad16rgb.png"
            url = URL(string: sample)!
        }
        
        //        let url = URL(string: imageURL!)!
        let placeholderImage = UIImage(named: "pure")!
        //        let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
        //            size: self.frame.size,
        //            radius: 40
        //        )
//        self.af_setImage(
//            withURL: url,
//            placeholderImage: placeholderImage
//            //            filter: filter
//        )
        
        self.af_setImage(withURL: url, placeholderImage: placeholderImage, filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: UIImageView.ImageTransition.noTransition, runImageTransitionIfCached: false) { (response) in
            if (response.result.error != nil)
            {
                print("image with url: \(url), get error :  \(response.result.error)")
            }
        }
        
        
    }
}


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

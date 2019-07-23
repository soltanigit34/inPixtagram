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
        
        let placeholderImage = UIImage(named: "pure")!
  
        
        self.af_setImage(withURL: url, placeholderImage: placeholderImage, filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: UIImageView.ImageTransition.noTransition, runImageTransitionIfCached: false) { (response) in
            if (response.result.error != nil)
            {
                print("image with url: \(url), get error :  \(response.result.error)")
            }
        }
        
        
    }
}


class xDownloader {
    
    static func saveImage(image: UIImage , fileName : String) -> Bool {
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return false
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return false
        }
        do {
            try data.write(to: directory.appendingPathComponent(fileName)!)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    static func getSavedImage(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
    }
    
}


extension URL {
    static var documentsDirectory: URL {
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return try! documentsDirectory.asURL()
    }
    
    static func urlInDocumentsDirectory(with filename: String) -> URL {
        return documentsDirectory.appendingPathComponent(filename)
    }
}


let imageCache = NSCache<NSString, UIImage> ()

class HSxUIImageView : UIImageView {
    
    var imageUrlString : String?
    
    func downloadImageFromWeb(urlString : String , imageId : Int , imageSize : Int){
        let fileName  = "\(imageId)_\(imageSize)"
        let url = URL(string: urlString)
        
        image = nil
        imageUrlString = urlString
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession.init(configuration: configuration)
        
        
        let task = session.dataTask(with: url!) { (data, response, error) in
           
            if error != nil {
                return
            }
            if data == nil {
                return
            }
            
            
            if let image = xDownloader.getSavedImage(named: fileName){
                DispatchQueue.main.async {
                    if self.imageUrlString == urlString {
                         self.image = image
                    }
                    return
                }
            }else{
                if let cachedImage = imageCache.object(forKey: fileName as NSString){
                    DispatchQueue.main.async {
                        if self.imageUrlString == urlString {
                              self.image = cachedImage
                        }
                      
                        return
                    }
                }else {
                    if let imageFromData = UIImage(data: data!){
                        imageCache.setObject(imageFromData, forKey: fileName as NSString)
                       let successOfSaving = xDownloader.saveImage(image: imageFromData, fileName: fileName)
                        print(successOfSaving)
                        DispatchQueue.main.async {
                            if self.imageUrlString == urlString {
                                  self.image = imageFromData
                            }
                           
                        }
                    }
                }
                
            }
        }
        
        task.resume()
    }
}

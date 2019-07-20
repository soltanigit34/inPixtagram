//
//  CustomTabBarControllerViewController.swift
//  inPixtagram
//
//  Created by Admin on 7/16/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit


class CustomTabBarControllerViewController: UITabBarController {

    var tabBarIteam = UITabBarItem()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .selected  )
             UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.darkGray], for: .normal  )
        
        let selectedImage1 = UIImage(named: "homec")?.withRenderingMode(.alwaysOriginal)
        let deSelectedImage1 = UIImage(named: "homebw")?.withRenderingMode(.alwaysOriginal)
        tabBarIteam = self.tabBar.items! [0]
        tabBarIteam.image = deSelectedImage1
        tabBarIteam.selectedImage = selectedImage1
        
        
        let selectedImage2 = UIImage(named: "likedc")?.withRenderingMode(.alwaysOriginal)
        let deSelectedImage2 = UIImage(named: "likedbw")?.withRenderingMode(.alwaysOriginal)
        tabBarIteam = self.tabBar.items! [1]
        tabBarIteam.image = deSelectedImage2
        tabBarIteam.selectedImage = selectedImage2

        let tabsCount = CGFloat((tabBar.items?.count)!)
        let tabBarSize = CGSize.init(width: tabBar.frame.width / tabsCount, height: tabBar.frame.height )
        tabBar.selectionIndicatorImage = UIImage.imageWithColor(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), size: tabBarSize)
        
        self.selectedIndex = 0
    }


}



extension UIImage {
    
    class func imageWithColor(color : UIColor , size : CGSize) -> UIImage{
         let rect = CGRect.init(x: 0, y: 0, width: size.width, height: size.height )
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
        
       
    }
    
}

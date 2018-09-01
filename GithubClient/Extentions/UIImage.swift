//
//  UIImage.swift
//  GithubClient
//
//  Created by Atsushi on 2018/09/01.
//  Copyright © 2018年 Atsushi. All rights reserved.
//

import UIKit

extension UIImage {
    convenience init?(color: UIColor, size: CGSize)
    {
        let rect = CGRect(origin: .zero, size: size)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else {
            return nil
        }
        self.init(cgImage: cgImage)
    }
}

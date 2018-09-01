//
//  ImageDownLoader.swift
//  GithubClient
//
//  Created by Atsushi on 2018/09/01.
//  Copyright © 2018年 Atsushi. All rights reserved.
//

import Foundation
import UIKit

final class ImageDownLoader {
    
    //UIImageをキャッシュするための変数
    var cacheImage: UIImage?
    
    func downloadImage(imageURL: String,
                       success: @escaping (UIImage) -> Void,
                       failure: @escaping (Error) -> Void) {
        
        //もしキャッシュされたUIImageがあればそれを返す
        if let cacheImage = cacheImage {
            success(cacheImage)
        }
        
        //リクエストを作成
        var request = URLRequest(url: URL(string: imageURL)!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request)
        {
            (data, response, error) in
            
            //ErrorがあったらErrorを返す
            if let error = error {
                DispatchQueue.main.async {
                    failure(error)
                }
                return
            }
            
            //dataがなかったら、APIError.unknown Errorを返す
            guard let data = data else {
                DispatchQueue.main.async {
                    failure(APIError.unknown)
                }
                return
            }
            
            //受け取ったデータからUIImageを生成できなければ、APIError.unknown Errorを返す
            guard let imageFromData = UIImage(data: data) else {
                DispatchQueue.main.async {
                    failure(APIError.unknown)
                }
                return
            }
            
            //imageFromDataを返す
            DispatchQueue.main.async {
                success(imageFromData)
            }
            
            //画像をキャッシュする
            self.cacheImage = imageFromData
        }
        task.resume()
    }
}

//
//  UserCellViewModel.swift
//  GithubClient
//
//  Created by Atsushi on 2018/09/01.
//  Copyright © 2018年 Atsushi. All rights reserved.
//

import Foundation

import UIKit

enum ImageDownLoadProgress {
    case loading(UIImage)
    case finish(UIImage)
    case error
}

final class UserCellViewModel {
    
    //ユーザーを変数として保持
    private var user: User
    
    //ImageDownloaderを変数として保持
    private let imageDownloader = ImageDownLoader()
    
    private var isLoading = false
    
    //Cellに反映させるアウトプット
    var nickName: String {
        return user.name
    }
    
    //Cellを選択した時に必要なwebURL
    var webURL: URL {
        return URL(string: user.webURL)!
    }
    
    //userを引数にinit
    init(user: User) {
        self.user = user
    }
    
    func downloadImage(progress :@escaping (ImageDownLoadProgress) -> Void) {
        //cellForRowで呼ばれることを想定したメソッド
        //何回もダウンロードしないためにisLoadingを使用している
        if isLoading == true {
            return
        }
        
        isLoading = true
        
        let loadingImage = UIImage(color: .gray, size: CGSize(width: 45,
                                                              height: 45))!
        
        
        progress(.loading(loadingImage))
        
        imageDownloader.downloadImage(imageURL: user.iconUri,
                                      success: { (image) in
                                        progress(.finish(image))
                                        
                                        self.isLoading = false
        }) { (error) in
            progress(.error)
            self.isLoading = false
        }
    }
}



//
//  User.swift
//  GithubClient
//
//  Created by Atsushi on 2018/09/01.
//  Copyright © 2018年 Atsushi. All rights reserved.
//

import Foundation

final class User {
    
    let id: Int
    let name: String
    let iconUri: String
    let webURL: String
    
    init(attributes: [String: Any]) {
        id = attributes["id"] as! Int
        name = attributes["name"] as! String
        iconUri = attributes["avatar_uri"] as! String
        webURL = attributes["html_url"] as! String
    }
    
}

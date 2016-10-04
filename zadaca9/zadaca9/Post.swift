//
//  Post.swift
//  zadaca9
//
//  Created by admir WIP on 04/10/16.
//  Copyright © 2016 admir WIP. All rights reserved.
//

import UIKit

class Post: NSObject {
    var userId: Int?
    var id: Int?
    var title: String?
    var body: String?
    init(userId: Int, id: Int, title: String, body: String) {
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
    }
    override init(){
        super.init()
    }
}

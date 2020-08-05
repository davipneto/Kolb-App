//
//  Photo.swift
//  Kolb Test
//
//  Created by Davi Pereira Neto on 28/07/20.
//  Copyright © 2020 ExxonMobil Global Services Company. All rights reserved.
//

import Foundation
import ObjectMapper

class Photo: Mappable {
    
    init() {
        self.albumId = 1
        self.id = 1
        self.title = "test"
        self.url = "https://via.placeholder.com/600/92c952"
        self.thumbnailUrl = "https://via.placeholder.com/150/92c952"
    }
    
    required init?(map: Map) {
        
    }
    
    var albumId: Int = -1
    var id: Int?
    var title: String?
    var url: String?
    var thumbnailUrl: String?
    
    func mapping(map: Map) {
        albumId <- map["albumId"]
        id <- map["id"]
        title <- map["title"]
        url <- map["url"]
        thumbnailUrl <- map["thumbnailUrl"]
    }
    
}

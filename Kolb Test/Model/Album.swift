//
//  Album.swift
//  Kolb Test
//
//  Created by Davi Pereira Neto on 28/07/20.
//  Copyright © 2020 ExxonMobil Global Services Company. All rights reserved.
//

import Foundation
import ObjectMapper

class Album: NSObject, Mappable {
    
    required init?(map: Map) {
        
    }
    
    var userId: Int?
    var id: Int?
    var title: String?
    var photos = [Photo]()
    
    func mapping(map: Map) {
        userId <- map["userId"]
        id <- map["id"]
        title <- map["title"]
    }
    
    override var description: String {
        return
        """
        nome do album = \(title)
        items = \(photos.count)
        """
    }
    
}

//
//  DataModel.swift
//  Kolb Test
//
//  Created by Davi Pereira Neto on 03/08/20.
//  Copyright © 2020 ExxonMobil Global Services Company. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import RxSwift
import RxCocoa

class DataModel {
    
    static var photos = BehaviorRelay<[Photo]>(value: [])
    static var albums = BehaviorRelay<[Album]>(value: [])
    
    init() {}
    
    static func getData(){
        let photosURL = APIConstants.photosEndpoint
        AF.request(photosURL).responseArray { (response: DataResponse<[Photo], AFError>) in
            guard let photos = try? response.result.get() else { return }
            let photosSorted = photos.sorted { $0.albumId < $1.albumId }
            DataModel.photos.accept(photosSorted)
            getAlbumsData()
        }
    }
    
    private static func getAlbumsData() {
        let albumsURL = APIConstants.albumsEndpoint
        AF.request(albumsURL).responseArray { (response: DataResponse<[Album], AFError>) in
            guard let albums = try? response.result.get() else { return }
            let albumsSorted = albums.sorted { $0.id! < $1.id! }
            addPhotosToAlbums(albumsSorted)
            DataModel.albums.accept(albums)
        }
    }
    
    private static func addPhotosToAlbums(_ albums: [Album]) {
        var latestPosition = 0
        for album in albums {
            let id = album.id
            let range = latestPosition..<DataModel.photos.value.count
            for (index, photo) in zip(range, DataModel.photos.value[range]) {
                if photo.albumId == id {
                    album.photos.append(photo)
                } else {
                    latestPosition = index
                    break
                }
            }
        }
    }
}

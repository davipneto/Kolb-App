//
//  AlbunsViewController.swift
//  Kolb Test
//
//  Created by Davi Pereira Neto on 28/07/20.
//  Copyright © 2020 ExxonMobil Global Services Company. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import RxSwift
import RxCocoa

class AlbunsViewController: UITableViewController {
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: "albumCell")
        self.title = "Álbuns"
        DataModel.albums
            .bind { _ in
                self.tableView.reloadData()
            }.disposed(by: disposeBag)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataModel.albums.value.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as! AlbumTableViewCell
        let index = indexPath.row
        cell.album = DataModel.albums.value[index]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let album = DataModel.albums.value[index]
        guard let albumId = album.id else { return }
        
        let photos = DataModel.photos.value
            .filter { $0.albumId == albumId }
        let photosObservable = BehaviorRelay<[Photo]>(value: photos)
        let photosViewController = PhotosViewController(photosObservable: photosObservable, title: album.title)
        
        self.navigationController?.pushViewController(photosViewController, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: false)
    }

}

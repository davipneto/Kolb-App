//
//  PhotosViewController.swift
//  Kolb Test
//
//  Created by Davi Pereira Neto on 28/07/20.
//  Copyright © 2020 ExxonMobil Global Services Company. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

private let photoReuseIdentifier = "photo"

class PhotosViewController: UICollectionViewController {
    
    var photosObservable: BehaviorRelay<[Photo]>
    var disposeBag: DisposeBag
    var imageModal: UIView?
    
    init(photosObservable: BehaviorRelay<[Photo]>, title: String?) {
        self.photosObservable = photosObservable
        self.disposeBag = DisposeBag()
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.backgroundColor = .systemBackground
        self.collectionView.contentInset.top = 8
        self.collectionView!.register(
            PhotoCollectionViewCell.self,
            forCellWithReuseIdentifier: photoReuseIdentifier
        )
        photosObservable
            .bind {
                if $0.count > 0 {
                    self.collectionView.reloadData()
                }
            }
            .disposed(by: disposeBag)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photosObservable.value.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoReuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
        
        let row = indexPath.row
        let photo = photosObservable.value[row]
        if let url = photo.url {
            cell.setImage(url: url)
        }
        
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PhotoCollectionViewCell
        let cellFrame = collectionView.convert(cell.frame, to: self.view)
        print(cellFrame)
        let imageModal = PhotoView(frame: self.view.frame, imageOriginalFrame: cellFrame)
        imageModal.image = cell.imageView.image
        self.imageModal = imageModal
        self.view.addSubview(imageModal)
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .done, target: self, action: #selector(closeModal))
        navigationItem.setLeftBarButton(backButton, animated: false)
    }
    
    @objc func closeModal() {
        navigationItem.setLeftBarButton(navigationItem.backBarButtonItem, animated: false)
        self.imageModal?.removeFromSuperview()
        self.imageModal = nil
    }

}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let space: CGFloat = 8
        let items: CGFloat = 3
        let width = (collectionView.frame.width - (items - 1) * space) / items
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}

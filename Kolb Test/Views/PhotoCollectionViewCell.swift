//
//  PhotoCollectionViewCell.swift
//  Kolb Test
//
//  Created by Davi Pereira Neto on 28/07/20.
//  Copyright © 2020 ExxonMobil Global Services Company. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class PhotoCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureViews() {
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setImage(url: String) {
        imageView.sd_setImage(with: URL(string: url))
    }
    
}

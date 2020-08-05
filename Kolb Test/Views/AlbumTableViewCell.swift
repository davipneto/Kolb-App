//
//  AlbumTableViewCell.swift
//  Kolb Test
//
//  Created by Davi Pereira Neto on 28/07/20.
//  Copyright © 2020 ExxonMobil Global Services Company. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class AlbumTableViewCell: UITableViewCell {
    
    var album: Album? {
        didSet {
            configureCell()
        }
    }
    
    let previewImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    let labelsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        return stackView
    }()
    let albumName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
    }()
    let countText: UILabel = {
        let label = UILabel()
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        accessoryType = .disclosureIndicator
        
        contentView.addSubview(previewImage)
        contentView.addSubview(labelsStack)
        
        labelsStack.addArrangedSubview(albumName)
        labelsStack.addArrangedSubview(countText)
        
        previewImage.snp.makeConstraints { (make) in
            make.top.leading.bottom.equalToSuperview().inset(8)
            make.width.equalTo(120)
        }
        
        labelsStack.snp.makeConstraints { (make) in
            make.leading.equalTo(previewImage.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview()
        }
        
    }
    
    private func configureCell() {
        guard let album = self.album else { return }
        
        countText.text = "\(album.photos.count)"
        
        if let image = album.photos.first,
            let url = image.thumbnailUrl {
            previewImage.sd_setImage(with: URL(string: url))
        }
        
        if let name = album.title {
            albumName.text = name
        }
    }

}

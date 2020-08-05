//
//  PhotoView.swift
//  Kolb Test
//
//  Created by Davi Pereira Neto on 04/08/20.
//  Copyright © 2020 ExxonMobil Global Services Company. All rights reserved.
//

import UIKit

class PhotoView: UIView {
    
    let frameDuration = 0.2
    
    var image: UIImage? {
        didSet {
            self.imageView.image = image
        }
    }
    
    var originalFrame: CGRect
    var finalFrame: CGRect!

    let imageView = UIImageView()
    
    init(frame: CGRect, imageOriginalFrame: CGRect) {
        self.originalFrame = imageOriginalFrame
        super.init(frame: frame)
        backgroundColor = .systemBackground
        backgroundColor = backgroundColor?.withAlphaComponent(0)
        imageView.frame = imageOriginalFrame
        self.finalFrame = defineImageFinalFrame()
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        UIView.animate(withDuration: frameDuration, delay: 0, options: .curveEaseOut, animations: {
            self.backgroundColor = self.backgroundColor?.withAlphaComponent(1)
            self.imageView.frame = self.finalFrame!
        }, completion: nil)
    }
    
    override func removeFromSuperview() {
        UIView.animate(withDuration: frameDuration, delay: 0, options: .curveEaseOut, animations: {
            self.backgroundColor = self.backgroundColor?.withAlphaComponent(0)
            self.imageView.frame = self.originalFrame
        }) { (_) in
            super.removeFromSuperview()
        }
    }
    
    private func defineImageFinalFrame() -> CGRect {
        let width = self.bounds.width
        let size = CGSize(width: width, height: width)
        let y = self.bounds.height / 2 - width / 2
        let origin = CGPoint(x: 0, y: y)
        return CGRect(origin: origin, size: size)
    }
    
}

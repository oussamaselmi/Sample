//
//  ImageHeaderView.swift
//  SampleBFM
//
//  Created by SELMI Oussama on 08/04/2018.
//  Copyright © 2018 Next Radio TV. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class ImageHeaderView: UIView {
    
    var imagePlaceHolder: UIImage? {
        didSet {
            if imagePlaceHolder != oldValue {
                updateImageView()
            }
        }
    }
    var imageURL : String = ""
    private var iv: UIImageView!
    private var originalSelfFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
    private var originalIvFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
    private var offsetY: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initUi()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUi()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initUi()
    }
    
    private func initUi() {
        
        self.clipsToBounds = true
        
        originalSelfFrame = self.frame
        
        if let img = imagePlaceHolder {
            
            let widthAspect = UIScreen.main.bounds.width / img.size.width
            originalIvFrame = CGRect(x: 0, y: 0, width: img.size.width * widthAspect, height: img.size.height * widthAspect)
            
        } else {
            originalIvFrame = originalSelfFrame
        }
        
        iv = UIImageView(frame: originalIvFrame)
        iv.backgroundColor = .clear
        iv.contentMode = .scaleAspectFill
        
        self.addSubview(iv)
    
        iv.center = self.center
        iv.alpha = 0
    }
    
    private func updateImageView() {
        guard let img = imagePlaceHolder else {
            return
        }
        
        let widthAspect = UIScreen.main.bounds.width / img.size.width
        
        originalIvFrame = CGRect(x: 0, y: 0, width: img.size.width * widthAspect, height: img.size.height * widthAspect)
        
        iv.frame = originalIvFrame

        iv.alpha = 0
        
        iv.sd_setImage(with: URL(string: self.imageURL) , placeholderImage: imagePlaceHolder,options: .cacheMemoryOnly, completed: { (image, error, cacheType, imageURL) in
           self.layoutSubviews()
        })
        
        iv.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: self.frame.height / 2)
                UIView.animate(withDuration: 0.3,
                       animations: {
                        self.iv.alpha = 1
        })
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.frame.origin.y = offsetY < 0 ? offsetY : 0
        self.frame.size.height = offsetY < 0 ? originalSelfFrame.height - offsetY : self.frame.size.height
        
        let scale = self.frame.size.height / originalIvFrame.size.height <= 1 ? 1 : self.frame.size.height / iv.frame.height
        
        iv.frame.size = CGSize(width: offsetY < 0 ? originalIvFrame.size.width * scale : iv.frame.size.width,
                               height: originalIvFrame.size.height)
        iv.center = CGPoint(x: self.center.x,
                            y: offsetY < 0 ? (self.frame.size.height) / 2 : ((originalSelfFrame.height - offsetY) / 2) + offsetY)

    }
    
    func scrollViewDidScroll(_ offset: CGPoint) {
        offsetY = offset.y
        layoutSubviews()
    }
}

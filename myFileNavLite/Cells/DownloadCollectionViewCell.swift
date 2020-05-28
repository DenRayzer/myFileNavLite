//
//  CollectionViewCell.swift
//  myFileNavLight
//
//  Created by Елизавета on 26.05.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import UIKit

class DownloadCell:  UICollectionViewCell {
    static var reuseId: String = "DownloadCell"
    
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 8
     layer.shadowOpacity = 0.2
               layer.shadowOffset = CGSize(width: 0, height: 2)
               layer.shadowRadius = 4
               layer.shadowColor = UIColor.black.cgColor
               layer.masksToBounds = false
    }
    override var isSelected: Bool {
           didSet {
               UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
                   self.layer.zPosition = self.isSelected ? 1 : -1
                self.transform = self.isSelected ? CGAffineTransform(scaleX: 1.01, y: 1.01) : CGAffineTransform.identity
               }, completion: nil)
           }
       }

    
}


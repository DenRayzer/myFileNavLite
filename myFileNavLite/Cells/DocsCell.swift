//
//  DocsCell.swift
//  myFileNavLight
//
//  Created by Елизавета on 27.05.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import UIKit

class DocsCell: UICollectionViewCell {
    static var reuseId: String = "DocsCell"
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 8
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.shadowColor = UIColor.black.cgColor
        layer.masksToBounds = false
        // Initialization code
    }
    
}

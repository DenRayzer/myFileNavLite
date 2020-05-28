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
    @IBOutlet weak var sizeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 8
    }
    
}

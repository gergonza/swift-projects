//
//  MyCustomCollectionViewCell.swift
//  CollectionViews
//
//  Created by Brais Moure on 25/02/2020.
//  Copyright © 2020 MoureDev. All rights reserved.
//

import UIKit

class MyCustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var myFirstLabel: UILabel!
    @IBOutlet weak var myImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColor = .lightGray
        
        myFirstLabel.font = UIFont.boldSystemFont(ofSize: 20)
        myFirstLabel.textColor = .blue
    }

}

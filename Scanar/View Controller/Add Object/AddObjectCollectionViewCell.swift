//
//  AddObjectCollectionViewCell.swift
//  Scanar
//
//  Created by Abigail Aryaputra Sudarman on 27/12/20.
//

import UIKit

class AddObjectCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet var backView: UIImageView!
    @IBOutlet var plusButton: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    static func nib() -> UINib {
        return UINib(nibName: "AddObjectCollectionViewCell", bundle: nil)
    }
}

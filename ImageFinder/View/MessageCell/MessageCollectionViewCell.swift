//
//  MessageCollectionViewCell.swift
//  ImageFinder
//
//  Created by Andrea Altea on 03/12/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import UIKit

class MessageCollectionViewCell: UICollectionViewCell {

    static let nibIdentifier = String(describing: MessageCollectionViewCell.self)
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.setupUI()
    }
    
    private func setupUI() {
        
        self.backgroundColor = .clear
        self.container.backgroundColor = .darkGray
        self.container.clipsToBounds = true
        self.container.layer.cornerRadius = 16
    }
}

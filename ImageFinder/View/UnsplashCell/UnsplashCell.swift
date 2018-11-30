//
//  UnsplashCell.swift
//  ImageFinder
//
//  Created by Andrea Altea on 30/11/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import UIKit

class UnsplashCell: UICollectionViewCell {
    
    static let nibIdentifier = String(describing: UnsplashCell.self)
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var creationDateLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.setupUI()
    }
    
    override func awakeFromNib() {
        super.prepareForReuse()
        
        self.setupUI()
    }
    
    private func setupUI() {
        
        self.contentView.backgroundColor = .white
        self.contentView.clipsToBounds = true
        self.contentView.layer.cornerRadius = 8
        
        self.imageView.backgroundColor = .deepNight
        self.imageView.clipsToBounds = true
        self.imageView.layer.cornerRadius = 4
        self.imageView.image = nil
        
        self.descriptionLabel.textColor = .deepNight
        self.descriptionLabel.text = nil
        
        self.creationDateLabel.textColor = .lightGray
        self.creationDateLabel.text = nil
    }
}

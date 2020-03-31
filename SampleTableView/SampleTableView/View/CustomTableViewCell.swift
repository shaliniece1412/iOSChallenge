//
//  CustomTableViewCell.swift
//  SampleTableView
//
//  Created by 922235 on 27/03/20.
//  Copyright © 2020 922235. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(cellImage)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(descriptionLabel)
        setConstraint()
    }

    //Initialize titleLabel
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.textAlignment = NSTextAlignment.left
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
     //Initialize descriptionLabel
    let descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textColor = UIColor.gray
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = NSTextAlignment.left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        return lbl
    }()
    
    //Initialize cellImage
    let cellImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 35
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()
    
    // Method to set cell subviews constraint
    func setConstraint() {
        let marginGuide = contentView.layoutMarginsGuide
        
        cellImage.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        cellImage.leadingAnchor.constraint(equalTo:marginGuide.leadingAnchor, constant:10).isActive = true
        cellImage.widthAnchor.constraint(equalToConstant:70).isActive = true
        cellImage.heightAnchor.constraint(equalToConstant:70).isActive = true
        
        titleLabel.centerYAnchor.constraint(equalTo:self.cellImage.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo:self.cellImage.trailingAnchor, constant:10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        
        descriptionLabel.leadingAnchor.constraint(equalTo:marginGuide.leadingAnchor, constant:10).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo:cellImage.bottomAnchor, constant:10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

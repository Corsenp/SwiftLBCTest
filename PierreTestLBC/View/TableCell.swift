//
//  TableCell.swift
//  PierreTestLBC
//
//  Created by Pierre Corsenac on 19/03/2022.
//

import Foundation
import UIKit

class TableCell : UITableViewCell {
    static let identifier = "TableViewCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let itemImage : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: 80).isActive = true
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContentView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.itemImage.image = nil
        self.titleLabel.text = nil
        self.categoryLabel.text = nil
        self.titleLabel.textColor = nil
    }
    
    public func configure(item: Item, category: String) {
        titleLabel.text = item.title
        if let urgent = item.is_urgent, let text = titleLabel.text, urgent {
            titleLabel.text = "Urgent: " + text
            titleLabel.textColor = .red
        }
        if let price = item.price {
            priceLabel.text =  String(describing: price) + "€"
        }
        
        guard let id = item.id else {
            return
        }
        if let url = item.images_url.small {
            setupImage(url: url, id: String(id), type: "small")
        }
        
        categoryLabel.text = category
        categoryLabel.textColor = UIColor(red: 0.93, green: 0.46, blue: 0.20, alpha: 1.00)
    }
    
    private func setupImage(url: String, id: String, type: String) {
        ImageFetcher.shared.fetchImage(url: url, id: id, type: type) { [weak self] image in
            DispatchQueue.main.async() { [weak self] in
                self?.itemImage.image = image
            }
        }
    }
    
    private func setupContentView() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(itemImage)
        contentView.addSubview(categoryLabel)
        
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: itemImage.trailingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: itemImage.trailingAnchor, constant: 10).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        categoryLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: itemImage.trailingAnchor, constant: 10).isActive = true
        categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        itemImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        itemImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        itemImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

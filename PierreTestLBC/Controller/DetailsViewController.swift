//
//  DetailsViewController.swift
//  PierreTestLBC
//
//  Created by Pierre Corsenac on 07/03/2022.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    
    var category = ""
    var item = Item(id: 0,
                    category_id: 0,
                    title: "",
                    description: "",
                    price: 0.00,
                    images_url: ImageUrl(small: "", thumb: ""),
                    creation_date: "",
                    is_urgent: nil,
                    siret: "")
    
    let contentView = UIView()
    let scrollView = UIScrollView()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let siretLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
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
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let itemImage : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        guard let id = item.id else {
            return
        }
        if let url = item.images_url.thumb {
            setupImage(url: url, id: String(id), type: "thumb")
        }
        
        setupScrollView()
        setupViews()
    }
    
    private func setupImage(url: String, id: String, type: String) {
        ImageFetcher.shared.fetchImage(url: url, id: id, type: type) { [weak self] image in
            DispatchQueue.main.async() { [weak self] in
                self?.itemImage.image = image
            }
        }
    }
    
    func setupScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    private func setupContentView() {
        contentView.backgroundColor = .red
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    func setupViews(){
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(itemImage)
        contentView.addSubview(dateLabel)
        contentView.addSubview(siretLabel)
        setupContentLabels()
        
        itemImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        itemImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        itemImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: itemImage.bottomAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        
        categoryLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        
        priceLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        
        siretLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        siretLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
        siretLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30).isActive = true
    }
    
    private func setupContentLabels() {
        titleLabel.text = item.title
        if let urgent = item.is_urgent, let text = titleLabel.text, urgent {
            titleLabel.text = "Urgent: " + text
            titleLabel.textColor = .red
        }
        titleLabel.font = .boldSystemFont(ofSize: 20)
        categoryLabel.text = category
        categoryLabel.textColor = UIColor(red: 0.93, green: 0.46, blue: 0.20, alpha: 1.00)
        categoryLabel.font = .boldSystemFont(ofSize: 20)
        descriptionLabel.text = item.description
        setupDateLabelFormat()
        dateLabel.textColor = .gray
        
        if let siret = item.siret {
            siretLabel.text = "Siret: " + siret
        }
        
        siretLabel.textColor = .gray
        siretLabel.font = .italicSystemFont(ofSize: 15)
        
        if let price = item.price {
            priceLabel.text =  String(describing: price) + "€"
        } else {
            priceLabel.text = "No Price Yet"
        }
        
        
        priceLabel.font = .boldSystemFont(ofSize: 20)
    }
    
    private func setupDateLabelFormat() {
        guard let creation_date = item.creation_date else {
            return
        }
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MM-dd-yyyy HH:mm"
        
        if let date = dateFormatterGet.date(from: creation_date) {
            let formattedDate = dateFormatterPrint.string(from: date)
            dateLabel.text = formattedDate
        } else {
            print("There was an error decoding the string")
            return
        }
    }
}

//
//  ViewController.swift
//  PierreTestLBC
//
//  Created by Pierre Corsenac on 07/03/2022.
//

import UIKit

class MainViewController: UIViewController {

    private let apiCaller = Service()
    private var data = [Item]()
    private var categories = [Category]()
    private let url = "https://raw.githubusercontent.com/leboncoin/paperclip/master/"
    
    private let itemTableView: UITableView = {
        let itemTableView = UITableView(frame: .zero, style: .grouped)
        itemTableView.register(TableCell.self, forCellReuseIdentifier: TableCell.identifier)
        
        return itemTableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(itemTableView)
        
        itemTableView.dataSource = self
        itemTableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        itemTableView.frame = view.bounds
        let listingUrl = url + "listing.json"
        let categoryUrl = url + "categories.json"
        apiCaller.loadItems(url: listingUrl) { [weak self] result in
            switch result {
            case .success(let resultData):
                print("SUCCESSFULL CALL")
                self?.data = resultData
                self?.filterTable()
                DispatchQueue.main.async {
                    self?.itemTableView.reloadData()
                }
            case .failure(.urlError):
                print("URL ERROR")
            case .failure(.cacheError):
                print("Cache Error")
            case .failure(.decodeError):
                print("Json Decode Error")
            }
        }
        
        apiCaller.loadCategories(url: categoryUrl) { [weak self] result in
            switch result {
            case .success(let resultData):
                print("SUCCESSFULL CALL")
                self?.categories = resultData
                self?.filterTable()
                DispatchQueue.main.async {
                    self?.itemTableView.reloadData()
                }
            case .failure(.urlError):
                print("URL ERROR")
            case .failure(.cacheError):
                print("Cache Error")
            case .failure(.decodeError):
                print("Json Decode Error")
            }
        }
    }
    
    private func filterTable() {
        
        data.sort {
            guard let creationDate0 = $0.creation_date, let creationDate1 = $1.creation_date else { return false }
            return creationDate0 > creationDate1
        }
        
        data.sort {
            guard let isUrgent0 = $0.is_urgent, let isUrgent1 = $1.is_urgent else { return false }
            return isUrgent0 && !isUrgent1
        }
        DispatchQueue.main.async {
            self.itemTableView.reloadData()
        }
    }
    
}

extension MainViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.identifier, for: indexPath) as? TableCell else { return UITableViewCell() }
        
        var category = ""
        if let category_id = data[indexPath.row].category_id {
            category = categories[category_id - 1].name
        }
        cell.configure(item: data[indexPath.row], category: category)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsViewController = DetailsViewController()
        
        if let category_id = data[indexPath.row].category_id {
            detailsViewController.category = categories[category_id - 1].name
        }
        
        detailsViewController.item = data[indexPath.row]
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

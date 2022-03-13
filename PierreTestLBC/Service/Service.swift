//
//  Service.swift
//  PierreTestLBC
//
//  Created by Pierre Corsenac on 13/03/2022.
//

import Foundation

class Service {
    func fetchItemData(url: String, completion: @escaping ([Item]) -> Void) {
        var json : [Item] = []
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                json = try JSONDecoder().decode([Item].self, from: data)
                completion(json)
            } catch {
                print(error.self)
                print("failed to JSON DECODE \(error.localizedDescription)")
            }
        })
        task.resume()
    }
    
    func fetchCategoryData(url: String, completion: @escaping ([Category]) -> Void) {
        var categories : [Category] = []
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                categories = try JSONDecoder().decode([Category].self, from: data)
                completion(categories)
            } catch {
                print(error.self)
                print("failed to JSON DECODE \(error.localizedDescription)")
            }
        })
        task.resume()
    }
}

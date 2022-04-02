//
//  Service.swift
//  PierreTestLBC
//
//  Created by Pierre Corsenac on 13/03/2022.
//

import Foundation

enum ErrorNetwork: Error {
    case cacheError
    case urlError
    case decodeError
}

class Service {
    func fetchData<T: Decodable>(url: String, completion: @escaping ((Result<[T], ErrorNetwork>) -> Void)) {
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
    
            do {
                let json = try JSONDecoder().decode([T].self, from: data)
                completion(.success(json))
            } catch {
                print(error.self)
                print("failed to JSON DECODE \(error.localizedDescription)")
            }
        })
        task.resume()
    }
    
    public func loadItems(url: String, completion: @escaping ((Result<[Item], ErrorNetwork>) -> Void)) {
        fetchData(url: url, completion: completion)
    }
    
    public func loadCategories(url: String, completion: @escaping ((Result<[Category], ErrorNetwork>) -> Void)) {
        fetchData(url: url, completion: completion)
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

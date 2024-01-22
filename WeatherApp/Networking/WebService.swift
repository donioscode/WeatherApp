//
//  WebService.swift
//  WeatherApp
//
//  Created by doniyor normuxammedov on 23/01/24.
//

import Foundation


struct Resourse<T> {
    let url: URL
    let prase: (Data) -> T?
}

final class WebService {
    func load<T>(resourse:Resourse<T>,completion: @escaping (T?) ->()) {
        URLSession.shared.dataTask(with: resourse.url) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    completion(resourse.prase(data))
                }
            }else{
                completion(nil)
            }
        }.resume()
    }
}

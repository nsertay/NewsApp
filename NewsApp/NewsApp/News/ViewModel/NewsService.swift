//
//  NewsService.swift
//  NewsApp
//
//  Created by Nurmukhanbet Sertay on 06.05.2024.
//

import Foundation

enum ErrorFetch: Error {
    case invalidURL
    case noData
    case decodingError
}

class NewsService {
    
    func fetchNewsArticles(completion: @escaping (Result<[Article], ErrorFetch>) -> Void) {
        let urlString = "https://newsapi.org/v2/everything?q=a&apiKey=e660bcae5b9c4ca6868bf62e01a1e655"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let responseData = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let newsResponse = try decoder.decode(NewsResponse.self, from: responseData)
                completion(.success(newsResponse.articles ?? []))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
}

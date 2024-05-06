//
//  NewsLocalService.swift
//  NewsApp
//
//  Created by Nurmukhanbet Sertay on 06.05.2024.
//

import Foundation

class NewsLocalService {
    private let userDefaults = UserDefaults.standard
    private let newsDataKey = "NewsData"
    
    var newsArray: [Article] {
        get {
            guard let newsDataArrayData = userDefaults.data(forKey: newsDataKey),
                  let newsDataArray = try? JSONDecoder().decode([Article].self, from: newsDataArrayData) else {
                return []
            }
            return newsDataArray
        }
        set {
            do {
                let encodedData = try JSONEncoder().encode(newValue)
                userDefaults.set(encodedData, forKey: newsDataKey)
            } catch {
                print("Error encoding NewsResponse array: \(error)")
            }
        }
    }
    
    func addNewsData(_ newsData: Article) {
        newsArray.append(newsData)
    }
    
    func removeNewsData(_ newsData: Article) {
        if let index = newsArray.firstIndex(where: { $0 == newsData }) {
            newsArray.remove(at: index)
        }
    }
    
    func isArticleStoredLocally(_ article: Article) -> Bool {
        return newsArray.contains(article)
    }
}

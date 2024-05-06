//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Nurmukhanbet Sertay on 06.05.2024.
//

import Foundation

class NewsViewModel {
    
    static let shared = NewsViewModel()
    
    private let newsService: NewsService
    private let localNewsService: NewsLocalService
    
    init(newsService: NewsService = NewsService(), localNewService: NewsLocalService = NewsLocalService()) {
        self.newsService = newsService
        self.localNewsService = localNewService
    }
    
    func fetchNews(completion: @escaping (Result<[Article], ErrorFetch>) -> Void) {
        newsService.fetchNewsArticles(completion: completion)
    }
    
    func getLocalNews() -> [Article] {
        return localNewsService.newsArray
    }
    
    func isSavedLocal(article: Article) -> Bool {
        localNewsService.isArticleStoredLocally(article)
    }
    
    func saveLocal(article: Article) {
        localNewsService.addNewsData(article)
    }
    
    func removeLocal(article: Article) {
        localNewsService.removeNewsData(article)
    }
}

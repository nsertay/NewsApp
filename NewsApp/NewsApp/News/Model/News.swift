//
//  News.swift
//  NewsApp
//
//  Created by Nurmukhanbet Sertay on 06.05.2024.
//

import Foundation

struct NewsResponse: Codable, Equatable {
    let articles: [Article]?
}

struct Article: Codable, Equatable {
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let content: String?
}


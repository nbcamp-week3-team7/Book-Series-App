//
//  BookDataStruck.swift
//  juhyung
//
//  Created by 윤주형 on 3/28/25.
//
import Foundation

struct BookResponse: Codable {
    let data: [attributes]
}

struct attributes: Codable {
    let attributes: Book
}

struct Book: Codable {
    
    let title: String
    let author: String
    let pages: Int
    let releaseDate: String
    let dedication: String
    let summary: String
    let wiki: String
    let chapters: [Chapter]
    
    enum CodingKeys: String, CodingKey {
        case title, author, pages
        case releaseDate = "release_date"
        case dedication, summary, wiki, chapters
        
    }
}

struct Chapter: Codable {
    
    let title: String
    
}

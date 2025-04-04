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
    let released: String
    let dedication: String
    let summary: String
    let wiki: String
    let chapters: [Chapter]
    
    enum CodingKeys: String, CodingKey {
        case title, author, pages
        case released = "release_date"
        case dedication, summary, wiki, chapters
        
    }
}

struct Chapter: Codable {
    
    let title: String
    
}

extension Book {
    
    
    var formattedTitle: String {
        title.codingKey.stringValue.capitalized
        
    }
    
    var formattedAuthor: String {
        return author.codingKey.stringValue.capitalized
    }
    
    var formattedReleased: String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateFromStr = dateFormatter.date(from: released)!
        
        dateFormatter.dateStyle = .long
        let dateResult = dateFormatter.string(from: dateFromStr)
        print(#fileID, #function, #line, "dateResult 출력 = \(dateResult)")
        return dateResult
    }
}

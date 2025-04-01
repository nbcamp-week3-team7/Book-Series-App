//
// 25.03.31.(월) 구조체 파일 분리
// ===== LV 1. data.json 연결 =====

import Foundation

// ==== Book 모델 정의를 위한 구조체 생성 =====
struct Book: Decodable {
    let title: String
    let author: String
    let pages: Int
    let release_date: String
    let dedication: String
    let summary: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case author
        case pages
        case release_date = "release_date" // JSON 키 매핑
        case dedication
        case summary
    }
}

// ===== JSON 디코딩을 위한 모델 =====
struct BookResponse: Decodable {
    let data: [BookData]
}

struct BookData: Decodable {
    let attributes: Book
}

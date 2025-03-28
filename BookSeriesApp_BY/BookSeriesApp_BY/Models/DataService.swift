//
//  25.03.28.(금)
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
}

// ===== JSON 디코딩을 위한 모델 =====
struct BookResponse: Decodable {
    let data: [BookData]
}

struct BookData: Decodable {
    let attributes: Book
}

class DataService {
    
    enum DataError: Error {
        case fileNotFound
        case parsingFailed
    }
    
    func loadBooks(completion: @escaping (Result<[Book], Error>) -> Void) {
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            completion(.failure(DataError.fileNotFound))
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let bookResponse = try JSONDecoder().decode(BookResponse.self, from: data)
            let books = bookResponse.data.map { $0.attributes }
            completion(.success(books))
        } catch {
            print("🚨 JSON 파싱 에러 : \(error)")
            completion(.failure(DataError.parsingFailed))
        }
    }
}

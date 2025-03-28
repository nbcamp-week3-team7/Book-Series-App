//
//  25.03.28.(금) 작성
//  ===== LV 1. 책 제목을 표시하는 라벨 설정 =====

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let bookTitleLable = UILabel()
    let bookNumberLabel = UILabel()
    private let dataService = DataService()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        loadBooks()
    }

    // ===== LV 1. JSON 내용 가져오는 함수로 내용 출력 =====
    func loadBooks() {
        dataService.loadBooks { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let books):
                // ----- 첫 번째 책 가져오기 -----
                if let firstBook = books.first {
                    self.bookTitleLable.text = firstBook.title
                    self.bookNumberLabel.text = "1" // 첫 번째 책이니까 "1"로 설정
                }
            case .failure(let error):
                // -----에러 처리 -----
                print("🚨 데이터 로드 실패: \(error)")
            }
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        [bookTitleLable, bookNumberLabel].forEach { view.addSubview($0) }
        
        // ===== LV 1. 책 제목 표시 =====
        bookTitleLable.textColor = .black
        bookTitleLable.font = UIFont.boldSystemFont(ofSize: 24)
        bookTitleLable.textAlignment = .center
        bookTitleLable.numberOfLines = 0 // 줄바꿈설정: 수 제한 없음(0)
        bookTitleLable.lineBreakMode = .byWordWrapping // 단어 단위로 줄바꿈
        
        bookTitleLable.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(10)
        }
        
        // ===== LV 2. 책 시리즈 넘버 원형 표시 =====
        bookNumberLabel.text = "1"
        bookNumberLabel.textAlignment = .center
        bookNumberLabel.backgroundColor = .systemBlue
        bookNumberLabel.textColor = .white
        bookNumberLabel.font = UIFont.systemFont(ofSize: 16)
        bookNumberLabel.clipsToBounds = true
        bookNumberLabel.layer.cornerRadius = 20
        
        bookNumberLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(180)
            $0.trailing.equalToSuperview().inset(180)
            $0.top.equalTo(bookTitleLable.snp.bottom).offset(16)
            $0.width.equalTo(40)
            $0.height.equalTo(40)
        }
    }
    
}

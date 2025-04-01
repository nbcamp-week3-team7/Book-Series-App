//
//  25.03.28.(금) 작성
//  ===== LV 1. 책 제목을 표시하는 라벨 설정 =====

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var bookTitleLabel = UILabel()
    let bookNumberLabel = UILabel()
    
    private let dataService = DataService()
    
    // ===== 전달받을 책 데이터 =====
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        loadBooks()
        addBookDetailViewController()
    }
    
    // ===== LV 1. JSON 내용 가져오는 함수로 내용 출력 =====
    func loadBooks() {
        dataService.loadBooks { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let books):
                if let firstBook = books.first {
                    self.book = firstBook
                    self.bookTitleLabel.text = firstBook.title
                    self.addBookDetailViewController() // 데이터 로드 후 호출
                } else {
                    self.bookTitleLabel.text = "No books available"
                }
            case .failure(let error):
                self.showErrorAlert(message: error.localizedDescription)
            }
        }
    }
    
    // ===== LV 2. Alert 창 띄우기 =====
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        [bookTitleLabel, bookNumberLabel].forEach { view.addSubview($0) }
        
        // ===== LV 1. 책 제목 표시 =====
        bookTitleLabel.textColor = .black
        bookTitleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        bookTitleLabel.textAlignment = .center
        bookTitleLabel.numberOfLines = 0 // 줄바꿈설정: 수 제한 없음(0)
        bookTitleLabel.lineBreakMode = .byWordWrapping // 단어 단위로 줄바꿈
        
        bookTitleLabel.snp.makeConstraints {
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
            $0.top.equalTo(bookTitleLabel.snp.bottom).offset(16)
            $0.width.equalTo(40)
            $0.height.equalTo(40)
        }
    }
    
    // ===== LV 2~4 BookDetailViewController 연결 =====
    private func addBookDetailViewController() {
        let detailVC = BookDetailViewController()
        detailVC.book = self.book // 데이터 전달
        
        print("Book Data: \(detailVC.book?.title ?? "No data")") // 데이터 확인

        addChild(detailVC)
        view.addSubview(detailVC.view)

        detailVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            detailVC.view.topAnchor.constraint(equalTo: bookNumberLabel.bottomAnchor)
        ])

        detailVC.didMove(toParent: self)
    }
}

import UIKit
import SnapKit


class ViewController: UIViewController {
    
    var bookTitleLabel = UILabel()
    let bookNumberLabel = UILabel()
    let numberLabel = UILabel()
    
    private let dataService = DataService()
    
    let detailVC = BookDetailViewController()
    var book: Book? // 전달받을 책 데이터
    
    let stackView = UIStackView() // 전역 스택뷰 선언
    var numberButtons: [UIButton] = [] // 버튼 배열 선언
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        loadBooks()
        addBookDetailViewController()
        
        // 초기 상태에서 1번 버튼 활성화
        if let firstButton = numberButtons.first {
            updateButtonStates(selectedButton: firstButton)
        }
    }
    
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
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        [bookTitleLabel, stackView].forEach { view.addSubview($0) }
        NumberLabel()
        
        bookTitleLabel.textColor = .black
        bookTitleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        bookTitleLabel.textAlignment = .center
        bookTitleLabel.numberOfLines = 0
        bookTitleLabel.lineBreakMode = .byWordWrapping
        
        bookTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(10)
        }
    }
    
    private func NumberLabel() {
        let totalNumbers = 7
        let labelSize: CGFloat = 40
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        stackView.alignment = .center
        
        for number in 1...totalNumbers {
            let button = UIButton()
            button.setTitle("\(number)", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 16)
            button.backgroundColor = UIColor.systemGray5
            button.setTitleColor(.systemBlue, for: .normal)
            button.layer.cornerRadius = labelSize / 2
            button.clipsToBounds = true
            
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            
            button.snp.makeConstraints {
                $0.width.height.equalTo(labelSize)
            }
            
            stackView.addArrangedSubview(button)
            numberButtons.append(button)
        }
        
        stackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalToSuperview().offset(-40)
            $0.top.equalTo(bookTitleLabel.snp.bottom).offset(16)
            $0.height.equalTo(labelSize)
        }
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        updateButtonStates(selectedButton: sender)
        
        // 선택된 버튼 번호에 따라 데이터 업데이트
        if let buttonTitle = sender.title(for: .normal), let selectedNumber = Int(buttonTitle) {
            updateBookData(for: selectedNumber)
        }
    }
    
    private func updateButtonStates(selectedButton: UIButton) {
        for button in numberButtons {
            if button == selectedButton {
                button.backgroundColor = .systemBlue
                button.setTitleColor(.white, for: .normal)
            } else {
                button.backgroundColor = UIColor.systemGray5
                button.setTitleColor(.systemBlue, for: .normal)
            }
        }
    }
    
    private func updateBookData(for number: Int) {
        dataService.loadBooks { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let books):
                // 선택된 번호에 해당하는 책 데이터 가져오기
                if number > 0 && number <= books.count {
                    let selectedBook = books[number - 1]
                    self.book = selectedBook
                    self.bookTitleLabel.text = selectedBook.title
                    
                    // BookDetailViewController 업데이트
                    self.detailVC.updateBookDetails(with: selectedBook)
                } else {
                    self.bookTitleLabel.text = "No book found for this number"
                }
            case .failure(let error):
                self.showErrorAlert(message: error.localizedDescription)
            }
        }
    }
    
    private func addBookDetailViewController() {
        detailVC.book = self.book
        
        addChild(detailVC)
        view.addSubview(detailVC.view)
        
        detailVC.view.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview()
            $0.top.equalTo(stackView.snp.bottom).offset(16)
        }
        
        detailVC.didMove(toParent: self)
    }
}

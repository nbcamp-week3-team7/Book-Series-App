import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var bookTitleLabel = UILabel()
    let bookNumberLabel = UILabel()
    let numberLabel = UILabel()
    
    private let dataService = DataService()
    
    // ===== 전달받을 책 데이터 =====
    var book: Book?
    
    // ===== 전역 스택뷰 선언 =====
    let stackView = UIStackView()
    
    // ===== 버튼 배열 선언 =====
    var numberButtons: [UIButton] = []
    
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
        
        [bookTitleLabel, stackView].forEach { view.addSubview($0) }
        NumberLabel()
        
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
    }
    
    // ===== LV 2. 숫자 라벨을 스택뷰로 표시 =====
    private func NumberLabel() {
        let totalNumbers = 7 // 라벨 개수
        let labelSize: CGFloat = 40 // 라벨 크기
        
        // 스택뷰 설정
        stackView.axis = .horizontal // 가로 방향
        stackView.distribution = .equalSpacing // 라벨 간격 동일하게 설정
        stackView.spacing = 5 // 라벨 간격 설정
        stackView.alignment = .center // 라벨을 수직 가운데 정렬
        
        // 버튼 생성 및 스택뷰에 추가
        for number in 1...totalNumbers {
            let button = UIButton()
            button.setTitle("\(number)", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 16)
            button.backgroundColor = UIColor.systemGray5 // 초기 배경색
            button.setTitleColor(.systemBlue, for: .normal) // 초기 텍스트 색상
            button.layer.cornerRadius = labelSize / 2 // 원형 버튼
            button.clipsToBounds = true
            
            // 클릭 이벤트 추가
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            
            // 크기 설정
            button.snp.makeConstraints { make in
                make.width.height.equalTo(labelSize)
            }
            
            stackView.addArrangedSubview(button) // 스택뷰에 버튼 추가
            numberButtons.append(button) // 버튼 배열에 추가
        }
        
        // 스택뷰 제약 조건 설정
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
            make.top.equalTo(bookTitleLabel.snp.bottom).offset(16)
            make.height.equalTo(labelSize)
        }
    }
    
    // ===== 버튼 클릭 이벤트 =====
    @objc private func buttonTapped(_ sender: UIButton) {
        updateButtonStates(selectedButton: sender)
    }
    
    // ===== 버튼 상태 업데이트 함수 =====
    private func updateButtonStates(selectedButton: UIButton) {
        for button in numberButtons {
            if button == selectedButton {
                // 선택된 버튼
                button.backgroundColor = .systemBlue
                button.setTitleColor(.white, for: .normal)
            } else {
                // 비활성화된 버튼
                button.backgroundColor = UIColor.systemGray5
                button.setTitleColor(.systemBlue, for: .normal)
            }
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
        
        // SnapKit을 사용한 제약 조건 설정
        detailVC.view.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
            make.top.equalTo(stackView.snp.bottom).offset(20) // 스택뷰 아래에 배치
        }

        detailVC.didMove(toParent: self)
    }
}

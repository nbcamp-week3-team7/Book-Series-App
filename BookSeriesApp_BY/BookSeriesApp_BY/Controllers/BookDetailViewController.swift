import UIKit
import SnapKit

class BookDetailViewController: UIViewController {
    
    // ===== 전달받을 책 데이터 =====
    var book: Book?
    
    // ===== LV2. UI 요소들 선언 =====
    let stackView = UIStackView()
    let horizontalStackView = UIStackView()
    let verticalLabelsStackView = UIStackView()
    var coverImageView = UIImageView()
    let titleLabel = UILabel()
    let authorTitleLabel = UILabel()
    let authorLabel = UILabel()
    let releaseTitleLabel = UILabel()
    let releaseDateLabel = UILabel()
    let pagesTitleLabel = UILabel()
    let pagesLabel = UILabel()
    
    // ===== LV3. UI 요소들 선언 =====
    let dedicationTitleLabel = UILabel()
    var dedicationLabel = UILabel()
    let summaryTitleLabel = UILabel()
    var summaryLabel = UILabel()
    
    // ===== LV4. UI 요소들 선언 =====
    let scrollView = UIScrollView()
    var chaptersTitleLabel = UILabel()
    var previousLabel: UILabel? = nil
    
    // ===== LV5. UI 요소들 선언 =====
    let summaryToggleButton = UIButton(type: .system)
    let maxLength = 450
    var isExpanded = UserDefaults.standard.bool(forKey: "isExpanded") // 토글 저장된 상태 가져오기
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        configureData()
        setupActions() // 버튼 동작 추가
    }
    
    func didSelectBook(_ book: Book) {
            self.book = book
            configureData() // UI 업데이트
        }
    
    // ===== 타이틀 라벨 설정 함수 =====
    func configureTitleLabel(_ label: UILabel, fontSize: CGFloat, textColor: UIColor, text: String) {
        label.font = .boldSystemFont(ofSize: fontSize) // Bold 폰트 사용
        label.textColor = textColor
        label.text = text
    }
    
    // ===== 밸류 라벨 설정 함수 =====
    func configureValueLabel(_ label: UILabel, fontSize: CGFloat, textColor: UIColor) {
        label.font = .systemFont(ofSize: fontSize) // Regular 폰트 사용
        label.textColor = textColor
    }
    
    func setupUI() {
        // ===== 기본 설정 =====
        view.backgroundColor = .white
        
        // ===== 스크롤뷰 추가 =====
        scrollView.showsVerticalScrollIndicator = false // 세로 스크롤 바 숨기기
        scrollView.showsHorizontalScrollIndicator = false // 가로 스크롤 바 숨기기
        view.addSubview(scrollView)
        
        // ===== 스크롤뷰 안에 스택뷰 추가 =====
        scrollView.addSubview(stackView)
        
        titleLabel.textColor = .black
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        
        // ===== 타이틀 라벨들 설정 =====
        configureTitleLabel(authorTitleLabel, fontSize: 16, textColor: .black, text: "Author")
        configureTitleLabel(releaseTitleLabel, fontSize: 14, textColor: .black, text: "Released")
        configureTitleLabel(pagesTitleLabel, fontSize: 14, textColor: .black, text: "Pages")
        configureTitleLabel(dedicationTitleLabel, fontSize: 18, textColor: .black, text: "Dedication")
        configureTitleLabel(summaryTitleLabel, fontSize: 18, textColor: .black, text: "Summary")
        configureTitleLabel(chaptersTitleLabel, fontSize: 18, textColor: .black, text: "Chapters")
        
        // ===== 밸류 라벨들 설정 =====
        configureValueLabel(authorLabel, fontSize: 18, textColor: .darkGray)
        configureValueLabel(releaseDateLabel, fontSize: 14, textColor: .gray)
        configureValueLabel(pagesLabel, fontSize: 14, textColor: .gray)
        configureValueLabel(dedicationLabel, fontSize: 14, textColor: .darkGray)
        configureValueLabel(summaryLabel, fontSize: 16, textColor: .darkGray)
        
        // ===== 밸류 라벨 추가 설정 =====
        authorLabel.font = .boldSystemFont(ofSize: 18)
        dedicationLabel.numberOfLines = 0
        dedicationLabel.lineBreakMode = .byWordWrapping
        summaryLabel.numberOfLines = 0
        summaryLabel.lineBreakMode = .byWordWrapping
        
        // ===== StackView 기본 속성 설정 =====
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        
        coverImageView.contentMode = .scaleAspectFit
        coverImageView.clipsToBounds = true
        
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 8
        horizontalStackView.alignment = .top
        
        verticalLabelsStackView.axis = .vertical
        verticalLabelsStackView.spacing = 8
        verticalLabelsStackView.alignment = .leading
        
        // ===== 세로 스택뷰에 요소 추가 =====
        verticalLabelsStackView.addArrangedSubview(titleLabel)
        verticalLabelsStackView.addArrangedSubview(createRowStackView(titleLabel: authorTitleLabel, valueLabel: authorLabel))
        verticalLabelsStackView.addArrangedSubview(createRowStackView(titleLabel: releaseTitleLabel, valueLabel: releaseDateLabel))
        verticalLabelsStackView.addArrangedSubview(createRowStackView(titleLabel: pagesTitleLabel, valueLabel: pagesLabel))
        
        horizontalStackView.addArrangedSubview(coverImageView)
        horizontalStackView.addArrangedSubview(verticalLabelsStackView)
        
        [horizontalStackView, dedicationTitleLabel, dedicationLabel, summaryTitleLabel, summaryLabel, chaptersTitleLabel].forEach { stackView.addArrangedSubview($0) }
        
        // ===== LV 4. 목차 라벨 추가 =====
        if let book = book {
            for chapter in book.chapters {
                let chapterLabel = UILabel() // 새로운 UILabel 인스턴스를 생성
                chapterLabel.text = chapter.title
                chapterLabel.font = .systemFont(ofSize: 14)
                chapterLabel.textColor = .darkGray
                chapterLabel.numberOfLines = 0
                chapterLabel.lineBreakMode = .byWordWrapping
                
                // 스택뷰에 라벨 추가
                stackView.addArrangedSubview(chapterLabel)
            }
        }
        
        // ===== LV 5. 토글 버튼 초기화 =====
        summaryToggleButton.setTitle("더보기", for: .normal)
        scrollView.addSubview(summaryToggleButton) // 버튼을 스크롤뷰에 직접 추가
    }
    
    // ===== 가로 스택뷰 생성 함수 =====
    func createRowStackView(titleLabel: UILabel, valueLabel: UILabel) -> UIStackView {
        let rowStackView = UIStackView()
        rowStackView.axis = .horizontal
        rowStackView.alignment = .center
        
        rowStackView.addArrangedSubview(titleLabel)
        rowStackView.addArrangedSubview(valueLabel)
        titleLabel.snp.makeConstraints {
            $0.trailing.equalTo(valueLabel.snp.leading).offset(-10)
        }
        return rowStackView
    }
    
    func setupLayout() {
        // ===== 이미지뷰 크기 설정 =====
        coverImageView.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(150)
        }
        
        // ===== 레이아웃 설정 =====
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide) // 스크롤뷰가 화면 전체를 덮도록 설정
            $0.top.equalToSuperview().offset(20)
        }
        
        stackView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide) // 스크롤뷰 콘텐츠 크기에 맞게 설정
            $0.width.equalTo(scrollView.frameLayoutGuide) // 가로 크기를 스크롤뷰에 맞춤
        }
        
        summaryToggleButton.snp.makeConstraints {
            $0.width.equalTo(70)
            $0.height.equalTo(30)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(5) // 오른쪽 벽과 붙게 설정
            $0.top.equalTo(summaryLabel.snp.bottom).offset(8) // Summary 라벨 아래에 배치
        }
        
        // ===== 타이틀 라벨 3개 간격 설정 =====
        stackView.setCustomSpacing(24, after: dedicationLabel)
        stackView.setCustomSpacing(24, after: horizontalStackView)
        stackView.setCustomSpacing(60, after: summaryLabel)
    }
    
    func configureData() {
        guard let book = book else { return }
        
        coverImageView.image = UIImage(named: "harrypotter1") ?? UIImage(named: "defaultImage")
        titleLabel.text = book.title
        authorLabel.text = book.author
        releaseDateLabel.text = formatDate(book.release_date)
        pagesLabel.text = "\(book.pages)"
        
        dedicationLabel.text = book.dedication
        summaryLabel.text = book.summary
        
        let summaryLength = book.summary
        if summaryLength.count > maxLength {
            summaryLabel.text = isExpanded ? summaryLength : String(summaryLength.prefix(maxLength)) + "..."
            summaryToggleButton.isHidden = false
            summaryToggleButton.setTitle(isExpanded ? "접기" : "더보기", for: .normal)
        } else {
            summaryLabel.text = summaryLength
            summaryToggleButton.isHidden = true
        }
    }
    
    func setupActions() {
        summaryToggleButton.addTarget(self, action: #selector(toggleSummary), for: .touchUpInside)
    }
    
    @objc func toggleSummary() {
        isExpanded.toggle() // 상태 변경
        UserDefaults.standard.set(isExpanded, forKey: "isExpanded") // 상태 저장
        
        guard let book = book else { return }
        let summaryLength = book.summary
        summaryLabel.text = isExpanded ? summaryLength : String(summaryLength.prefix(maxLength)) + "..."
        summaryToggleButton.setTitle(isExpanded ? "접기" : "더보기", for: .normal)
    }
    
    func formatDate(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" // 문자열 형식에 맞게 설정
        guard let date = formatter.date(from: dateString) else {
            return "Unknown Date" // 변환 실패 시 기본값 반환
        }
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    func updateBookDetails(with newBook: Book) {
            self.book = newBook
            
            // Label 업데이트
            titleLabel.text = newBook.title
            authorLabel.text = newBook.author
            releaseDateLabel.text = formatDate(newBook.release_date)
            pagesLabel.text = "\(newBook.pages)"
            dedicationLabel.text = newBook.dedication
            summaryLabel.text = newBook.summary
        
        // 이미지 업데이트: 타이틀로 배열에서 이미지 이름 매칭
        let imageNames: [String: String] = [
            "Harry Potter and the Philosopher's Stone": "harrypotter1",
            "Harry Potter and the Chamber of Secrets": "harrypotter2",
            "Harry Potter and the Prisoner of Azkaban": "harrypotter3",
            "Harry Potter and the Goblet of Firen": "harrypotter4",
            "Harry Potter and the Order of the Phoenix": "harrypotter5",
            "Harry Potter and the Half-Blood Prince": "harrypotter6",
            "Harry Potter and the Deathly Hallows": "harrypotter7"
        ]
        
        if let imageName = imageNames[newBook.title] {
            coverImageView.image = UIImage(named: imageName)
        } else {
            coverImageView.image = UIImage(named: "defaultImage") // 기본 이미지 설정
        }
        
        // Summary 텍스트 길이에 따라 토글 버튼 설정
            let summaryLength = newBook.summary
            if summaryLength.count > maxLength {
                summaryLabel.text = isExpanded ? summaryLength : String(summaryLength.prefix(maxLength)) + "..."
                summaryToggleButton.isHidden = false
                summaryToggleButton.setTitle(isExpanded ? "접기" : "더보기", for: .normal)
            } else {
                summaryLabel.text = summaryLength
                summaryToggleButton.isHidden = true
            }
            
            // 기존 목차 제거
            for subview in stackView.arrangedSubviews {
                if subview is UILabel && subview != titleLabel && subview != authorLabel && subview != dedicationLabel && subview != summaryLabel && subview != dedicationTitleLabel && subview != summaryTitleLabel && subview != chaptersTitleLabel {
                    subview.removeFromSuperview()
                }
            }
            
            // 목차 제목 추가
            if !stackView.arrangedSubviews.contains(chaptersTitleLabel) {
                stackView.addArrangedSubview(chaptersTitleLabel)
            }
            
            // 새로운 목차 추가
            for chapter in newBook.chapters {
                let chapterLabel = UILabel()
                chapterLabel.text = chapter.title
                chapterLabel.font = .systemFont(ofSize: 14)
                chapterLabel.textColor = .darkGray
                chapterLabel.numberOfLines = 0
                chapterLabel.lineBreakMode = .byWordWrapping
                
                stackView.addArrangedSubview(chapterLabel)
            }
            
            // 타이틀들 추가 (중복 방지)
            if !stackView.arrangedSubviews.contains(dedicationTitleLabel) {
                stackView.insertArrangedSubview(dedicationTitleLabel, at: stackView.arrangedSubviews.firstIndex(of: dedicationLabel) ?? 0)
            }
            
            if !stackView.arrangedSubviews.contains(summaryTitleLabel) {
                stackView.insertArrangedSubview(summaryTitleLabel, at: stackView.arrangedSubviews.firstIndex(of: summaryLabel) ?? 0)
            }
        }
}

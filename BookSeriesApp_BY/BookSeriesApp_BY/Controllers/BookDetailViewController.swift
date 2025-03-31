//
// 25.03.31.(월) 로직 구현
// ===== LV 2. UIStackView 구현 =====

import UIKit
import SnapKit

class BookDetailViewController: UIViewController {
    
    // ===== 전달받을 책 데이터 =====
    var book: Book?
    
    // ===== UI 요소들 선언 =====
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        configureData()
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
        // ===== 기본 타이틀 라벨 설정 =====
        titleLabel.textColor = .black
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        
        // ===== 타이틀 라벨들 설정 =====
        configureTitleLabel(authorTitleLabel, fontSize: 16, textColor: .black, text: "Author")
        configureTitleLabel(releaseTitleLabel, fontSize: 14, textColor: .black, text: "Released")
        configureTitleLabel(pagesTitleLabel, fontSize: 14, textColor: .black, text: "Pages")
            
        // ===== 밸류 라벨들 설정 =====
        configureValueLabel(authorLabel, fontSize: 18, textColor: .darkGray)
        authorLabel.font = .boldSystemFont(ofSize: 18)
        configureValueLabel(releaseDateLabel, fontSize: 14, textColor: .gray)
        configureValueLabel(pagesLabel, fontSize: 14, textColor: .gray)
        
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
        
        // ===== 각 책 정보를 가로 스택뷰로 묶기 =====
        let authorRow = createRowStackView(titleLabel: authorTitleLabel, valueLabel: authorLabel)
        let releaseRow = createRowStackView(titleLabel: releaseTitleLabel, valueLabel: releaseDateLabel)
        let pagesRow = createRowStackView(titleLabel: pagesTitleLabel, valueLabel: pagesLabel)
        
        // ===== 세로 스택뷰에 요소 추가 =====
        verticalLabelsStackView.addArrangedSubview(titleLabel)
        verticalLabelsStackView.addArrangedSubview(authorRow)
        verticalLabelsStackView.addArrangedSubview(releaseRow)
        verticalLabelsStackView.addArrangedSubview(pagesRow)
        
        // ===== 가로 스택뷰에 이미지와 세로 라벨 추가 =====
        horizontalStackView.addArrangedSubview(coverImageView)
        horizontalStackView.addArrangedSubview(verticalLabelsStackView)
        
        // ===== 최종 스택뷰에 가로 스택뷰 추가 =====
        stackView.addArrangedSubview(horizontalStackView)
        
        view.addSubview(stackView) // ===== 최종 스택뷰 화면에 추가 =====
    }
    
    // ===== 가로 스택뷰 생성 함수 =====
    func createRowStackView(titleLabel: UILabel, valueLabel: UILabel) -> UIStackView {
        let rowStackView = UIStackView()
        rowStackView.axis = .horizontal
        rowStackView.alignment = .center

        rowStackView.addArrangedSubview(titleLabel)
        rowStackView.addArrangedSubview(valueLabel)
        titleLabel.snp.makeConstraints {
            $0.trailing.equalTo(valueLabel.snp.leading).offset(-10) // ===== 간격 설정 =====
        }
        return rowStackView
    }

    func setupLayout() {
        // ===== 최종 스택뷰 레이아웃 설정 =====
        stackView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(5)
        }
        
        // ===== 이미지뷰 크기 설정 =====
        coverImageView.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(150)
        }
        
        // ===== 가로 스택뷰 위치 설정 =====
        horizontalStackView.snp.makeConstraints {
            $0.leading.equalTo(stackView.snp.leading).inset(10)
        }
    }

    func configureData() {
        // ===== 전달받은 데이터로 UI 구성 =====
        guard let book = book else { return }
        
        coverImageView.image = UIImage(named: "harrypotter1") ?? UIImage(named: "defaultImage")
        titleLabel.text = book.title
        authorLabel.text = book.author
        releaseDateLabel.text = formatDate(book.release_date)
        pagesLabel.text = "\(book.pages)"
    }

    func formatDate(_ date: String) -> String {
        // ===== 날짜 포맷 변환 함수 =====
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateStyle = .long
        
        if let date = inputFormatter.date(from: date) {
            return outputFormatter.string(from: date)
        }
        return date
    }
}

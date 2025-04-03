//
//  ViewController.swift
//  juhyung
//
//  Created by 윤주형 on 3/27/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        loadBooks()
        
    }
    
    private let dataService = DataService()
    private var books: [Book] = []
    
    let containerView = UIView()
    let titleLabel = UILabel()
    let seriesSelectButton = UIButton()
//    let seriesOrderView = UIView()
//    let seriesNumber = UILabel()
    let inventoryView = UIView()
    
    let bookCoverImageView = UIImageView()
    let bookCoverImage = UIImage()
    
    let bookInfoArea = UIStackView()
    let bookInfoHorizontalStackView = UIStackView()
    let bookInfoTitle = UILabel()
    let bookInfoAuthor = UILabel()
    let bookInfoRealsed = UILabel()
    let bookInfoPages = UILabel()
    
    let dedicationStackView = UIStackView()
    var dedicationTitleLabel = UILabel()
    let dedicationBodyLabel = UILabel()
    
    let summaryStackView = UIStackView()
    let summaryTitleLabel = UILabel()
    let summaryBodyLabel = UILabel()
    
    let scrollView = UIScrollView()
    let contentView = UIStackView()
    
    let chapterStackView = UIStackView()
    let chapterTitleLabel = UILabel()
    let chapterDetailLabel = UILabel()
    
    let extraTextClickButton = UIButton(type: .system)
    private var isExpanded = false {
        didSet {
            UserDefaults.standard.set(isExpanded, forKey: "isExpanded")
        }
    }
    
    func loadBooks() {
        dataService.loadBooks { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let books):
                    self.books = books
                    self.setupSeriresInfomation(at: 0)
                    
                case .failure(let error):
                    print("\(error)")
                }
            }
        }
    }
    
    //지나고 보니 이렇게 할 이유가없었음;;
    private func setupSeriresInfomation(at number: Int) {
        let book = books[number]
        //        self.bookCoverImage = UIImage(named: "harrypotter\(number)")
        
        titleLabel.text = book.title
        
        bookInfoTitle.text = book.title
        seriesSelectButton.setTitle("\(number)", for: .normal)
        //key 를 String이 아닌 key 값을 적용하는것 실패 + 8공백 주기 실패
        bookInfoAuthor.attributedText = setupBookInfo(key: "author        ", value: book.author, keySize: (16, .regular), valueSize: 18, keyColor: .black, valueColor: .darkGray)
        bookInfoRealsed.attributedText = setupBookInfo(key: "released        ", value: book.formattedReleased, keySize: (14, .regular) , valueSize: 14, keyColor: .black, valueColor: .gray)
        // String보다는 Any를 채택해도 좋아보임
        bookInfoPages.attributedText = setupBookInfo(key: "pages        ", value: String(book.pages), keySize: (14, .regular), valueSize: 14, keyColor: .black, valueColor: .gray)
        bookCoverImageView.image = UIImage(named: "harrypotter\(number + 1)")
        dedicationTitleLabel.text = "Dedication"
        dedicationBodyLabel.text = book.dedication
        summaryTitleLabel.text = "Summary"
        summaryBodyLabel.text = book.summary + book.summary
        chapterTitleLabel.text = "Chapters"
        chapterDetailLabel.setupChapterText(from: book.chapters)
        loadState()
        updateSummary()
        
    }
    
    private func setupBookInfo(key: String, value: String, keySize: (CGFloat, UIFont.Weight), valueSize: CGFloat, keyColor: UIColor, valueColor: UIColor) -> NSAttributedString {
        
        let keyFontSize = keySize.0
        let keyWeight = keySize.1
        
        let titleFont = UIFont.systemFont(ofSize: keyFontSize, weight: .bold)
        
        let valueFontWeight: UIFont.Weight = (keyWeight == .bold) ? .bold : .regular
        let valueFont = UIFont.systemFont(ofSize: keyFontSize, weight: valueFontWeight)
        
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: titleFont,
            .foregroundColor: keyColor
        ]
        
        //여기서는 value값을 조절하고 싶어
        let valueAttributes: [NSAttributedString.Key: Any] = [
            .font: valueFont,
            .foregroundColor: valueColor
        ]
        
        let titleString = NSAttributedString(string: "\(key.capitalized)", attributes: titleAttributes)
        print(#fileID, #function, #line, "\(key)")
        let valueString = NSAttributedString(string: value, attributes: valueAttributes)
        
        let result = NSMutableAttributedString()
        result.append(titleString)
        result.append(valueString)
        
        return result
    }
    
    
    
    
    
    //이렇게 만들까 했는데 이것보다 그냥 구조자체를 만드는게 맞겠다.
    //    private func figureFontProperties(label: UILabel, weight: UIFont.Weight , size: CGFloat, color: UIColor) {
    //
    //    }
    
    //추후에 한번 나누긴해야됨
    private func configureUI() {
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.numberOfLines = 2
        
        
        seriesOrderView.backgroundColor = .systemBlue
        seriesOrderView.clipsToBounds = true
        
        seriesNumber.textAlignment = .center
        seriesNumber.font = .systemFont(ofSize: 16)
        seriesNumber.textColor = .black
        seriesNumber.text = "1"
        
        bookCoverImageView.contentMode = .scaleAspectFit
        
        bookInfoHorizontalStackView.axis = .horizontal
        bookInfoHorizontalStackView.spacing = 10
        bookInfoHorizontalStackView.alignment = .top
        
        bookInfoArea.axis = .vertical
        bookInfoArea.alignment = .leading
        bookInfoArea.spacing = 5
        
        bookInfoTitle.numberOfLines = 0
        bookInfoTitle.font = .systemFont(ofSize: 20, weight: .bold)
        //        bookInfoTitle.font = .systemFont(ofSize: 20, weight: .bold)
        //        bookInfoTitle.textColor = .black
        //
        //        bookInfoAuthor.font = .systemFont(ofSize: 16, weight: .bold)
        //        bookInfoAuthor.textColor = .black
        
        dedicationStackView.spacing = 8
        dedicationStackView.axis = .vertical
        dedicationBodyLabel.numberOfLines = 0
        dedicationTitleLabel.fontStyle(fontSize: 18, weight: .bold, color: .black)
        dedicationBodyLabel.fontStyle(fontSize: 14, weight: .regular, color: .gray)
        
        summaryStackView.spacing = 8
        summaryStackView.axis = .vertical
        summaryBodyLabel.numberOfLines = 0
        summaryTitleLabel.fontStyle(fontSize: 18, weight: .bold, color: .black)
        summaryBodyLabel.fontStyle(fontSize: 14, weight: .regular, color: .darkGray)
        
        scrollView.showsVerticalScrollIndicator = false
        contentView.axis = .vertical
        contentView.spacing = 8
        
        chapterStackView.axis = .vertical
        chapterStackView.spacing = 8
        
        chapterTitleLabel.fontStyle(fontSize: 18, weight: .bold, color: .black)
        chapterDetailLabel.fontStyle(fontSize: 14, weight: .regular, color: .darkGray)
        chapterDetailLabel.numberOfLines = 0
        
        extraTextClickButton.configuration = .plain()
        extraTextClickButton.titleLabel?.fontStyle(fontSize: 14, weight: .regular, color: .blue)
        extraTextClickButton.layer.cornerRadius = 4
        extraTextClickButton.clipsToBounds = true
        extraTextClickButton.setTitle("더보기", for: .normal)
        extraTextClickButton.setTitle("접기", for: .selected)
        
        
        
        
        
        //        bookInfoArea.backgroundColor = .red
        //        bookCoverImageView.backgroundColor = .blue
        //        bookInfoHorizontalStackView.backgroundColor = .yellow
        inventoryView.backgroundColor = .yellow
        scrollView.backgroundColor = .red
        contentView.backgroundColor = .brown
        dedicationStackView.backgroundColor = .green
        chapterStackView.backgroundColor = .cyan
        extraTextClickButton.backgroundColor = .magenta
        
        
        view.addSubview(containerView)
        containerView.addSubview(inventoryView)
        containerView.addSubview(scrollView)
        
        
        scrollView.addSubview(contentView)
        
        
        extraTextClickButton.addTarget(self, action: #selector(toggleSummary), for: .touchDown)
        extraTextClickButton.contentHorizontalAlignment = .right
        
        
        
        
        [bookInfoHorizontalStackView, dedicationStackView, summaryStackView, chapterStackView]
            .forEach { contentView.addSubview( $0 )}
        
        [titleLabel, seriesSelectButton]
            .forEach { inventoryView.addSubview( $0 )}
        
        
        seriesOrderView.addSubview(seriesNumber)
        
        [bookCoverImageView, bookInfoArea]
            .forEach { bookInfoHorizontalStackView.addArrangedSubview( $0 )}
        
        
        [bookInfoTitle, bookInfoAuthor, bookInfoRealsed, bookInfoPages]
            .forEach { bookInfoArea.addArrangedSubview( $0 )}
        
        [dedicationTitleLabel, dedicationBodyLabel]
            .forEach { dedicationStackView.addArrangedSubview( $0 )}
        
        [summaryTitleLabel, summaryBodyLabel, extraTextClickButton]
            .forEach{ summaryStackView.addArrangedSubview( $0 )}
        
        [chapterTitleLabel, chapterDetailLabel]
            .forEach{ chapterStackView.addArrangedSubview( $0 )}
        
        
        
        containerView.snp.makeConstraints{
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        inventoryView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.leading.trailing.equalToSuperview()
        }
        
        
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(inventoryView.snp.top).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        seriesOrderView.snp.makeConstraints{
            $0.width.equalTo(40)
            $0.height.equalTo(40)
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.greaterThanOrEqualToSuperview().offset(20)
            $0.trailing.lessThanOrEqualToSuperview().offset(-20)
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        seriesNumber.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        
        
        bookCoverImageView.snp.makeConstraints{
            $0.width.equalTo(100)
            $0.height.equalTo(bookCoverImageView.snp.width).multipliedBy(1.5)
        }
        
        
        bookInfoHorizontalStackView.snp.makeConstraints{
            $0.top.equalTo(contentView).offset(20)
            $0.leading.equalTo(contentView).offset(5)
            $0.trailing.equalTo(contentView).offset(-5)
            
        }
        
        bookInfoArea.snp.makeConstraints{
            $0.top.equalToSuperview().offset(0)
        }
        
        dedicationStackView.snp.makeConstraints{
            $0.top.equalTo(bookInfoHorizontalStackView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            
        }
        
        summaryStackView.snp.makeConstraints{
            $0.top.equalTo(dedicationStackView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            //            $0.bottom.equalToSuperview().offset(-20)
        }
        
        scrollView.snp.makeConstraints {
            //            $0.height.equalTo(200)
            $0.top.equalTo(inventoryView.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
            
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView)
        }
        
        chapterStackView.snp.makeConstraints{
            $0.top.equalTo(summaryStackView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        seriesOrderView.layer.cornerRadius = seriesOrderView.bounds.height / 2
        
    }
    
    private func updateSummary() {
        guard let text = summaryBodyLabel.text else { return }

            if text.count > 450 {
                summaryBodyLabel.numberOfLines = isExpanded ? 0 : 5
                extraTextClickButton.isHidden = false
                extraTextClickButton.setTitle(isExpanded ? "접기" : "더보기", for: .normal)
            } else {
                extraTextClickButton.isHidden = true
            }
        
    }
    
    private func loadState() {
            isExpanded = UserDefaults.standard.bool(forKey: "isExpanded")
        }
    
    @objc private func toggleSummary() {
        isExpanded.toggle()
        updateSummary()
    }
}

extension UILabel {
    func fontStyle(fontSize: CGFloat, weight: UIFont.Weight, color: UIColor) {
        self.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        self.textColor = color
    }
    
    func setupChapterText(from chapters: [Chapter]) {
        let chapterArray = chapters
            .map { "\($0.title)" }
            .joined(separator: "\n")
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        
        let attributedStringLineSpacingOnly = NSAttributedString(
            string: chapterArray,
            attributes: [
                .paragraphStyle: paragraphStyle,
            ]
        )
        
        //            self.numberOfLines = 0
        self.attributedText = attributedStringLineSpacingOnly
    }
}




//
//  ViewController.swift
//  HarryPotterSeriesApp
//
//  Created by shinyoungkim on 3/28/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    private let dataService = DataService()
    var books = Array<Book>()
    
    let mainTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    let buttonStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 8
        sv.distribution = .equalSpacing
        return sv
    }()
    
    let scrollView = UIScrollView()
    
    let contentStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 24
        return sv
    }()
    
    let bookInfoStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 8
        sv.alignment = .top
        return sv
    }()
    
    let bookImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let bookDetailStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 8
        sv.alignment = .leading
        sv.distribution = .fill
        return sv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    let authorInfoStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 8
        return sv
    }()
    
    let authorTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let authorValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .darkGray
        return label
    }()
    
    let publishDateInfoStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 8
        return sv
    }()
    
    let publishDateTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    let publishDateValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    let pageCountInfoStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 8
        return sv
    }()
    
    let pageCountTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    let pageCountValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    let dedicationStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 8
        return sv
    }()
    
    let dedicationTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    let dedicationContentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    let summaryStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 8
        return sv
    }()
    
    let summaryTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    let summaryContentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    let chapterStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 8
        return sv
    }()
    
    let readMoreToggleButton: UIButton = {
        let button = UIButton()
        button.setTitle("더 보기", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.contentHorizontalAlignment = .right
        return button
    }()
    
    let chapterTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private var isExpanded: Bool = false
    
    private var selectedBook: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        isExpanded = UserDefaults.standard.bool(forKey: "isExpanded")
        
        loadBooks()
        selectedBook = books[0]
        configureUI()
    }
    
    func loadBooks() {
        dataService.loadBooks { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let books):
                self.books = books
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configureUI() {
        updateBookDetailView()
        setupbookInfoStackView()
        updateLabelWithReadMore()
        
        [mainTitleLabel, buttonStackView, scrollView]
            .forEach { view.addSubview($0) }
        
        addSeriesButtons()
        
        scrollView.addSubview(contentStackView)
        
        [bookInfoStackView, dedicationStackView, summaryStackView, chapterStackView]
            .forEach { contentStackView.addArrangedSubview($0) }
        
        mainTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(mainTitleLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(buttonStackView.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        contentStackView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        bookInfoStackView.snp.makeConstraints {
            $0.top.equalTo(contentStackView.snp.top)
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
        }
        
        bookImageView.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(bookImageView.snp.width).multipliedBy(1.5)
        }
        
        dedicationStackView.snp.makeConstraints {
            $0.top.equalTo(bookInfoStackView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
        }
        
        summaryStackView.snp.makeConstraints {
            $0.top.equalTo(dedicationStackView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
        }
        
        chapterStackView.snp.makeConstraints {
            $0.top.equalTo(summaryStackView.snp.bottom).offset(24)
        }
    }
    
    func setupbookInfoStackView() {
        [authorTitleLabel, authorValueLabel]
            .forEach { authorInfoStackView.addArrangedSubview($0) }
        
        [publishDateTitleLabel, publishDateValueLabel]
            .forEach { publishDateInfoStackView.addArrangedSubview($0) }
        
        [pageCountTitleLabel, pageCountValueLabel]
            .forEach { pageCountInfoStackView.addArrangedSubview($0) }
        
        [titleLabel, authorInfoStackView, publishDateInfoStackView, pageCountInfoStackView]
            .forEach { bookDetailStackView.addArrangedSubview($0) }
        
        [bookImageView, bookDetailStackView]
            .forEach { bookInfoStackView.addArrangedSubview($0) }
        
        [dedicationTitleLabel, dedicationContentLabel]
            .forEach { dedicationStackView.addArrangedSubview($0) }
        
        [summaryTitleLabel, summaryContentLabel]
            .forEach { summaryStackView.addArrangedSubview($0) }
    }
    
    func addChapters(_ selectedBook: Book) {
        chapterStackView.addArrangedSubview(chapterTitleLabel)
        
        var chapterLabels = Array<UILabel>()
        
        selectedBook.chapters.forEach {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14)
            label.textColor = .gray
            label.numberOfLines = 0
            label.text = $0.title
            
            chapterLabels.append(label)
        }
        
        chapterLabels.forEach {
            chapterStackView.addArrangedSubview($0)
        }
    }
    
    func updateLabelWithReadMore() {
        guard let count = summaryContentLabel.text?.count else { return }
        if count >= 450 {
            readMoreToggleButton.addTarget(self, action: #selector(toggleSummaryText), for: .touchUpInside)
            summaryStackView.addArrangedSubview(readMoreToggleButton)
            
            if isExpanded {
                summaryContentLabel.numberOfLines = 0
                readMoreToggleButton.setTitle("접기", for: .normal)
            } else {
                summaryContentLabel.numberOfLines = 7
                summaryContentLabel.lineBreakMode = .byTruncatingTail
                readMoreToggleButton.setTitle("더 보기", for: .normal)
            }
        }
    }
    
    @objc func toggleSummaryText() {
        isExpanded.toggle()
        
        if isExpanded {
            summaryContentLabel.numberOfLines = 0
            readMoreToggleButton.setTitle("접기", for: .normal)
        } else {
            summaryContentLabel.numberOfLines = 7
            readMoreToggleButton.setTitle("더 보기", for: .normal)
        }
        
        UserDefaults.standard.set(isExpanded, forKey: "isExpanded")
    }
    
    func addSeriesButtons() {
        for i in 0..<books.count {
            let button = UIButton()
            button.setTitle("\(i + 1)", for: .normal)
            button.contentHorizontalAlignment = .center
            button.titleLabel?.font = .systemFont(ofSize: 16)
            button.setTitleColor(.systemBlue, for: .normal)
            button.backgroundColor = .systemGray5
            button.layer.cornerRadius = 20
            button.clipsToBounds = true
            button.addTarget(self, action: #selector(seriesButtonTapped), for: .touchUpInside)
            button.snp.makeConstraints {
                $0.width.height.equalTo(40)
            }
            
            buttonStackView.addArrangedSubview(button)
        }
    }
    
    @objc func seriesButtonTapped(_ sender: UIButton) {
        guard let title = sender.title(for: .normal) else { return }
        selectedBook = books[Int(title)! - 1]
        updateBookDetailView()
    }
    
    func updateBookDetailView() {
        guard let unwrappedSelectedBook = selectedBook else { return }
        
        mainTitleLabel.text = unwrappedSelectedBook.title
        bookImageView.image = #imageLiteral(resourceName: "harrypotter1")
        titleLabel.text = unwrappedSelectedBook.title
        authorTitleLabel.text = "Author"
        authorValueLabel.text = unwrappedSelectedBook.author
        publishDateTitleLabel.text = "Released"
        publishDateValueLabel.text = unwrappedSelectedBook.releaseDate
        pageCountTitleLabel.text = "Pages"
        pageCountValueLabel.text = "\(unwrappedSelectedBook.pages)"
        dedicationTitleLabel.text = "Dedication"
        dedicationContentLabel.text = unwrappedSelectedBook.dedication
        summaryTitleLabel.text = "Summary"
        summaryContentLabel.text = unwrappedSelectedBook.summary
        chapterTitleLabel.text = "Chapters"
        
        chapterStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        addChapters(unwrappedSelectedBook)
    }
}


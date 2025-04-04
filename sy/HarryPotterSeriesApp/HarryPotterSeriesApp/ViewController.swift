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
    private var books = Array<Book>()
    
    private let summaryView = SummaryView()
    
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
        sv.alignment = .center
        sv.distribution = .equalCentering
        return sv
    }()
    
    let scrollView = UIScrollView()
    
    let contentStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 24
        sv.distribution = .fill
        sv.alignment = .fill
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
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    
    
    let chapterStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 8
        return sv
    }()
    
    let chapterTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    
    
    private var selectedBook: Book?
    
    private var prevTitleNum: Int?
    
    private var selectedSeriesNum = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        prevTitleNum = 1
        
        loadBooks()
        selectedBook = books[0]
        configureUI()
        
        summaryView.delegate = self
    }
    
    func loadBooks() {
        dataService.loadBooks { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let books):
                self.books = books
            case .failure(let error):
                print(error)
                let alert = UIAlertController(title: "데이터 로드 실패", message: "데이터 로드 실패", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default))
                self.present(alert, animated: true)
            }
        }
    }
    
    func configureUI() {
        updateBookDetailView(selectedSeriesNum)
        setupbookInfoStackView()
        
        [mainTitleLabel, buttonStackView, scrollView]
            .forEach { view.addSubview($0) }
        
        addSeriesButtons()
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.addSubview(contentStackView)
        
        [bookInfoStackView, dedicationStackView, chapterStackView]
            .forEach { contentStackView.addArrangedSubview($0) }
        
        mainTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(mainTitleLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(buttonStackView.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentStackView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        contentStackView.isLayoutMarginsRelativeArrangement = true
        contentStackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        bookInfoStackView.snp.makeConstraints {
            $0.top.equalTo(contentStackView.snp.top)
        }
        
        bookImageView.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(bookImageView.snp.width).multipliedBy(1.5)
        }
        
        dedicationStackView.snp.makeConstraints {
            $0.top.equalTo(bookInfoStackView.snp.bottom).offset(24)
        }
        
//        chapterStackView.snp.makeConstraints {
//            $0.top.equalTo(summaryStackView.snp.bottom).offset(24)
//        }
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
        
        
    }
    
    func addChapters(_ selectedBook: Book) {
        chapterStackView.addArrangedSubview(chapterTitleLabel)
        
        var chapterLabels = Array<UILabel>()
        
        selectedBook.chapters.forEach {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14)
            label.textColor = .darkGray
            label.numberOfLines = 0
            label.text = $0.title
            
            chapterLabels.append(label)
        }
        
        chapterLabels.forEach {
            chapterStackView.addArrangedSubview($0)
        }
    }
    
    func addSeriesButtons() {
        for i in 0..<books.count {
            let button = UIButton()
            button.setTitle("\(i + 1)", for: .normal)
            button.contentHorizontalAlignment = .center
            button.titleLabel?.font = .systemFont(ofSize: 16)
            if i == 0 {
                button.setTitleColor(.white, for: .normal)
                button.backgroundColor = .systemBlue
            } else {
                button.setTitleColor(.systemBlue, for: .normal)
                button.backgroundColor = .systemGray5
            }
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
        guard let title = sender.title(for: .normal),
              let titleNum = Int(title) else { return }
        
        if titleNum == prevTitleNum {
            return
        }
        selectedSeriesNum = titleNum
        
        selectedBook = books[titleNum - 1]
        
        sender.backgroundColor = .systemBlue
        sender.setTitleColor(.white, for: .normal)

        if let prev = prevTitleNum,
           let prevButton = buttonStackView.arrangedSubviews[prev - 1] as? UIButton {
            prevButton.backgroundColor = .systemGray5
            prevButton.setTitleColor(.systemBlue, for: .normal)
        }
        
        prevTitleNum = titleNum
        updateBookDetailView(titleNum)
    }
    
    func updateBookDetailView(_ currentSeriesNum: Int) {
        guard let unwrappedSelectedBook = selectedBook else { return }
        
        mainTitleLabel.text = unwrappedSelectedBook.title
        bookImageView.image = UIImage(named: "harrypotter\(currentSeriesNum)")
        titleLabel.text = unwrappedSelectedBook.title
        authorTitleLabel.text = "Author"
        authorValueLabel.text = unwrappedSelectedBook.author
        publishDateTitleLabel.text = "Released"
        publishDateValueLabel.text = formatDate(unwrappedSelectedBook.releaseDate)
        pageCountTitleLabel.text = "Pages"
        pageCountValueLabel.text = "\(unwrappedSelectedBook.pages)"
        dedicationTitleLabel.text = "Dedication"
        dedicationContentLabel.text = unwrappedSelectedBook.dedication
        
        chapterTitleLabel.text = "Chapters"
        
        chapterStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        addChapters(unwrappedSelectedBook)
    }
    
    func formatDate(_ inputDate: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMMM d, yyyy"
        
        guard let date = inputFormatter.date(from: inputDate) else { return inputDate }
        
        return outputFormatter.string(from: date)
    }
}

extension ViewController: SummaryViewDelegate {
    func summaryViewDidToggle(_ isExpanded: Bool) {
        UserDefaults.standard.set(isExpanded, forKey: "isExpanded_\(selectedSeriesNum)")
    }
}

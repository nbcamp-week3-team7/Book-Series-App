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
    
    private let seriesButtonView = SeriesButtonView()
    private let bookInfoView = BookInfoView()
    private let dedicationView = DedicationView()
    private let summaryView = SummaryView()
    private let chapterListView = ChapterListView()
    
    let mainTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        return label
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
        
        seriesButtonView.delegate = self
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
        
        [mainTitleLabel, seriesButtonView, scrollView]
            .forEach { view.addSubview($0) }
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.addSubview(contentStackView)
        
        [bookInfoView, dedicationView, summaryView, chapterListView]
            .forEach { contentStackView.addArrangedSubview($0) }
        
        mainTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        seriesButtonView.snp.makeConstraints {
            $0.top.equalTo(mainTitleLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(seriesButtonView.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentStackView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        contentStackView.isLayoutMarginsRelativeArrangement = true
        contentStackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        bookInfoView.snp.makeConstraints {
            $0.top.equalTo(contentStackView.snp.top)
        }
        
        dedicationView.snp.makeConstraints {
            $0.top.equalTo(bookInfoView.snp.bottom).offset(24)
        }
        
        summaryView.snp.makeConstraints {
            $0.top.equalTo(dedicationView.snp.bottom).offset(24)
        }
        
        chapterListView.snp.makeConstraints {
            $0.top.equalTo(summaryView.snp.bottom).offset(24)
        }
    }
    
    func updateBookDetailView(_ currentSeriesNum: Int) {
        guard let unwrappedSelectedBook = selectedBook else { return }
        
        seriesButtonView.configure(seriesCount: books.count, selectedIndex: currentSeriesNum - 1)
        
        mainTitleLabel.text = unwrappedSelectedBook.title
        
        bookInfoView.configure(book: unwrappedSelectedBook, currentSeriesNum: currentSeriesNum)
        
        dedicationView.configure(content: unwrappedSelectedBook.dedication)
        
        let isExpanded = UserDefaults.standard.bool(forKey: "isExpanded_\(currentSeriesNum)")
        summaryView.configure(summary: unwrappedSelectedBook.summary, seriesNum: currentSeriesNum, isExpanded: isExpanded)
        
        chapterListView.configure(chapters: unwrappedSelectedBook.chapters)
    }
}

extension ViewController: SeriesButtonViewDelegate {
    func seriesButtonTapped(index: Int) {
        guard index != selectedSeriesNum - 1 else { return }
        
        selectedSeriesNum = index + 1
        selectedBook = books[index]
        
        updateBookDetailView(selectedSeriesNum)
    }
}

extension ViewController: SummaryViewDelegate {
    func summaryViewDidToggle(_ isExpanded: Bool) {
        UserDefaults.standard.set(isExpanded, forKey: "isExpanded_\(selectedSeriesNum)")
    }
}

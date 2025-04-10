//
//  ViewController.swift
//  HarryPotterSeriesApp
//
//  Created by shinyoungkim on 3/28/25.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {
    // MARK: - UI Components
    private let mainTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let seriesButtonView = SeriesButtonView()
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        return sv
    }()
    
    private let contentStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 24
        sv.distribution = .fill
        sv.alignment = .fill
        sv.isLayoutMarginsRelativeArrangement = true
        sv.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return sv
    }()
    
    private let bookInfoView = BookInfoView()
    private let dedicationView = DedicationView()
    private let summaryView = SummaryView()
    private let chapterListView = ChapterListView()
    
    // MARK: - Data
    private let dataService = DataService()
    private var books = [Book]()
    private var selectedBook: Book?
    private var selectedSeriesNum = 1
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupViews()
        setupConstraints()
        setupDelegates()
        loadBooks()
    }
    
    // MARK: - Setup
    private func setupViews() {
        [mainTitleLabel, seriesButtonView, scrollView]
            .forEach { view.addSubview($0) }
        
        scrollView.addSubview(contentStackView)
        
        [bookInfoView, dedicationView, summaryView, chapterListView]
            .forEach { contentStackView.addArrangedSubview($0) }
    }
    
    private func setupConstraints() {
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
    
    private func setupDelegates() {
        seriesButtonView.delegate = self
        summaryView.delegate = self
    }
    
    // MARK: - Data Loading
    func loadBooks() {
        dataService.loadBooks { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let books):
                self.books = books
                self.selectedBook = books[0]
                self.selectedSeriesNum = 1
                self.updateBookDetailView(self.selectedSeriesNum)
                
            case .failure(let error):
                let alert = UIAlertController(
                    title: "데이터 로드 실패",
                    message: error.localizedDescription,
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "확인", style: .default))
                self.present(alert, animated: true)
            }
        }
    }
    
    // MARK: - UI Update
    func updateBookDetailView(_ currentSeriesNum: Int) {
        guard let unwrappedSelectedBook = selectedBook else { return }
        
        mainTitleLabel.text = unwrappedSelectedBook.title
        
        seriesButtonView.configure(seriesCount: books.count, selectedIndex: currentSeriesNum - 1)
        
        bookInfoView.configure(book: unwrappedSelectedBook, currentSeriesNum: currentSeriesNum)
        
        dedicationView.configure(content: unwrappedSelectedBook.dedication)
        
        let isExpanded = UserDefaults.standard.bool(forKey: "isExpanded_\(currentSeriesNum)")
        summaryView.configure(summary: unwrappedSelectedBook.summary, seriesNum: currentSeriesNum, isExpanded: isExpanded)
        
        chapterListView.configure(chapters: unwrappedSelectedBook.chapters)
    }
}

// MARK: - SeriesButtonViewDelegate
extension ViewController: SeriesButtonViewDelegate {
    func seriesButtonTapped(index: Int) {
        guard index != selectedSeriesNum - 1 else { return }
        
        selectedSeriesNum = index + 1
        selectedBook = books[index]
        
        updateBookDetailView(selectedSeriesNum)
    }
}

// MARK: - SummaryViewDelegate
extension ViewController: SummaryViewDelegate {
    func summaryViewDidToggle(_ isExpanded: Bool) {
        UserDefaults.standard.set(isExpanded, forKey: "isExpanded_\(selectedSeriesNum)")
    }
}

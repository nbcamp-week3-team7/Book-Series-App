//
//  BookInfoView.swift
//  HarryPotterSeriesApp
//
//  Created by shinyoungkim on 4/4/25.
//

import UIKit
import SnapKit

class BookInfoView: UIView {
    private let bookInfoStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 8
        sv.alignment = .top
        return sv
    }()
    
    private let bookImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let bookDetailStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 8
        sv.alignment = .leading
        return sv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let authorInfoStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 8
        return sv
    }()
    
    private let authorTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let authorValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .darkGray
        return label
    }()
    
    private let publishDateInfoStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 8
        return sv
    }()
    
    private let publishDateTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private let publishDateValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private let pageCountInfoStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 8
        return sv
    }()
    
    private let pageCountTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private let pageCountValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
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
        
        addSubview(bookInfoStackView)
        
        bookInfoStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bookImageView.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(bookImageView.snp.width).multipliedBy(1.5)
        }
    }
    
    func configure(book: Book, currentSeriesNum: Int) {
        bookImageView.image = UIImage(named: "harrypotter\(currentSeriesNum)")
        titleLabel.text = book.title
        authorTitleLabel.text = "Author"
        authorValueLabel.text = book.author
        publishDateTitleLabel.text = "Released"
        publishDateValueLabel.text = formatDate(book.releaseDate)
        pageCountTitleLabel.text = "Pages"
        pageCountValueLabel.text = "\(book.pages)"
    }
    
    private func formatDate(_ inputDate: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMMM d, yyyy"
        
        guard let date = inputFormatter.date(from: inputDate) else { return inputDate }
        
        return outputFormatter.string(from: date)
    }
}

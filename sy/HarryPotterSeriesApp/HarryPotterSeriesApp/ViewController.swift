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
    
    let seriesButton: UIButton = {
        let button = UIButton()
        button.contentHorizontalAlignment = .center
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        return button
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        loadBooks()
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
        mainTitleLabel.text = books[0].title
        seriesButton.setTitle("1", for: .normal)
        bookImageView.image = #imageLiteral(resourceName: "harrypotter1")
        titleLabel.text = books[0].title
        authorTitleLabel.text = "Author"
        authorValueLabel.text = books[0].author
        publishDateTitleLabel.text = "Released"
        publishDateValueLabel.text = books[0].releaseDate
        pageCountTitleLabel.text = "Pages"
        pageCountValueLabel.text = "\(books[0].pages)"
        setupbookInfoStackView()
        
        [mainTitleLabel, seriesButton, bookInfoStackView]
            .forEach { view.addSubview($0) }
        
        mainTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        seriesButton.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.top.equalTo(mainTitleLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        bookInfoStackView.snp.makeConstraints {
            $0.top.equalTo(seriesButton.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
        }
        
        bookImageView.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(bookImageView.snp.width).multipliedBy(1.5)
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
    }
}


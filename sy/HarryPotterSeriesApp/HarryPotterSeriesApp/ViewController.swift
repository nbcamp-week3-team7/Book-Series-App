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
        
        [mainTitleLabel, seriesButton]
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
    }
}


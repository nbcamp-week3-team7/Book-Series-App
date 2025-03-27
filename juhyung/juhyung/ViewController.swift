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
    
    
    let titleLabel = UILabel()
    let seriesOrderView = UIView()
    let seriesNumber = UILabel()
    
    func loadBooks() {
        dataService.loadBooks { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let books):
                    self.books = books
                    self.selectedSeriesView(at: 0)
                    
                case .failure(let error):
                    print("\(error)")
                }
            }
        }
    }
    
    private func selectedSeriesView(at number: Int) {
        let book = books[number]
        
        titleLabel.text = book.title
        
    }
    
    private func configureUI() {
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.text = "임시 텍스트"
        
        seriesOrderView.backgroundColor = .systemBlue
        seriesOrderView.clipsToBounds = true
        
        seriesNumber.textAlignment = .center
        seriesNumber.font = .systemFont(ofSize: 16)
        seriesNumber.textColor = .black
        seriesNumber.text = "1"
        
        [titleLabel, seriesOrderView]
            .forEach{ view.addSubview( $0 )}
        seriesOrderView.addSubview(seriesNumber)
        
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        seriesOrderView.snp.makeConstraints{
            $0.width.equalTo(40)
            $0.height.equalTo(40)
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.greaterThanOrEqualToSuperview().offset(20)
            $0.trailing.lessThanOrEqualToSuperview().offset(-20)
            $0.centerX.equalToSuperview()
        }
        
        seriesNumber.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        seriesOrderView.layer.cornerRadius = seriesOrderView.bounds.height / 2
    }
}


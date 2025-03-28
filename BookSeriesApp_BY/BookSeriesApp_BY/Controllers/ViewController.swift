//
//  ViewController.swift
//  BookSeriesApp_BY
//
//  Created by iOS study on 3/27/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let bookTitleLable = UILabel()
    let bookNumberLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        print("화면 나오고 있어요")
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        [bookTitleLable, bookNumberLabel].forEach { view.addSubview($0) }
        
        // ===== LV 1. 책 제목 표시 =====
        bookTitleLable.text = "라벨 테스트"
        bookTitleLable.textColor = .black
        bookTitleLable.font = UIFont.boldSystemFont(ofSize: 24)
        bookTitleLable.textAlignment = .center
        
        bookTitleLable.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(10)
        }
        
        // ===== LV 2. 라벨 원형 표시 =====
        bookNumberLabel.text = "1"
        bookNumberLabel.textAlignment = .center
        bookNumberLabel.backgroundColor = .systemBlue
        bookNumberLabel.textColor = .white
        bookNumberLabel.font = UIFont.systemFont(ofSize: 16)
        bookNumberLabel.clipsToBounds = true
        bookNumberLabel.layer.cornerRadius = 20
        
        bookNumberLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(180)
            $0.trailing.equalToSuperview().inset(180)
            $0.top.equalTo(bookTitleLable.snp.bottom).offset(16)
            $0.width.equalTo(40)
            $0.height.equalTo(40)
        }
    }
    
}

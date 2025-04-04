//
//  ChapterListView.swift
//  HarryPotterSeriesApp
//
//  Created by shinyoungkim on 4/4/25.
//

import UIKit
import SnapKit

final class ChapterListView: UIView {
    private let chapterStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 8
        return sv
    }()
    
    private let chapterTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
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
        chapterStackView.addArrangedSubview(chapterTitleLabel)
        
        addSubview(chapterStackView)
        
        chapterStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(chapters: [Chapter]) {
        chapterStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        chapterTitleLabel.text = "Chapters"
        chapterStackView.addArrangedSubview(chapterTitleLabel)
        
        chapters.forEach {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14)
            label.textColor = .darkGray
            label.numberOfLines = 0
            label.text = $0.title
            
            chapterStackView.addArrangedSubview(label)
        }
    }
}

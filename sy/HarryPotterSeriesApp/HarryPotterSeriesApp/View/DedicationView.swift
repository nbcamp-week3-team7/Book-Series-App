//
//  DedicationView.swift
//  HarryPotterSeriesApp
//
//  Created by shinyoungkim on 4/4/25.
//

import UIKit
import SnapKit

final class DedicationView: UIView {
    private let dedicationStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 8
        return sv
    }()
    
    private let dedicationTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let dedicationContentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
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
        [dedicationTitleLabel, dedicationContentLabel]
            .forEach { dedicationStackView.addArrangedSubview($0) }
        
        addSubview(dedicationStackView)
        
        dedicationStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(content: String) {
        dedicationTitleLabel.text = "Dedication"
        dedicationContentLabel.text = content
    }
}

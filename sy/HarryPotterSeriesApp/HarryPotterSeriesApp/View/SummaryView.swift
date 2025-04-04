//
//  SummaryView.swift
//  HarryPotterSeriesApp
//
//  Created by shinyoungkim on 4/4/25.
//

import UIKit
import SnapKit

protocol SummaryViewDelegate: AnyObject {
    func summaryViewDidToggle(_ isExpanded: Bool)
}

class SummaryView: UIView {
    weak var delegate: SummaryViewDelegate?
    
    let summaryStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 8
        return sv
    }()
    
    let summaryTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    let summaryContentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    let readMoreToggleButton: UIButton = {
        let button = UIButton()
        button.setTitle("더 보기", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.contentHorizontalAlignment = .right
        return button
    }()
    
    private var isExpanded: Bool = false
    private var seriesNum: Int = 0
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [summaryTitleLabel, summaryContentLabel]
            .forEach { summaryStackView.addArrangedSubview($0) }
        
        addSubview(summaryStackView)
        
        readMoreToggleButton.addTarget(self, action: #selector(toggleSummaryText), for: .touchUpInside)
        
        summaryStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    @objc func toggleSummaryText() {
        isExpanded.toggle()
        applyExpandedState()
        delegate?.summaryViewDidToggle(isExpanded)
    }
    
    func configure(summary: String, seriesNum: Int, isExpanded: Bool) {
        summaryTitleLabel.text = "Summary"
        summaryContentLabel.text = summary
        self.seriesNum = seriesNum
        self.isExpanded = isExpanded
        
        updateLabelWithReadMore(summary)
    }
    
    private func updateLabelWithReadMore(_ summary: String) {
        if summary.count >= 450 {
            summaryStackView.addArrangedSubview(readMoreToggleButton)            
            applyExpandedState()
        } else {
            summaryContentLabel.numberOfLines = 0
            readMoreToggleButton.removeFromSuperview()
        }
    }
    
    private func applyExpandedState() {
        if isExpanded {
            summaryContentLabel.numberOfLines = 0
            readMoreToggleButton.setTitle("접기", for: .normal)
        } else {
            summaryContentLabel.numberOfLines = 7
            readMoreToggleButton.setTitle("더 보기", for: .normal)
        }
    }
}

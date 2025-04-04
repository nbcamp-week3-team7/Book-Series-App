//
//  SeriesButtonView.swift
//  HarryPotterSeriesApp
//
//  Created by shinyoungkim on 4/4/25.
//

import UIKit
import SnapKit

protocol SeriesButtonViewDelegate: AnyObject {
    func seriesButtonTapped(index: Int)
}

class SeriesButtonView: UIStackView {
    weak var delegate: SeriesButtonViewDelegate?
    
    private var currentSelectedIndex: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStackView() {
        axis = .horizontal
        spacing = 8
        alignment = .center
        distribution = .equalCentering
    }
    
    func configure(seriesCount: Int, selectedIndex: Int = 0) {
        arrangedSubviews.forEach { removeArrangedSubview($0); $0.removeFromSuperview() }
        
        currentSelectedIndex = selectedIndex
        
        for i in 0..<seriesCount {
            let button = UIButton()
            button.setTitle("\(i + 1)", for: .normal)
            button.contentHorizontalAlignment = .center
            button.titleLabel?.font = .systemFont(ofSize: 16)
            button.tag = i
            
            if i == selectedIndex {
                button.setTitleColor(.white, for: .normal)
                button.backgroundColor = .systemBlue
            } else {
                button.setTitleColor(.systemBlue, for: .normal)
                button.backgroundColor = .systemGray5
            }
            
            button.layer.cornerRadius = 20
            button.clipsToBounds = true
            
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            
            button.snp.makeConstraints {
                $0.width.height.equalTo(40)
            }
            
            addArrangedSubview(button)
        }
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        guard sender.tag != currentSelectedIndex else { return }
        
        if let prevButton = arrangedSubviews[currentSelectedIndex] as? UIButton {
            prevButton.setTitleColor(.systemBlue, for: .normal)
            prevButton.backgroundColor = .systemGray5
        }
        
        sender.backgroundColor = .systemBlue
        sender.setTitleColor(.white, for: .normal)
        
        currentSelectedIndex = sender.tag
        
        delegate?.seriesButtonTapped(index: sender.tag)
    }
}

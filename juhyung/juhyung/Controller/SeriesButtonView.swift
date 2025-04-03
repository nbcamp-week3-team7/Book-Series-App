//
//  Controller.swift
//  juhyung
//
//  Created by 윤주형 on 4/3/25.
//

import UIKit
import SnapKit

// Delegate Protocol
protocol SeriesButtonDelegate: AnyObject {
    func didTapSeriesButton(at index: Int)
}

// Delegating Object
class SeriesButtonView: UIView {
    
    weak var delegate: SeriesButtonDelegate?
    internal var buttons: [UIButton] = []
    private var selectedIndex: Int?
    
    private let buttonStackView = UIStackView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureButton()
    }
    
    
    func configureButton() {
        
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 10
        
        
        addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints{
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func configureButtons(count: Int) {
        
        //remove하는 이유 더 딥하게 고려해보기
        buttonStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        buttons.removeAll()
        
        for i in 0..<count {
            let button = UIButton(type: .system)
            button.setTitle("\(i + 1)", for: .normal)
            //tag: The default value is 0. You can set the value of this tag and use that value to identify the view later.
            button.tag = i
            button.buttonStyle()
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            
            button.snp.makeConstraints {
                $0.width.height.equalTo(40)
            }
            
            buttons.append(button)
            buttonStackView.addArrangedSubview(button)
        }
        selectedIndex(index: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    
    func selectedIndex(index: Int) {
        self.selectedIndex = index
        
        for (i, button) in buttons.enumerated() {
            if i == index {
                button.buttonSelectedStyle()
            } else {
                button.buttonUnSelectedStyle()
            }
        }
    }
    
    
    @objc private func buttonTapped(_ sender: UIButton) {
        let index = sender.tag
        selectedIndex(index: index)
        delegate?.didTapSeriesButton(at: index)
        
    }
}

extension UIButton {
    
    func buttonStyle() {
        
        self.titleLabel?.font = .systemFont(ofSize: 16)
        self.setTitleColor(.systemBlue, for: .normal)
        self.backgroundColor = .darkGray
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
    }
    
    func buttonSelectedStyle() {
        self.backgroundColor = .systemBlue
        self.setTitleColor(.white, for: .normal)
    }
    
    func buttonUnSelectedStyle() {
        self.backgroundColor = .lightGray
        self.setTitleColor(.systemBlue, for: .normal)
    }
}


//
//  CustomButton.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 21.05.2023.
//

import Combine
import UIKit
import SnapKit

final class CustomButton: UIView {
    
    private var bag = Set<AnyCancellable>()
    var tapped = PassthroughSubject<Void, Never>()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.numberOfLines = 1
        return view
    }()
    
    private let arrow: UIImageView = {
        let view = UIImageView(image: UIImage(named: "rightArrow"))
        view.contentMode = .scaleToFill
        view.isHidden = true
        return view
    }()
    
    init(
        title: String,
        titleFont: UIFont = UIFont.Inter.medium(ofSize: 24.0),
        titleAligment: NSTextAlignment = .left,
        color: UIColor,
        hideArrow: Bool = true
    ) {
        self.titleLabel.text = title
        titleLabel.font = titleFont
        titleLabel.textAlignment = titleAligment
        arrow.isHidden = hideArrow
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = color
        setupView()
        addOnTapGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension CustomButton {
    
    func setupView() {
        layer.cornerRadius = 12.0
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12.0)
            make.leading.trailing.equalToSuperview().inset(20.0)
        }
        addSubview(arrow)
        arrow.snp.makeConstraints { make in
            make.width.height.equalTo(24.0)
            make.top.bottom.equalToSuperview().inset(15.0)
            make.trailing.equalToSuperview().inset(15.0)
        }
    }
    
    private func addOnTapGestureRecognizer() {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(self.handleTap(_:))
        )
        self.addGestureRecognizer(tap)
    }
    
    @objc private func handleTap(
        _ sender: UITapGestureRecognizer?
    ) {
        tapped.send()
        blink()
    }
}

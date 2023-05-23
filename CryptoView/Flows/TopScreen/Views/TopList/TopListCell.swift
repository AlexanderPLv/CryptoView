//
//  TopListCell.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 21.05.2023.
//

import UIKit
import SnapKit

final class TopListCell: UICollectionViewCell {
    
    private let indexLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.Inter.medium(ofSize: 14.0)
        view.textColor = .white
        view.numberOfLines = 1
        view.textAlignment = .left
        view.adjustsFontSizeToFitWidth = true
        return view
    }()
    
    private let countryImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        return view
    }()
    
    private let nameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.Inter.medium(ofSize: 14.0)
        view.textColor = .white
        view.numberOfLines = 1
        view.textAlignment = .center
        view.adjustsFontSizeToFitWidth = true
        return view
    }()
    
    private let depositLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.Inter.medium(ofSize: 14.0)
        view.textColor = .white
        view.numberOfLines = 1
        view.textAlignment = .right
        view.adjustsFontSizeToFitWidth = true
        return view
    }()
    
    private let profitLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.Inter.medium(ofSize: 14.0)
        view.textColor = Color.Common.lightGreen
        view.numberOfLines = 1
        view.textAlignment = .right
        view.adjustsFontSizeToFitWidth = true
        return view
    }()
    
    var item: TopListCellItem? {
        didSet {
            guard let item else { return }
            indexLabel.text = item.index.formatted()
            countryImage.image = UIImage(named: item.country)
            nameLabel.text = item.name
            depositLabel.text = item.depositAsString()
            profitLabel.text = item.profitAsString()
            profitLabel.textColor = (item.profit > 0) ? Color.Common.lightGreen : .red
            backgroundColor = (item.index % 2 == 0) ? Color.Common.listCellBackground : .clear
            if isLastElement {
                clipsToBounds = true
                layer.cornerRadius = 10
                layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            }
        }
    }
    var isLastElement = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        layer.cornerRadius = 0
    }
}

private extension TopListCell {
    func setupViews() {
        backgroundColor = .clear
        
        addSubview(indexLabel)
        indexLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(25.0)
            make.leading.equalToSuperview().inset(9.0)
        }
        
        let stack = UIStackView(arrangedSubviews: [
            countryImage,
            HSpacer(42.0),
            nameLabel,
            HSpacer(14.0),
            depositLabel,
            HSpacer(14.0),
            profitLabel
        ])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 0.0
        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.height.equalTo(26.0)
            make.centerY.equalToSuperview()
            make.leading.equalTo(indexLabel.snp.trailing).offset(5.0)
            make.trailing.equalToSuperview().inset(14.0)
        }
    }
}

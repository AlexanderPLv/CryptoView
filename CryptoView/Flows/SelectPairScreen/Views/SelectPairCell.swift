//
//  SelectPairCell.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 23.05.2023.
//

import UIKit
import SnapKit

final class SelectPairCell: UICollectionViewCell {
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        view.textColor = .white
        view.numberOfLines = 1
        view.textAlignment = .center
        return view
    }()
    
    var viewModel: PairCellViewModel? {
        didSet {
            guard let viewModel else { return }
            titleLabel.text = viewModel.pair.rawValue
            backgroundColor = viewModel.isSelected ? Color.Common.lightGreen : Color.Common.darkGray
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension SelectPairCell {
    func setupViews() {
        backgroundColor = Color.Common.darkGray
        layer.cornerRadius = 12.0
        clipsToBounds = true
        
        let background = UIView()
        background.backgroundColor = Color.Common.lightGreen
        selectedBackgroundView = background
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

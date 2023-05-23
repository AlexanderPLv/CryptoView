//
//  TopScreen.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 20.05.2023.
//

import UIKit
import SnapKit

final class TopScreen: UIViewController {
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.Inter.bold(ofSize: 22.0)
        view.textColor = .white
        view.numberOfLines = 1
        view.text = "TOP 10 Traders"
        view.textAlignment = .center
        return view
    }()
    
    private let list: TopList
    
    init() {
        let listVM = TopListViewModel()
        self.list = TopList(viewModel: listVM)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

private extension TopScreen {
    func setupViews() {
        view.backgroundColor = Color.Common.background
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(64.0)
        }
        addChild(list)
        view.addSubview(list.view)
        list.view.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30.0)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

//
//  SelectPairScreen.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 22.05.2023.
//

import UIKit
import SnapKit

final class SelectPairScreen: UIViewController {
    
    var close: CompletionBlock?
    
    private lazy var backButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "leftArrow"), for: .normal)
        view.addTarget(self, action: #selector(handleArrowTap), for: .touchUpInside)
        return view
    }()
    
    init() {
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind()
    }
}

private extension SelectPairScreen {
    
    @objc func handleArrowTap() {
        close?()
    }
    
    func bind() {
        
    }
    
    func setupViews() {
        view.backgroundColor = .red
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.width.height.equalTo(24.0)
            make.top.equalToSuperview().inset(65.0)
            make.leading.equalToSuperview().inset(10.0)
        }
    }
}

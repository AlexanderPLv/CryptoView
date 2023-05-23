//
//  ProgressView.swift
//  undo.ios.dev
//
//  Created by Alexander Pelevinov on 19.02.2023.
//

import UIKit
import SnapKit

final class ProgressView: UIView {
    
    @objc dynamic var value: Float = 0.0
    
    private let progressView: UIProgressView = {
        let view = UIProgressView(progressViewStyle: .default)
        view.progress = 0.0
        return view
    }()
    
    private let label: UILabel = {
        let view = UILabel()
        view.font = UIFont.Inter.extraBold(ofSize: 16.0)
        view.textColor = .white
        view.numberOfLines = 1
        view.text = "00%"
        view.textAlignment = .center
        return view
    }()
    
    init(
        trackTintColor: UIColor = Color.Common.lightGray,
        progressTintColor: UIColor = Color.Common.lightGreen,
        cornerRadius: CGFloat
    ) {
        self.progressView.trackTintColor = trackTintColor
        self.progressView.progressTintColor = progressTintColor
        super.init(frame: .zero)
        self.layer.cornerRadius = cornerRadius
        setupView()
        addObserver()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        removeObserver(self, forKeyPath: #keyPath(ProgressView.value))
    }
    
    override func observeValue(
        forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey : Any]?,
        context: UnsafeMutableRawPointer?
    ) {
        if keyPath == "value" {
            progressView.setProgress(value, animated: true)
            label.text = "\(Int(value * 100))" + "%"
        }
    }
}

private extension ProgressView {
    
    func addObserver() {
        addObserver(self, forKeyPath: #keyPath(ProgressView.value), context: nil)
    }
    
    func setupView() {
        clipsToBounds = true
        
        addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

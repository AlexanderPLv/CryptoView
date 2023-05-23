//
//  OnboardingScreen.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 20.05.2023.
//

import UIKit
import SnapKit

final class OnboardingScreen: UIViewController {
    
    var close: CompletionBlock?
    var showErrorWithMessage: ((String) -> Void)?
    
    private let imageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "launchScreenBackground"))
        view.contentMode = .scaleToFill
        return view
    }()
    
    private let progressView = ProgressView(cornerRadius: 12.0)
    var progressValue: Float = 0.0
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        perform(#selector(updateProgress), with: nil, afterDelay: 0.1)
    }
}

private extension OnboardingScreen {
    func setupViews() {
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        view.addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.height.equalTo(24.0)
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(38.0)
        }
    }
    
    @objc func updateProgress() {
        progressValue += 0.1
        self.progressView.value = progressValue
        if !(progressValue >= 1) {
            perform(#selector(updateProgress), with: nil, afterDelay: 0.1)
        } else {
            progressView.isHidden = true
            askPushNotificationsPermissions()
        }
    }
    
    func askPushNotificationsPermissions() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.showErrorWithMessage?(error.localizedDescription)
                } else {
                    self.close?()
                }
            }
        }
    }
}

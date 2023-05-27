//
//  OnboardingScreen.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 20.05.2023.
//

import UIKit
import SnapKit
import WebKit

final class OnboardingScreen: UIViewController {
    
    var close: CompletionBlock?
    var showErrorWithMessage: ((String) -> Void)?
    
    private let imageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "launchScreenBackground"))
        view.contentMode = .scaleToFill
        return view
    }()
    
    private let progressView = ProgressView(cornerRadius: 12.0)
    private let webView: WKWebView
    
    init(
        webView: WKWebView
    ) {
        self.webView = webView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        perform(#selector(loadwidget), with: nil, afterDelay: 0.1)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.value = Float(webView.estimatedProgress)
            if webView.estimatedProgress >= 1 {
                progressView.isHidden = true
                askPushNotificationsPermissions()
            }
        }
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
    
    @objc func loadwidget() {
        let pair = CurrencyPair.allCases.first!
        DispatchQueue.main.async {
            self.webView.loadHTMLString(HTML.string(with: pair.requestSymbol), baseURL: nil)
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

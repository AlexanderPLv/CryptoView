//
//  SelectPairScreen.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 22.05.2023.
//

import UIKit
import SnapKit

protocol PairSelectionDelegate: AnyObject {
    func didSelectPair(_ pair: CurrencyPair)
}

final class SelectPairScreen: UIViewController {
    
    var close: CompletionBlock?
    
    private let padding: CGFloat = 37.0
    private let lineSpacing: CGFloat = 20.0
    
    private weak var delegate: PairSelectionDelegate?
    
    private lazy var backButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "leftArrow"), for: .normal)
        view.addTarget(self, action: #selector(handleArrowTap), for: .touchUpInside)
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.Inter.bold(ofSize: 22.0)
        view.textColor = .white
        view.numberOfLines = 1
        view.text = "Currency pair"
        view.textAlignment = .center
        return view
    }()
    
    private let collectionView: UICollectionView
    private let pairs = CurrencyPair.allCases
    private let selectedPair: CurrencyPair
    
    init(
        selectedPair: CurrencyPair,
        delegate: PairSelectionDelegate
    ) {
        self.selectedPair = selectedPair
        self.delegate = delegate
        self.collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupViews()
    }
}

extension SelectPairScreen: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pairs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectPairCell.reuseIdentifier, for: indexPath) as? SelectPairCell else { fatalError("Error! Unable to dequeu SelectPairCell") }
        cell.viewModel = PairCellViewModel(pair: pairs[indexPath.item], isSelected: false)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 2 - padding - 10.0
        return CGSize(width: width, height: 54.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        lineSpacing
    }
}

private extension SelectPairScreen {
    
    @objc func handleArrowTap() {
        if let index = collectionView.indexPathsForSelectedItems?.first?.item {
            delegate?.didSelectPair(pairs[index])
        }
        close?()
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = .init(top: padding, left: padding, bottom: 0.0, right: padding)
        collectionView.register(
            SelectPairCell.self,
            forCellWithReuseIdentifier: SelectPairCell.reuseIdentifier
        )
        collectionView.backgroundColor = .clear
        
        guard let itemIndex = pairs.firstIndex(of: selectedPair) else { return }
        let currentIndexPath = IndexPath(item: itemIndex, section: 0)
        collectionView.selectItem(at: currentIndexPath, animated: false, scrollPosition: .centeredVertically)
    }
    
    func setupViews() {
        view.backgroundColor = Color.Common.background
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.width.height.equalTo(24.0)
            make.top.equalToSuperview().inset(65.0)
            make.leading.equalToSuperview().inset(10.0)
        }
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(64.0)
            make.centerX.equalToSuperview()
        }
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

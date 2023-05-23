//
//  TopList.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 21.05.2023.
//

import UIKit
import SnapKit
import Combine

typealias DetalizationListDataSource =
    UICollectionViewDiffableDataSource<TopListSectionItem, TopListItem>
typealias DetalizationSnapshot =
    NSDiffableDataSourceSnapshot<TopListSectionItem, TopListItem>

final class TopList: UIViewController {
        
    private var bag = [AnyCancellable]()
    
    private var dataSource: DetalizationListDataSource!
    private lazy var collectionView = makeCollectionView()
    
    private let viewModel: TopListViewModel
    
    init(
        viewModel: TopListViewModel
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        registerViews()
        configureDataSource()
        bind()
    }
}

private extension TopList {
    
    func makeCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: LayoutsFactory.createTopListLayout()
        )
        collectionView.backgroundColor = .clear
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.automaticallyAdjustsScrollIndicatorInsets = false
        collectionView.allowsSelection = false
        return collectionView
    }
    
    func setupViews() {
        view.backgroundColor = Color.Common.background
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func bind() {
        viewModel.needUpdate
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.updateData()
            }.store(in: &bag)
    }
    
    func registerViews() {
        collectionView.register(
            TopListCell.self,
            forCellWithReuseIdentifier: TopListCell.reuseIdentifier
        )
        collectionView.register(
            TopListHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TopListHeader.reuseIdentifier
        )
    }
    
    func configureDataSource() {
        self.dataSource = DetalizationListDataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, listItem) -> UICollectionViewCell in
                let lastItemIndex = self.dataSource.snapshot().sectionIdentifiers[indexPath.section].items.count
                switch listItem {
                case .top(var item):
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: TopListCell.reuseIdentifier,
                        for: indexPath) as! TopListCell
                    item.index = indexPath.item + 1
                    cell.isLastElement = item.index == lastItemIndex
                    cell.item = item
                    return cell
                }
            })
        setupHeader()
        loadData()
        collectionView.dataSource = dataSource
    }
    
    func setupHeader() {
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            if kind == UICollectionView.elementKindSectionHeader {
                let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: TopListHeader.reuseIdentifier,
                    for: indexPath) as? TopListHeader
                return header
            } else {
                return UICollectionReusableView()
            }
        }
    }
    
    func updateData() {
        var newSnapshot = dataSource.snapshot()
        let sections = viewModel.getData()
        newSnapshot.deleteAllItems()
        newSnapshot.appendSections(sections)
        sections.forEach { section in
            newSnapshot.appendItems(section.items, toSection: section)
        }
        dataSource.apply(newSnapshot, animatingDifferences: false)
    }
    
    func loadData() {
        var snapshot = DetalizationSnapshot()
        let sections = viewModel.getData()
        snapshot.appendSections(sections)
        sections.forEach { section in
            snapshot.appendItems(section.items, toSection: section)
        }
        dataSource.apply(snapshot)
    }

}

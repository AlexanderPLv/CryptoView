//
//  TopListViewModel.swift
//  CryptoView
//
//  Created by Alexander Pelevinov on 21.05.2023.
//

import Foundation
import Combine

final class TopListViewModel {
    
    private var updateTimer: Timer?
    var needUpdate = PassthroughSubject<Void, Never>()
    
    private var data: [TopListCellItem] = [
        TopListCellItem(name: "Oliver", deposit: 2367, profit: 336743, country: "mauritius"),
        TopListCellItem(name: "Jack", deposit: 2367, profit: 336743, country: "hawaii"),
        TopListCellItem(name: "Harry", deposit: 2367, profit: 336743, country: "kiribati"),
        TopListCellItem(name: "Jacob", deposit: 2367, profit: 336743, country: "united_kingdom"),
        TopListCellItem(name: "Charley", deposit: 2367, profit: 336743, country: "union"),
        TopListCellItem(name: "Thomas", deposit: 2367, profit: 336743, country: "mongolia"),
        TopListCellItem(name: "George", deposit: 2367, profit: 336743, country: "sardinia"),
        TopListCellItem(name: "Oscar", deposit: 2367, profit: 336743, country: "nato"),
        TopListCellItem(name: "James", deposit: 2367, profit: 336743, country: "brazil"),
        TopListCellItem(name: "William", deposit: 2367, profit: 336743, country: "georgia"),
    ]
    
    init() {
        updateTimer = Timer.scheduledTimer(
            withTimeInterval: 5,
            repeats: true,
            block: { [weak self] timer in
                self?.updateData()
            })
    }
    
    deinit {
        updateTimer?.invalidate()
    }
    
    func getData() -> [TopListSectionItem] {
        let items: [TopListSectionItem] = [TopListSectionItem(
            items: data.map {TopListItem.top($0)}
        )]
        return items
    }
}

private extension TopListViewModel {
    func updateData() {
        data = data.map { item in
            guard Bool.random() else { return item }
            var mutable = item
            mutable.profit += Int.random(in: 50...150)
            mutable.deposit += Int.random(in: 50...150)
            return mutable
        }
        needUpdate.send()
    }
}

//
//  SearchTableViewCell.swift
//  FinancialApp
//
//  Created by Mehmet Can Seyhan on 2021-05-22.
//

import Foundation
import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var assetNameLabel: UILabel!
    @IBOutlet weak var assetSymbolLabel: UILabel!
    @IBOutlet weak var assetTypeLabel: UILabel!
    
    func configure(with searchResult: SearchResult) {
        assetNameLabel.text = searchResult.name
        assetSymbolLabel.text = searchResult.symbol
        assetTypeLabel.text = searchResult.type
            .appending(" ")
            .appending(searchResult.currency)
    }
    
}

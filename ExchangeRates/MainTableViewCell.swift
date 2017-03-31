//
//  MainTableViewCell.swift
//  ExchangeRates
//
//  Created by Admin on 3/31/17.
//  Copyright © 2017 BMSoftware. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    
    @IBOutlet weak var baseCurrencyImageView: UIImageView!
    @IBOutlet weak var currencyCodeLabel: UILabel!
    @IBOutlet weak var saleValueLabel: UILabel!
    @IBOutlet weak var buyValueLabel: UILabel!
    @IBOutlet weak var backgroudImageView: UIImageView!
    
    func configureCellUI(exchangerate: Exchangerate) {
        switch exchangerate.base_ccy {
        case "UAH":
            baseCurrencyImageView.image = UIImage.init(named: "UAH")
        default:
            baseCurrencyImageView.image = UIImage.init(named: "unknown")
        }
        
        switch exchangerate.ccy {
        case "USD":
            backgroudImageView.image = UIImage.init(named: "USD")
        case "EUR":
            backgroudImageView.image = UIImage.init(named: "EUR")
        case "RUR":
            backgroudImageView.image = UIImage.init(named: "RUR")
        default:
            backgroudImageView.image = UIImage.init(named: "unknown")
        }
        
        currencyCodeLabel.text = exchangerate.ccy
        saleValueLabel.text = String(exchangerate.sale)
        buyValueLabel.text = String(exchangerate.buy)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

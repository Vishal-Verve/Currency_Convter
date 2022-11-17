//
//  tblCellCurrency.swift
//  RxSwiftBasic
//
//  Created by Verve on 02/09/22.
//

import UIKit

class TblCellCurrency: UITableViewCell {

    @IBOutlet var lblCurrencySymbol: UILabel!
    @IBOutlet var lblCurrencyRates: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

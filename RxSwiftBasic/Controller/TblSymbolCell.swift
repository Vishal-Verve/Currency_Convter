//
//  tblSymbolCell.swift
//  RxSwiftBasic
//
//  Created by Verve on 30/08/22.
//

import UIKit
import RxSwift
import RxCocoa

class TblSymbolCell: UITableViewCell {

    @IBOutlet var lblCurrency: UILabel!
    var bag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        bag = DisposeBag()
        // Configure the view for the selected state
    }

}

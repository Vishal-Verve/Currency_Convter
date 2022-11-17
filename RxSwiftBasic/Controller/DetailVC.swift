//
//  DetailVC.swift
//  RxSwiftBasic
//
//  Created by Verve on 02/09/22.
//

import UIKit
import RxSwift
import RxCocoa

class DetailVC: UIViewController, UITableViewDelegate {

    // MARK: - Outlets
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var tblCurrency: UITableView!
    @IBOutlet weak var lblFromValue: UILabel!
    @IBOutlet weak var lblToValue: UILabel!
    @IBOutlet weak var lblAmountValue: UILabel!
    @IBOutlet weak var lblCurrentValue: UILabel!
    @IBOutlet weak var contblHeight: NSLayoutConstraint!

    lazy var tblDataRates: BehaviorRelay<[String: Double]> = BehaviorRelay(value: [:])
    var strPassAmount, strPassFrom, strPassTo, strCurrentRate: String!
    let disposebag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        displayData()
        createModelBinding()
    }

    func createModelBinding() {
        btnBack.rx.tap
            .bind {
                self.navigationController?.popViewController(animated: true)
              }
             .disposed(by: disposeBag)
    }

    func displayData() {
        self.lblFromValue.text = strPassFrom
        self.lblToValue.text = strPassTo
        self.lblAmountValue.text = strPassAmount
        self.lblCurrentValue.text = strCurrentRate
        callPopularCurency()
    }

    // MARK: - call an Api
    func callPopularCurency() {
        var param = [String: String]()
        param["symbols"] = "USD,KWD,AED,INR,JPY,GBP,CAD,CHF,CNH,KD,NZD,AUD"
        param["base"] = "EUR"
        Utils.showProgressHud()
        let client = APIClient.shared
        do {
            try client.callgetPopularCurrencyApi(passParam: param).subscribe(
            onNext: { result in
                DispatchQueue.main.async {
                    Utils.hideProgressHud()
                    self.tblDataRates.accept(result.rates)
                    self.tblDataRates.bind(to: self.tblCurrency.rx.items(cellIdentifier: "TblCellCurrency", cellType: TblCellCurrency.self)) { (index, _, cell) in
                      let getRate  = Array(self.tblDataRates.value.values)[index]
                        cell.lblCurrencyRates.text = "\(getRate)"
                        cell.lblCurrencySymbol.text = Array(self.tblDataRates.value.keys)[index]
                        self.contblHeight.constant = CGFloat(((self.tblDataRates.value.count * 50) + 20))
                    }.disposed(by: self.disposebag)
                }
            },
            onError: { error in
                DispatchQueue.main.async {
                    Utils.hideProgressHud()
                }
               print(error.localizedDescription)
            },
            onCompleted: {
                DispatchQueue.main.async {
                    Utils.hideProgressHud()
                }
               print("Completed event.")
            }).disposed(by: disposeBag)
          } catch {
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}

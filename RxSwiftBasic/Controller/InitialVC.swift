//
//  ViewController.swift
//  RxSwiftBasic
//
//  Created by Verve on 29/08/22.
//

import UIKit
import RxSwift
import RxCocoa

class InitialVC: UIViewController {
    
    @IBOutlet var txtForm: UITextField!
    @IBOutlet var txtTo: UITextField!
    @IBOutlet var btnDetails: UIButton!
    @IBOutlet var btnFrom: UIButton!
    @IBOutlet var btnTo: UIButton!
    @IBOutlet var btnReverse: UIButton!
    @IBOutlet var tblFrom: UITableView!
    @IBOutlet var viewFromTap: UIView!
    @IBOutlet var viewToTap: UIView!
    @IBOutlet var tblTo: UITableView!
    @IBOutlet var txtFromSearch: UITextField!
    @IBOutlet var txtToSearch: UITextField!
    @IBOutlet var viewFrom: UIView!
    @IBOutlet var viewTo: UIView!
    @IBOutlet var actIndi: UIActivityIndicatorView!
    
    let disposeBag = DisposeBag()
    lazy var dictFrom: [String: String] = [:]
    lazy var dictTo: [String: String] = [:]
    lazy var strSelectedFromtext: String = ""
    lazy var strSelectedTotext: String = ""
    lazy var strSearchText: String = ""
    lazy var strSearchToText: String = ""
    lazy var dictFromDuplicate: [String: String] = [:]
    lazy var dictToDuplicate: [String: String] = [:]
    var strCurrentRate: String =  ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.CreateViewModelBinding()
        
    
        CommonApi.callSymbolListApi(completion: {(success) in
            if success == true {
                self.dictFrom =  APIClient.shared.SharedDelegate.arrSymbol
                self.dictTo   =  self.dictFrom
                self.dictToDuplicate = self.dictFrom
                self.dictFromDuplicate  =  self.dictFrom
                if self.dictFrom.count > 0 {
                    DispatchQueue.main.async {
                        self.tblFrom.reloadData()
                        self.tblTo.reloadData()
                    }
                }
            }
        })
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        self.viewFromTap.addGestureRecognizer(tapgesture)
        
        let tapgesture1 = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        self.viewToTap.addGestureRecognizer(tapgesture1)
        
        tblFrom.layer.cornerRadius = 5
        self.viewFrom.isHidden = true
        self.viewTo.isHidden = true
        
        self.txtForm.setLeftPaddingPoints(10)
        self.txtTo.setLeftPaddingPoints(10)
        self.txtFromSearch.setTextFieldCornerRadius(8)
        self.txtFromSearch.setLeftPaddingPoints(10)
        self.txtToSearch.setTextFieldCornerRadius(8)
        self.txtToSearch.setLeftPaddingPoints(10)
        
        
        
        
    }
    
    
    // MARK: Functions
    func CreateViewModelBinding() {
        txtForm.rx.controlEvent([.editingDidEnd])
            .asObservable().subscribe({ [unowned self] _ in
                self.callApi()
            }).disposed(by: disposeBag)
        
        txtFromSearch.rx.controlEvent([.editingDidEnd])
            .asObservable().subscribe({ [unowned self] _ in
                strSearchText = self.txtFromSearch.text!
                if strSearchText == "" {
                    self.dictFrom = self.dictFromDuplicate
                    DispatchQueue.main.async {
                        self.tblFrom.reloadData()
                    }
                    
                } else {
                    strSearchText = self.txtFromSearch.text!
                    let filteredData  =  dictFrom.filter {$0.value.localizedCaseInsensitiveContains(self.strSearchText)}
                    filteredData.count > 0 ? (dictFrom = filteredData) : nil
                    DispatchQueue.main.async {
                        self.tblFrom.reloadData()
                    }
                }
                self.callApi()
            }).disposed(by: disposeBag)
        
        txtToSearch.rx.controlEvent([.editingDidEnd])
            .asObservable().subscribe({ [unowned self] _ in
                strSearchToText = self.txtToSearch.text!
                if strSearchToText == "" {
                    self.dictTo = self.dictToDuplicate
                    DispatchQueue.main.async {
                        self.tblTo.reloadData()
                    }
                    
                } else {
                    strSearchToText =  self.txtToSearch.text!
                    let filteredData  =  dictTo.filter {$0.value.localizedCaseInsensitiveContains(self.strSearchToText)}
                    filteredData.count > 0 ? (dictTo = filteredData) : nil
                    DispatchQueue.main.async {
                        self.tblTo.reloadData()
                    }
                }
                self.callApi()
            }).disposed(by: disposeBag)
        
        btnFrom.rx.tap
            .bind {
                self.onClickSelectFrom()
            }
            .disposed(by: disposeBag)
        
        btnTo.rx.tap
            .bind {
                self.onClickSelectTo()
            }
            .disposed(by: disposeBag)
        
        btnReverse.rx.tap
            .bind {
                self.btnReverselick()
            }
            .disposed(by: disposeBag)
        
        btnDetails.rx.tap
            .bind {
                self.btnDetailsClick()
            }
            .disposed(by: disposeBag)
        
    }
    
    @objc func removeTransparentView() {
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.btnFrom.isSelected == true ?                 (self.viewFrom.isHidden = true) : (self.viewTo.isHidden  = true )
        }, completion: nil)
    }
    
    // MARK: Action
    func onClickSelectFrom() {
        self.viewFrom.isHidden = false
        self.viewTo.isHidden = true
        self.btnFrom.isSelected = true
        self.btnTo.isSelected = false
        self.callApi()
    }
    
    func onClickSelectTo() {
        self.viewTo.isHidden = false
        self.viewFrom.isHidden = true
        self.btnTo.isSelected = true
        self.btnFrom.isSelected = false
        self.callApi()
    }
    
    func btnReverselick () {
        (self.strSelectedTotext, self.strSelectedFromtext) = (self.strSelectedFromtext, self.strSelectedTotext)
        self.btnFrom.setTitle(self.strSelectedFromtext, for: .normal)
        self.btnTo.setTitle(self.strSelectedTotext, for: .normal)
        self.callApi()
    }
    func btnDetailsClick () {
        
        if txtTo.text != "" {
            let detailVC  =  (self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailVC)!
            detailVC.strPassFrom = self.strSelectedFromtext
            detailVC.strPassAmount = self.txtTo.text
            detailVC.strPassTo = self.strSelectedTotext
            detailVC.strCurrentRate = self.strCurrentRate
            self.navigationController?.pushViewController(detailVC, animated: true)
            
        }
    }
    
    // MARK: Api Calling Function
    func callApi() {
        ((self.strSelectedFromtext != "") && (self.strSelectedTotext != "") && (self.txtForm.text != "")) ? (self.callConvertApi(passFromValue: self.strSelectedFromtext, passToValue: self.strSelectedTotext, passAmount: self.txtForm.text!)) : print("Can't get converter value")
    }
    
    func callConvertApi(passFromValue: String, passToValue: String, passAmount: String) {
        var param = [String: String]()
        param["from"] = passFromValue
        param["to"] = passToValue
        param["amount"] = passAmount
        Utils.showProgressHud()
        let client = APIClient.shared
        do {
            try client.callConverterListApi(passParam: param, passEndPoint: ApiEndPoint.AmountConverter.currencyConverter).subscribe(
                onNext: { result in
                    DispatchQueue.main.async {
                        Utils.hideProgressHud()
                        self.txtTo.text = "\(result.result)"
                        self.strCurrentRate = "\(result.info.rate)"
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
    
}

extension InitialVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableView == tblFrom ? (dictFrom.count) :(dictTo.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblFrom {
            let cell  = tblFrom.dequeueReusableCell(withIdentifier: "TblSymbolCell", for: indexPath) as? TblSymbolCell
            cell?.lblCurrency.text = Array(dictFrom.values)[indexPath.row]
            return cell ?? UITableViewCell()
        } else {
            let cell  = tblTo.dequeueReusableCell(withIdentifier: "TblSymbolCell", for: indexPath) as? TblSymbolCell
            cell?.lblCurrency.text = Array(dictTo.values)[indexPath.row]
            return cell ?? UITableViewCell()
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tblTo {
            self.btnTo.setTitle(Array(dictTo.keys)[indexPath.row], for: .normal)
            self.strSelectedTotext = Array(dictTo.keys)[indexPath.row]
        } else {
            self.btnFrom.setTitle(Array(dictFrom.keys)[indexPath.row], for: .normal)
            self.strSelectedFromtext = Array(dictFrom.keys)[indexPath.row]
        }
        self.callApi()
        self.removeTransparentView()
    }
    
}

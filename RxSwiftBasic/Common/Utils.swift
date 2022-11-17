//
//  Utils.swift
//  RxSwiftBasic
//
//  Created by Verve on 31/08/22.
//

import Foundation
import SVProgressHUD

class Utils {

    class func showProgressHud() {
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setForegroundColor(UIColor.blue)
        SVProgressHUD.setBackgroundColor(UIColor.clear)
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.setDefaultAnimationType(.flat)
        SVProgressHUD.setRingThickness(4)
        DispatchQueue.main.async {
            SVProgressHUD.show()
        }
    }

    class func hideProgressHud() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }

}

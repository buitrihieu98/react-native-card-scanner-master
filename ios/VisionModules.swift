//
//  VisionModules.swift
//  CardScanner
//
//  Created by buitrihieu on 28/10/2021.
//  Copyright © 2021 Facebook. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 13, *)
class VisionModules : CreditCardScannerViewControllerDelegate {
    let vc = UIApplication.shared.delegate?.window??.rootViewController
    var onSuccess: ([String : String]) -> ()
    var onFailed: ([String : String]) -> ()
    
    init(onSuccess: @escaping ([String : String]) -> (),
         onFailed: @escaping ([String : String]) -> ()) {
        self.onSuccess = onSuccess
        self.onFailed = onFailed
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startScanner() {
        let scanController = CreditCardScannerViewController(delegate: self)
        vc!.present(scanController, animated: true)
    }
    
    func creditCardScannerViewControllerDidCancel(_ viewController: CreditCardScannerViewController) {
        vc!.dismiss(animated: true)
    }
    
    func creditCardScannerViewController(_ viewController: CreditCardScannerViewController, didErrorWith error: CreditCardScannerError) {
        vc!.dismiss(animated: true) {
            print("\(error.errorDescription ?? "error")")
        }
    }
    
    func creditCardScannerViewController(_ viewController: CreditCardScannerViewController, didFinishWith card: CreditCard) {
        vc!.dismiss(animated: true) {
            self.onSuccess([
                "cardNumber": card.number ?? "",
                "cardHolder": card.name ?? "",
                "cardExpiredDate": card.expireDate != nil ? "\(self.getMonth(month: card.expireDate?.month))/\(self.getYear(year: card.expireDate?.year))" : "",
                "cardValidDate": card.validDate != nil ? "\(self.getMonth(month: card.validDate?.month))/\(self.getYear(year: card.validDate?.year))" : ""
            ])
        }
    }
    
    func getYear(year: Int?) -> String {
        if (year != nil) {
            return "\(year! - 2000)"
        }
        return ""
    }
    
    func getMonth(month: Int?) -> String {
        if month == nil {
            return ""
        }
        if month! < 10 && month! > 0 {
            return "0\(month!)"
        }
        if month! >= 10 {
            return "\(month!)"
        }
        return ""
    }
}

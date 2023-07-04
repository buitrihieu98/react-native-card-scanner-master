//
//  CardScannerModules.swift
//  CardScanner
//
//  Created by buitrihieu on 28/10/2021.
//  Copyright © 2021 Facebook. All rights reserved.
//

import Foundation
import UIKit

@objc(CardScannerModules)
class CardScannerModules : NSObject {
    
    @objc func startScanner(
        _ resolve: @escaping RCTPromiseResolveBlock,
        withRejecter reject: RCTPromiseRejectBlock
    ) {
        let onSuccess = { (result: [String : String]) in resolve(result)}
        let onFailed = { (error: [String : String]) in print("CardScannerModule Error: \(error)")}
        
        DispatchQueue.main.async {
            if #available(iOS 13.0, *) {
                let visionModule = VisionModules(onSuccess: onSuccess, onFailed: onFailed)
                visionModule.startScanner()
            } else {
                let vc = UIApplication.shared.delegate?.window??.rootViewController
                let payCardController = PayCardsModules(onSuccess: onSuccess, onFailed: onFailed)
                vc?.present(payCardController, animated: true)
            }
        }
    }
}

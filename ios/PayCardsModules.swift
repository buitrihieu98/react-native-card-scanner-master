//
//  CardScannerModules.swift
//  CardScanner
//
//  Created by buitrihieu on 28/10/2021.
//  Copyright © 2021 Facebook. All rights reserved.
//

import Foundation
import UIKit
import PayCardsRecognizer

class PayCardsModules : UIViewController, PayCardsRecognizerPlatformDelegate {
  func payCardsRecognizer(_ payCardsRecognizer: PayCardsRecognizer, didRecognize result: PayCardsRecognizerResult) {
    if !flag {
      flag = true
      dismiss(animated: true) {
        self.onSuccess([
          "cardNumber": result.recognizedNumber ?? "",
          "cardHolder": result.recognizedHolderName ?? "",
          "cardExpitedDate": "\(result.recognizedExpireDateMonth ?? "")/\(result.recognizedExpireDateYear ?? "")"
        ])
      }
    }
  }

  var recognizer: PayCardsRecognizer!
 var onSuccess: ([String : String]) -> ()
    var onFailed: ([String : String]) -> ()
  var flag = false

    init(onSuccess: @escaping ([String : String]) -> (),
         onFailed: @escaping ([String : String]) -> ()) {
    self.onSuccess = onSuccess
        self.onFailed = onFailed
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .black
    recognizer = PayCardsRecognizer(delegate: self, resultMode: .async, container: self.view, frameColor: .green)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    recognizer.startCamera(with: .portrait)
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    recognizer.stopCamera()
  }
}

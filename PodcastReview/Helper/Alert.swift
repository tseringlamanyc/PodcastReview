//
//  Alert.swift
//  PodcastReview
//
//  Created by Tsering Lama on 12/17/19.
//  Copyright © 2019 Tsering Lama. All rights reserved.
//

import UIKit

extension UIViewController {
  func showAlert(title: String, message: String, completion: ((UIAlertAction) -> Void)? = nil) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .default, handler: completion)
    alertController.addAction(okAction)
    present(alertController, animated: true, completion: nil)
  }
}

//
//  BaseViewController.swift
//  TwitterTask
//
//  Created by Reda on 02/05/2024.
//

import UIKit

class BaseViewController: UIViewController {
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.frame = .init(x: 0, y: 0, width: 80, height: 80)
        indicator.color = UIColor.lightGray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    func startLoading() {
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        activityIndicator.removeFromSuperview()
        activityIndicator.stopAnimating()
    }
}

extension UIViewController {
    func showAlert(_ vc: UIViewController, message: String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        vc.present(alertController, animated: true, completion: nil)
      }
}

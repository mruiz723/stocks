//
//  BaseViewController.swift
//  Stocks
//
//  Created by Marlon David Ruiz Arroyave on 16/10/21.
//

import UIKit
import SVProgressHUD

class BaseViewController: UIViewController, Storyboarded {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension BaseViewController: AlertProtocol {

    func showAlert(msg: String, actions: [UIAlertAction]? = nil) {
        let alert = UIAlertController(title: Constants.AlertTitle.stock, message: msg, preferredStyle: UIAlertController.Style.alert)

        if let actions = actions {
            actions.forEach { alert.addAction($0) }
        } else {
            alert.addAction(UIAlertAction(title: Constants.ActionTitle.ok, style: UIAlertAction.Style.default, handler: nil))
        }

        present(alert, animated: true, completion: nil)
    }

    func shouldShowLoader(_ shouldShow: Bool) {
        shouldShow ? SVProgressHUD.show() : SVProgressHUD.dismiss()
    }
}

//
//  CommonProtocols.swift
//  CV_Builder_App
//
//  Created by Mangesh on 09/09/21.
//

import UIKit

protocol Localizable {
    var localized: String { get }
}

protocol XIBLocalizable {
    var xibLocKey: String? { get set }
}

protocol AlertDisplayProtocol: UIViewController {
    func displayAlert(message: String, context: UIViewController)
}

extension AlertDisplayProtocol {
    func displayAlert(message: String, context: UIViewController) {
        let alert = UIAlertController(title: nil, message: message.localized, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok".localized, style: .cancel, handler: nil)
        alert.addAction(action)
        context.present(alert, animated: false, completion: nil)
    }
}


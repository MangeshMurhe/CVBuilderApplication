//
//  UIVIewExtension.swift
//  CV_Builder_App
//
//  Created by Mangesh on 06/09/21.
//
import UIKit

extension UIView {
    @IBInspectable var circularRoundedCorner: Bool {
        get {
            self.circularRoundedCorner
        }
        set {
            if newValue {
                self.layer.cornerRadius = frame.width/2
            }
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            self.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    func showBorder(borderWidth:CGFloat) {
        self.layer.borderWidth = borderWidth
    }
}

extension UILabel: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            text = key?.localized
        }
    }
}

extension UIButton: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            setTitle(key?.localized, for: .normal)
        }
   }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}

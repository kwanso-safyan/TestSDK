//
//  SSOButton.swift
//  TestSDK
//
//  Created by kwanso-ios on 5/9/19.
//  Copyright © 2019 kwanso-ios. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable public class RoundedButton: UIButton {
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    //Normal state bg and border
    @IBInspectable var normalBorderColor: UIColor? {
        didSet {
            layer.borderColor = normalBorderColor?.cgColor
        }
    }
    
    @IBInspectable var normalBackgroundColor: UIColor? {
        didSet {
            setBgColorForState(color: normalBackgroundColor, forState: .normal)
        }
    }
    
    
    //Highlighted state bg and border
    @IBInspectable var highlightedBorderColor: UIColor?
    
    @IBInspectable var highlightedBackgroundColor: UIColor? {
        didSet {
            setBgColorForState(color: highlightedBackgroundColor, forState: .highlighted)
        }
    }
    
    
    private func setBgColorForState(color: UIColor?, forState: UIControl.State){
        if color != nil {
            setBgColorForState(color: color, forState: forState)
        } else {
            setBgColorForState(color: nil, forState: forState)
        }
    }
    
    func loadSSOButton() -> UIButton
    {
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button.backgroundColor = .green
        button.setTitle("Test Button", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }
    
    @objc func buttonTapped(sender: UIButton) {
        
        print("Button tapped")
    }
    
}

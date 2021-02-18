//
//  Extensions.swift
//  SwiftMotorcycles
//
//  Created by Jonas Frid on 2021-02-18.
//  Copyright © 2021 Jonas Frid. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func validate(validator: (String) -> Bool) -> Bool {
        let isValid = validator(self.text ?? "")
        
        if isValid {
            self.rightViewMode = .never
            self.rightView = nil
        } else {
            self.rightViewMode = .always
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 12))
            
            view.backgroundColor = UIColor.red
            view.layer.cornerRadius = 6
            
            self.rightView = view
        }
        
        return isValid
    }
}

extension String {
    func toIntOrZero() -> Int {
        if let v = Int(self) {
            return v
        }
        
        return 0
    }
}

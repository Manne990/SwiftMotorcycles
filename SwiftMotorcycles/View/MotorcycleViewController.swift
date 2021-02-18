//
//  MotorcycleViewController.swift
//  SwiftMotorcycles
//
//  Created by Jonas Frid on 2021-02-18.
//  Copyright © 2021 Jonas Frid. All rights reserved.
//

import UIKit

protocol DismissProtocol {
    func didDismiss()
}

class MotorcycleViewController: UIViewController {
    var viewModel: EditMotorcycleViewModelProtocol?
    var payloadId: String?
    var didDismissDelegate: DismissProtocol?
    
    @IBOutlet weak var brandTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let mc = viewModel?.motorcycle else {
            return
        }
        
        let isValid =
            brandTextField.validate { v in return v.count >= 2 } &&
            modelTextField.validate { v in return v.count >= 2 } &&
            yearTextField.validate { v in return (1901...2099).contains(v.toIntOrZero()) }
        
        if (!isValid) {
            return
        }

        mc.brand = brandTextField?.text ?? ""
        mc.model = modelTextField?.text ?? ""
        mc.year = Int(yearTextField?.text ?? "0") ?? 0
        
        viewModel?.saveMotorcycle(completion: { (success) in
            self.dismiss(animated: true) {
                self.didDismissDelegate?.didDismiss()
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.initWithPayload(payloadId: self.payloadId)
        
        viewModel?.propertyChanged = { (propertyName) in
            switch propertyName {
            case "motorcycle":
                guard let mc = self.viewModel?.motorcycle else {
                    self.brandTextField.text = ""
                    self.modelTextField.text = ""
                    self.yearTextField.text = ""
                    return
                }
                
                self.brandTextField.text = mc.brand
                self.modelTextField.text = mc.model
                self.yearTextField.text = String(mc.year)
            default:
                return
            }
        }
    }    
}

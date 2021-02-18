//
//  MotorcycleViewController.swift
//  SwiftMotorcycles
//
//  Created by Jonas Frid on 2021-02-18.
//  Copyright © 2021 Jonas Frid. All rights reserved.
//

import UIKit

class MotorcycleViewController: UIViewController {
    var viewModel: EditMotorcycleViewModelProtocol?
    var payloadId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MotorcycleViewController: \(payloadId)")
        
//        viewModel?.propertyChanged = { (propertyName) in
//            switch propertyName {
//            case "motorcycles":
//                self.tableView.reloadData()
//            default:
//                return
//            }
//        }
//
//        viewModel?.loadMotorcycles()
    }    
}

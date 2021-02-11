//
//  ViewController.swift
//  SwiftMotorcycles
//
//  Created by Jonas Frid on 2019-02-27.
//  Copyright © 2019 Jonas Frid. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ws = WebService()
        ws.getMotorcycles{ (result) in
            guard result.success else {
                return
            }
            
            if let mc = result.data?[0] {
                print("Done!")
                print(mc.brand)
            }
        }
    }
}

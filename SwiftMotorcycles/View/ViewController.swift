//
//  ViewController.swift
//  SwiftMotorcycles
//
//  Created by Jonas Frid on 2019-02-27.
//  Copyright © 2019 Jonas Frid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let empty = EmptyContainer(success: true)
        print(empty.success)
        
        let mc = MotorcycleContainer(success: true, data: Motorcycle(objectId: "1", brand: "Yamaha", model: "R1", year: 2007))
        print(mc.success)
        
        if let data = mc.data {
            print(data.toString())
        }
        
        let mcs = MotorcyclesContainer(success: true, data: [Motorcycle(objectId: "2", brand: "KTM", model: "625 SuperComp", year: 2002)])
        
        print(mcs.success)
        
        if let data = mcs.data {
            print(data[0].toString())
        }
    }
}

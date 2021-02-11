//
//  MotorcyclesViewController.swift
//  SwiftMotorcycles
//
//  Created by Jonas Frid on 2021-02-11.
//  Copyright © 2021 Jonas Frid. All rights reserved.
//

import UIKit

class MotorcyclesViewController: UITableViewController {
    private var viewModel: MotorcyclesViewModelProtocol = MotorcyclesViewModel(ws: WebService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.propertyChanged = { (propertyName) in
            switch propertyName {
            case "motorcycles":
                self.tableView.reloadData()
            default:
                return
            }
        }
        
        viewModel.loadMotorcycles()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let items = viewModel.motorcycles {
            return items.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "motorcycleCellId", for: indexPath)

        if let item = viewModel.motorcycles?[indexPath.row] {
            cell.textLabel!.text = "\(item.brand) \(item.model) (\(item.year))"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = viewModel.motorcycles?[indexPath.row] {
            print("Tapped on item: \(item.brand) \(item.model) (\(item.year))")
        }
    }
}

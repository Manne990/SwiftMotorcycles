//
//  MotorcyclesViewController.swift
//  SwiftMotorcycles
//
//  Created by Jonas Frid on 2021-02-11.
//  Copyright © 2021 Jonas Frid. All rights reserved.
//

import UIKit

class MotorcyclesViewController: UITableViewController, UIAdaptivePresentationControllerDelegate, DismissProtocol {
    var viewModel: MotorcyclesViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        viewModel?.propertyChanged = { (propertyName) in
            switch propertyName {
            case "motorcycles":
                self.tableView.reloadData()
            default:
                return
            }
        }
        
        viewModel?.loadMotorcycles()
    }
    
    @IBAction func refreshControlValueChanged(_ sender: UIRefreshControl) {
        viewModel?.loadMotorcycles()
        sender.endRefreshing()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextVc = segue.destination as? MotorcycleViewController else {
            return
        }
        
        segue.destination.presentationController?.delegate = self
        
        if segue.identifier == "editMotorcycle" {
            if let item = viewModel?.motorcycles?[self.tableView.indexPathForSelectedRow?.row ?? 0] {
                nextVc.didDismissDelegate = self
                nextVc.payloadId = item.objectId
            }
        }
    }
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        viewModel?.loadMotorcycles()
    }
    
    func didDismiss() {
        viewModel?.loadMotorcycles()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let items = viewModel?.motorcycles {
            return items.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "motorcycleCellId", for: indexPath)

        if let item = viewModel?.motorcycles?[indexPath.row] {
            cell.textLabel!.text = "\(item.brand) \(item.model) (\(item.year))"
        }
        
        return cell
    }
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "editMotorcycle", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let item = viewModel?.motorcycles?[indexPath.row] {
                viewModel?.deleteMotorcycle(motorcycle: item)
            }
        }
    }
}

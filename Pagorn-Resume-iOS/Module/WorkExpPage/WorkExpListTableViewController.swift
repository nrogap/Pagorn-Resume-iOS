//
//  WorkExpTableViewController.swift
//  Pagorn-Resume-iOS
//
//  Created by Pagorn Petchnukulkait on 11/19/2560 BE.
//  Copyright © 2560 plagorn. All rights reserved.
//

import UIKit

import PKHUD

class WorkExpListTableViewController: UITableViewController {
    
    lazy var viewModel: WorkExpListViewModel = {
        return WorkExpListViewModel(apiService: APIService())
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        
        initVM()
    }
    
    func initView() {
        self.tableView.estimatedRowHeight = 230
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func initVM() {
        
        viewModel.showAlertClosure = {
            [weak self] () in DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert(message)
                }
            }
        }
        
        viewModel.updateLoadingStatus = {
            [weak self] () in DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    HUD.show(.progress)
                    UITableView.animate(withDuration: 0.2, animations: {
                        self?.tableView.alpha = 0.0
                    })
                }else {
                   HUD.hide()
                    UITableView.animate(withDuration: 0.2, animations: {
                        self?.tableView.alpha = 1.0
                    })
                }
            }
        }
        
        viewModel.reloadTableViewClosure = {
            [weak self] () in DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    func showAlert(_ message: String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "workExpCellIdentifier", for: indexPath) as? WorkExpListTableViewCell else {
            fatalError("Cell not exist in storyboard")
        }
        
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        
        cell.labelCompany.text = cellVM.textCompany
        cell.labelDate.text = cellVM.textDate
        cell.labelEvent.text = cellVM.textEvent
        cell.labelPosition.text = cellVM.textPosition
        cell.viewSideCard.backgroundColor = cellVM.colorSideCard
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230.0
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

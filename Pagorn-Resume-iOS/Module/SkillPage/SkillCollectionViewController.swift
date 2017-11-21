//
//  SkillCollectionViewController.swift
//  Pagorn-Resume-iOS
//
//  Created by Pagorn Petchnukulkait on 11/19/2560 BE.
//  Copyright © 2560 plagorn. All rights reserved.
//

import UIKit

import PKHUD

private let reuseIdentifier = "Cell"

class SkillCollectionViewController: UICollectionViewController {
    
    fileprivate let itemsPerRow: CGFloat = 2
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 25.0, left: 20.0, bottom: 20.0, right: 20.0)
    
    lazy var viewModel: SkillViewModel = {
        return SkillViewModel(apiService: APIService())
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        
        initVM()
    }
    
    func test() {
        //        progressRing.value = 50
    }
    
    func initView() {
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
    }
    
    func initVM() {
        viewModel.showAlertClosure = {
            [weak self] () in DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert(message)
                }
            }
        }
        
        viewModel.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    HUD.show(.progress)
                    UICollectionView.animate(withDuration: 0.2, animations: {
                        self?.collectionView?.alpha = 0.0
                    })
                }else {
                    HUD.hide()
                    UICollectionView.animate(withDuration: 0.2, animations: {
                        self?.collectionView?.alpha = 1.0
                    })
                }
            }
        }
        
        viewModel.reloadCollectionViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.collectionView?.reloadData()
            }
        }
        
    }
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return viewModel.numberOfCells
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "skillCellIdentifier", for: indexPath) as? SkillCollectionViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        
        let cellVM = viewModel.getCellViewModel(at: indexPath)
    
        cell.labelDetail.text = cellVM.detail
        cell.labelName.text = cellVM.name
        cell.viewCircularProgress.value = CGFloat(cellVM.star)
        
        
        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        // Configure the cell
        
        return cell
    }
    
   
}

extension SkillCollectionViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        var cellHeight: CGFloat = 0
        
        if view.frame.height > 700 {
            cellHeight = (view.frame.height - paddingSpace) / (itemsPerRow + 2)
        } else {
            cellHeight = (view.frame.height - paddingSpace) / (itemsPerRow + 1)
        }

        
        return CGSize(width: widthPerItem, height: cellHeight)
    }
    

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

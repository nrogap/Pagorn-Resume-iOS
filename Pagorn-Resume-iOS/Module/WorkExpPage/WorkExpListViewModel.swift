//
//  WorkExpListViewModel.swift
//  Pagorn-Resume-iOS
//
//  Created by Pagorn Petchnukulkait on 11/19/2560 BE.
//  Copyright © 2560 plagorn. All rights reserved.
//

import UIKit

class WorkExpListViewModel {
    
    let apiService: APIServiceProtocal
    
    private var workExps: [WorkExperience] = [WorkExperience]()
    
    private var cellViewModels: [WorkExpListCellViewModel] = [WorkExpListCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    var isAllowSegue: Bool = false
    
    var selectedWorkExp: WorkExperience?
    
    var reloadTableViewClosure: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?
    
    init(apiService: APIServiceProtocal) {
        self.apiService = apiService
        initFetch()
    }
    
    func initFetch() {
        self.isLoading = true
        apiService.fetchWorkExperience { [weak self] (success, workExps, error) in
            self?.processFetchWorkExp(workExps: workExps)
            self?.isLoading = false
        }
    }
    
    func processFetchWorkExp(workExps: [WorkExperience]) {
        self.workExps = workExps
        var vms = [WorkExpListCellViewModel]()
        for workExp in workExps {
            vms.append(createCellViewModel(workExp: workExp))
        }
        self.cellViewModels = vms
    }
    
    func createCellViewModel(workExp: WorkExperience) -> WorkExpListCellViewModel {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        var dateContainer: [String] = [String]()

        let startDate = dateFormatter.string(from: workExp.start_date)
        let endDate = dateFormatter.string(from: workExp.end_date)

        dateContainer.append(startDate)
        dateContainer.append(endDate)

        let textDate = dateContainer.joined(separator: " - ")
        
        let event = workExp.event ?? ""
        
        return WorkExpListCellViewModel(textDate: textDate,
                                           textCompany: workExp.company,
                                           textEvent: event,
                                           textPosition: workExp.position,
                                           colorSideCard: UIColor.random())
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> WorkExpListCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}

struct WorkExpListCellViewModel {
    let textDate: String
    let textCompany: String
    let textEvent: String
    let textPosition: String
    let colorSideCard: UIColor
}

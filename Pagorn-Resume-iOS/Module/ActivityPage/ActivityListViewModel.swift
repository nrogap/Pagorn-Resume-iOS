//
//  ActivityListViewModel.swift
//  Pagorn-Resume-iOS
//
//  Created by Pagorn Petchnukulkait on 11/17/2560 BE.
//  Copyright © 2560 plagorn. All rights reserved.
//

import Foundation

class ActivityListViewModel {
    
    let apiService: APIServiceProtocal
    
    private var activities: [Activity] = [Activity]()
    
    private var cellViewModels: [ActivityListCellViewModel] = [ActivityListCellViewModel]() {
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
    
    var selectedActivity: Activity?
    
    var reloadTableViewClosure: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?
    
    init(apiService: APIServiceProtocal){
        self.apiService = apiService
        initFetch()
    }
    
    func initFetch() {
        self.isLoading = true
        apiService.fetchActivity { [weak self] (success, activities, error) in
            self?.processFetchedActivity(activities: activities)
            self?.isLoading = false
        }
    }
    
    func processFetchedActivity(activities: [Activity]) {
        self.activities = activities //Cache
        var vms = [ActivityListCellViewModel]()
        for activity in activities {
            vms.append(createCellViewModel(activity: activity))
        }
        self.cellViewModels = vms
    }
    
    func createCellViewModel(activity: Activity) -> ActivityListCellViewModel {
        
        //format data before sent to present
        
        let round: String = activity.round ?? ""
        
        return ActivityListCellViewModel(textTitle: activity.name,
                                         textRound: round,
                                         textDescription: activity.description,
                                         urlImage: activity.cover_url)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> ActivityListCellViewModel {
        return cellViewModels[indexPath.row]
    }
}

extension ActivityListViewModel {
    func userPressed(at indexPath:IndexPath) {
        let activity = self.activities[indexPath.row]
        self.selectedActivity = activity
        
        self.alertMessage = "Coming Soon"
    }
}

struct ActivityListCellViewModel {
    let textTitle: String
    let textRound: String
    let textDescription: String
    let urlImage: String
}

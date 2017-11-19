//
//  SkillViewModel.swift
//  Pagorn-Resume-iOS
//
//  Created by Pagorn Petchnukulkait on 11/19/2560 BE.
//  Copyright © 2560 plagorn. All rights reserved.
//

import Foundation

class SkillViewModel {
    
    var apiService: APIServiceProtocal
    
    var skills: [Skill] = [Skill]()
    
    var cellViewModels: [SkillCellViewModel] = [SkillCellViewModel]() {
        didSet {
            self.reloadCollectionViewClosure?()
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
    
    var selectedSkill: Skill?
    
    var reloadCollectionViewClosure: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?
    
    init(apiService: APIServiceProtocal) {
        self.apiService = apiService
        initFetch()
    }
    
    func initFetch() {
        self.isLoading = true
        apiService.fetchSkill { [weak self] (success, skills, error) in
            self?.processFetchSkill(skills: skills)
            self?.isLoading = false
        }
    }
    
    func processFetchSkill(skills: [Skill])  {
        self.skills = skills // Cache
        var vms = [SkillCellViewModel]()
        for skill in skills {
            vms.append( createCellViewModel(skill: skill) )
        }
        self.cellViewModels = vms
    }
    
    func createCellViewModel(skill: Skill) -> SkillCellViewModel {
        
        let detail: String = skill.detail ?? ""
        
        let star: Int = skill.star * 10
        
        return SkillCellViewModel(id: skill.id, name: skill.name, detail: detail, star: star)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> SkillCellViewModel {
        return cellViewModels[indexPath.item]
    }
    
    
}

struct SkillCellViewModel {
    let id: Int
    let name: String
    let detail: String
    let star: Int
}

//
//  APIService.swift
//  MVVM-Prung
//
//  Created by Pagorn Petchnukulkait on 11/8/2560 BE.
//  Copyright © 2560 plagorn. All rights reserved.
//

import Foundation

protocol APIServiceProtocal {

    func fetchWorkExperience(complete: @escaping (_ success: Bool, _ workExperience:[WorkExperience], _ error:Error?)->() )
    
    func fetchActivity(complete: @escaping (_ success: Bool, _ activity:[Activity], _ error:Error?) -> ())
    
    func fetchSkill(complete: @escaping (_ success:Bool, _ skill:[Skill], _ error:Error?) -> ())
    
}

class APIService: APIServiceProtocal {
    
    func fetchSkill(complete: @escaping (Bool, [Skill], Error?) -> ()) {
        DispatchQueue.global().async {
            sleep(3)
            let path = Bundle.main.path(forResource: "skill", ofType: "json")!
            let data = try! Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let skills = try! decoder.decode(Skills.self, from: data)
            complete(true, skills.results, nil)
        }
    }
    
    
    func fetchActivity(complete: @escaping (Bool, [Activity], _ error: Error?) -> ()) {
        
        DispatchQueue.global().async {
            sleep(3)
            let path = Bundle.main.path(forResource: "activity", ofType: "json")!
            let data = try! Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let activities = try! decoder.decode(Activities.self, from: data)
            complete(true, activities.results, nil)
        }
    }
    
    func fetchWorkExperience(complete: @escaping (Bool, [WorkExperience], Error?) -> ()) {
        
        DispatchQueue.global().async {
            sleep(3)
            let path = Bundle.main.path(forResource: "work_experience", ofType: "json")!
            let data = try! Data(contentsOf:URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let workExperiences = try! decoder.decode(WorkExperiences.self, from: data)
            complete(true, workExperiences.results, nil)
        }
    }
    
   
    
    
    
}

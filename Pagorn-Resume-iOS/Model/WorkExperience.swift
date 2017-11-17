//
//  WorkExperience.swift
//  Pagorn-Resume-iOS
//
//  Created by Pagorn Petchnukulkait on 11/15/2560 BE.
//  Copyright © 2560 plagorn. All rights reserved.
//

import Foundation

struct WorkExperiences: Codable {
    let results: [WorkExperience]
}

struct WorkExperience: Codable {
    let id:Int
    let company: String
    let position: String
    let event: String?
    let start_date: Date
    let end_date: Date
}

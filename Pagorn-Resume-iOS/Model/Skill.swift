//
//  ProgrammingAndTechnicalSkill.swift
//  Pagorn-Resume-iOS
//
//  Created by Pagorn Petchnukulkait on 11/15/2560 BE.
//  Copyright © 2560 plagorn. All rights reserved.
//

import Foundation

struct Skills: Codable {
    let results: [Skill]
}

struct Skill: Codable {
    let id: Int
    let name: String
    let detail: String?
    let start: Int
}

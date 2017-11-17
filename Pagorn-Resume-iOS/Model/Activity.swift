//
//  Activity.swift
//  Pagorn-Resume-iOS
//
//  Created by Pagorn Petchnukulkait on 11/15/2560 BE.
//  Copyright © 2560 plagorn. All rights reserved.
//

import Foundation

struct Activities: Codable {
    let results: [Activity]
}

struct Activity: Codable {
    let id: Int
    let name: String
    let description: String
}

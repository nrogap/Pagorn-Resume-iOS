//
//  SkillCollectionViewCell.swift
//  Pagorn-Resume-iOS
//
//  Created by Pagorn Petchnukulkait on 11/19/2560 BE.
//  Copyright © 2560 plagorn. All rights reserved.
//

import UIKit
import UICircularProgressRing

class SkillCollectionViewCell: UICollectionViewCell, UICircularProgressRingDelegate {
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDetail: UILabel!
    @IBOutlet weak var viewCircularProgress: UICircularProgressRingView!
    
    
    func finishedUpdatingProgress(forRing ring: UICircularProgressRingView) {
        
    }
}

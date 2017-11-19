//
//  HomeViewController.swift
//  Pagorn-Resume-iOS
//
//  Created by Pagorn Petchnukulkait on 11/19/2560 BE.
//  Copyright © 2560 plagorn. All rights reserved.
//

import UIKit

import SDWebImage

class HomeViewController: UIViewController {
    
    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var labelFullName: UILabel!
    @IBOutlet weak var labelPosition: UILabel!
    @IBOutlet weak var stackViewLocation: UIStackView!
    @IBOutlet weak var labelLocation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initView()
    }
    
    func initView(){
        
        self.imageViewProfile.layer.cornerRadius = 20.0
        self.imageViewProfile.clipsToBounds = true

        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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



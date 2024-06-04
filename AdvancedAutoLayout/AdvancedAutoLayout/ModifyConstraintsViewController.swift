//
//  ModifyConstraintsViewController.swift
//  AdvancedAutoLayout
//
//  Created by Brais Moure on 26/04/2020.
//  Copyright © 2020 MoureDev. All rights reserved.
//

import UIKit

class ModifyConstraintsViewController: UIViewController {
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        heightConstraint.constant = 300
        
        topConstraint.constant = 64
    }

}

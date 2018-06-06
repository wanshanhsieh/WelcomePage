//
//  PageItemController.swift
//  WelcomePage
//
//  Created by sandra on 2018/5/29.
//  Copyright © 2018年 sandra. All rights reserved.
//

import Foundation
import UIKit

class PageItemController: UIViewController {
    
    var itemIndex: Int = 0
    var imageName: String = ""{
        didSet {
            if let imageView = contentImageView {
                imageView.image = UIImage(named: imageName)
            }
        }
    }
    @IBOutlet weak var contentImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentImageView.image = UIImage(named: imageName)
    }
    
}

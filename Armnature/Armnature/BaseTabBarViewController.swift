//
//  BaseTabBarViewController.swift
//  Armnature
//
//  Created by Arthur on 6/11/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import UIKit
import RxSwift

class BaseTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
}

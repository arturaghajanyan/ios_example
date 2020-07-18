//
//  FileUIStoryboard+Instantiate.swift
//  Armnature
//
//  Created by Arthur on 6/27/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import UIKit

extension UIStoryboard {
    func instantiateInitialViewController<VC: UIViewController>(file: StaticString = #file, line: UInt = #line) -> VC {
        guard let vc = instantiateInitialViewController() as? VC else {
            preconditionFailure("Attempted to instantiate view controller as \(String(describing: VC.self)) but failed", file: file, line: line)
        }
        return vc
    }
    
    func instantiateViewController<VC: UIViewController>(withIdentifier identifier: String, file: StaticString = #file, line: UInt = #line) -> VC {
        guard let vc = instantiateViewController(withIdentifier: identifier) as? VC else {
            preconditionFailure("Attempted to instantiate view controller as \(String(describing: VC.self)) but failed", file: file, line: line)
        }
        return vc
    }
}

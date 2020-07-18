//
//  ViewExtension.swift
//  Armnature
//
//  Created by Arthur on 6/28/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import UIKit

extension UIView {
    public func pinToEdges(of view: UIView, padding: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor, constant: padding).isActive = true
        leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding).isActive = true
    }
}

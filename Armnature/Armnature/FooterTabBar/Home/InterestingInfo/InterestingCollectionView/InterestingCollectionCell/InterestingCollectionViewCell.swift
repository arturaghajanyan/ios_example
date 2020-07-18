//
//  InterestingCollectionViewCell.swift
//  Armnature
//
//  Created by Arthur on 6/27/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class InterestingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private var infoImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var viewModel: InterestingViewModel!
    private let disposeBag = DisposeBag()
    
    public func configure(with viewModel: InterestingViewModel) {
        self.viewModel = viewModel
        bindOutput()
    }
    
    private func bindOutput() {
        viewModel.output.descriptionText
            .drive(descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.infoImage
            .drive(infoImageView.rx.image)
            .disposed(by: disposeBag)
    }
    
}

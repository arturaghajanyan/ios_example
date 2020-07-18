//
//  InterestingToVisitCollectionViewCell.swift
//  Armnature
//
//  Created by Arthur on 6/28/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class InterestingToVisitCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private var infoImageView: UIImageView!
    @IBOutlet weak var titleInfoLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var contentImageView: UIView!
    
    var viewModel: InterestingToVisitCellViewModel!
    private let disposeBag = DisposeBag()
    
    public func configure(with viewModel: InterestingToVisitCellViewModel) {
        self.viewModel = viewModel
        self.addStyleForImage(imageViewElement: self.contentImageView)
        bindOutput()
    }
    
    private func bindOutput() {
        viewModel.output.titleText
            .drive(titleInfoLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.descriptionText
            .drive(descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.infoImage
            .drive(infoImageView.rx.image)
            .disposed(by: disposeBag)
    }
    
    func addStyleForImage(imageViewElement: UIView) {
        imageViewElement.layer.cornerRadius = 25.0
        imageViewElement.clipsToBounds = true
        self.infoImageView.layer.cornerRadius = 25.0
        self.infoImageView.clipsToBounds = true
    }
    
}

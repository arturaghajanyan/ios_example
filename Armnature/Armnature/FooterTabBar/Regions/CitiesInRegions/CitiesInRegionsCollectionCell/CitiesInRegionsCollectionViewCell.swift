//
//  CitiesInRegionsCollectionViewCell.swift
//  Armnature
//
//  Created by Arthur on 7/4/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CitiesInRegionsCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var contentImageView: UIView!
    @IBOutlet weak var provinceName: UILabel!
    
    var viewModel: CitiesInRegionsCellViewModel!
    private let disposeBag = DisposeBag()
    
    private var provinceImageViewGesture = UITapGestureRecognizer()

    public func configure(with viewModel: CitiesInRegionsCellViewModel) {
        self.viewModel = viewModel
        imageView.addGestureRecognizer(provinceImageViewGesture)
        imageView.isUserInteractionEnabled = true
        self.addStyleForImage(imageViewElement: self.contentImageView)
        bindOutput()
        bindInput()
    }
    
    private func bindOutput() {
        viewModel.output.titleText
            .drive(provinceName.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.provinceImage
            .drive(imageView.rx.image)
            .disposed(by: disposeBag)
        
        viewModel.output.playProvince
            .emit(onNext: { province in
                print(province)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindInput() {
        provinceImageViewGesture.rx.event
            .mapTo(())
            .bind(to: viewModel.input.playProvince)
            .disposed(by: disposeBag)
    }
    
    func addStyleForImage(imageViewElement: UIView) {
        imageViewElement.layer.cornerRadius = 25.0
        imageViewElement.clipsToBounds = true
        imageViewElement.layer.shadowColor = UIColor.darkGray.cgColor
        imageViewElement.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        imageViewElement.layer.shadowRadius = 25.0
        imageViewElement.layer.shadowOpacity = 0.5
        self.imageView.layer.cornerRadius = 25.0
        self.imageView.clipsToBounds = true
    }
}

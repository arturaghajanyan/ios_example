//
//  RegionTableViewCell.swift
//  Armnature
//
//  Created by Arthur on 6/21/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import RxSwift
import RxCocoa

class RegionTableViewCell: UITableViewCell {

    @IBOutlet weak var provinceCapitalImage: UIImageView!
    @IBOutlet weak var provinceName: UILabel!
    @IBOutlet weak var provinceCapitalName: UILabel!
    @IBOutlet weak var provinceArea: UILabel!
    @IBOutlet weak var provincePopulation: UILabel!

    var viewModel: RegionCellViewModel!
    private let disposeBag = DisposeBag()

    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
    }

    func configure(with viewModel: RegionCellViewModel) {
        self.viewModel = viewModel
        self.provinceCapitalImage.dropShadow(color: UIColor.black.cgColor)
        bindOutput()
    }

    private func bindOutput() {
        viewModel.output.name
            .drive(provinceName.rx.text)
            .disposed(by: disposeBag)

        viewModel.output.capital
            .drive(provinceCapitalName.rx.text)
            .disposed(by: disposeBag)

        viewModel.output.area
            .drive(provinceArea.rx.text)
            .disposed(by: disposeBag)

        viewModel.output.population
            .drive(provincePopulation.rx.text)
            .disposed(by: disposeBag)

        viewModel.output.provinceImage
            .drive(provinceCapitalImage.rx.image)
            .disposed(by: disposeBag)
    }

}

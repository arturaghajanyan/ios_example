//
//  InterestingToVisitTableViewCell.swift
//  Armnature
//
//  Created by Arthur on 6/28/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources

class InterestingToVisitTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet private var interestingViewControllerHolderView: UIView!

    var collectionViewController: InterestingToVisitCollectionViewController?

    private var viewModel: InterestingToVisitTableCellViewModel!
    private var disposeBag = DisposeBag()

    override func awakeFromNib() {
       super.awakeFromNib()
    }

    override func prepareForReuse() {
       disposeBag = DisposeBag()

       super.prepareForReuse()
    }
    
    private lazy var dataSource = RxCollectionViewSectionedReloadDataSource<InterestingToVisitTableCellViewModel.SectionModel>(
        configureCell: { _, collectionView, indexPath, item in
            let cell: InterestingToVisitCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.viewModel = InterestingToVisitCellViewModel(infoObject: item)
            cell.configure(with: cell.viewModel)
            return cell
    })
    

    func configure(with viewModel: InterestingToVisitTableCellViewModel) {
        self.viewModel = viewModel
        guard let collectionViewController = self.collectionViewController else { return }
        interestingViewControllerHolderView.subviews.forEach { $0.removeFromSuperview() }
        interestingViewControllerHolderView.addSubview(collectionViewController.view)
        collectionViewController.view.pinToEdges(of: interestingViewControllerHolderView)
        collectionViewController.configure(with: collectionViewController.viewModel)
        bindOutput()
    }

    private func bindOutput() {
        viewModel.output.descriptionText
            .drive(descriptionLabel.rx.text)
            .disposed(by: disposeBag)
    }

}

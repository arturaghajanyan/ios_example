//
//  InterestingInfoTableViewCell.swift
//  Armnature
//
//  Created by Arthur on 6/27/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources

class InterestingInfoTableViewCell: UITableViewCell {

    @IBOutlet private var interestingViewControllerHolderView: UIView!

    var collectionViewController: InterestingCollectionViewController?

    private var viewModel: InterestingInfoCellViewModel!
    private var disposeBag = DisposeBag()

    override func prepareForReuse() {
       disposeBag = DisposeBag()

       super.prepareForReuse()
    }
    
    private lazy var dataSource = RxCollectionViewSectionedReloadDataSource<InterestingInfoCellViewModel.SectionModel>(
        configureCell: { _, collectionView, indexPath, item in
            let cell: InterestingCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.viewModel = InterestingViewModel(infoObject: item)
            cell.configure(with: cell.viewModel)
            return cell
    })

    func configure(with viewModel: InterestingInfoCellViewModel) {
        self.viewModel = viewModel
        guard let collectionViewController = self.collectionViewController else { return }
        interestingViewControllerHolderView.subviews.forEach { $0.removeFromSuperview() }
        interestingViewControllerHolderView.addSubview(collectionViewController.view)
        collectionViewController.view.pinToEdges(of: interestingViewControllerHolderView)
        collectionViewController.configure(with: collectionViewController.viewModel)
    }

}


//
//  InterestingCollectionViewController.swift
//  Armnature
//
//  Created by Arthur on 6/27/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import RxDataSources
import RxSwift
import RxCocoa

class InterestingCollectionViewController: UIViewController {

    @IBOutlet private var collectionView: UICollectionView!
    private lazy var collectionViewCellSize: CGSize = calculateCellSize()

    var viewModel: InterestingCollectionViewModel!
    private let disposeBag = DisposeBag()
    
    private lazy var dataSource = RxCollectionViewSectionedReloadDataSource<InterestingCollectionViewModel.SectionModel>(
        configureCell: { _, collectionView, indexPath, item in
            let cell: InterestingCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.viewModel = InterestingViewModel(infoObject: item)
            cell.configure(with: cell.viewModel)
            return cell
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.viewModel != nil {
            bindOutput()
        }
    }

    func configure(with viewModel: InterestingCollectionViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        collectionViewCellSize = CGSize.zero
    }

    private func bindOutput() {
        viewModel.output.sections
            .drive(collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }

    private func calculateCellSize() -> CGSize {
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
             else { return CGSize.zero }
        
        let isLandscape = collectionView.bounds.width > collectionView.bounds.height
        let numberOfColumns = CGFloat(isLandscape ? 3 : 2)
        let interitemSpacing = flowLayout.minimumInteritemSpacing
        let leftInset = flowLayout.sectionInset.left
        let rightInset = flowLayout.sectionInset.right
        let totalSpacing = leftInset + rightInset + interitemSpacing * (numberOfColumns - 1)
        let cellWidth = (collectionView.bounds.width - totalSpacing) / numberOfColumns
        let cellHeight = cellWidth * 2 / 3

        return CGSize(width: cellWidth, height: cellHeight)
    }

}

extension InterestingCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionViewCellSize == CGSize.zero) { collectionViewCellSize = calculateCellSize() }
        return collectionViewCellSize
    }
}

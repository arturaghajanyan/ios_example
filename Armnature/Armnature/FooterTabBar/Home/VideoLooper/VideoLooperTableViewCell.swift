//
//  VideoLooperTableViewCell.swift
//  Armnature
//
//  Created by Arthur on 6/27/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import RxSwift
import RxCocoa
import AVFoundation

class VideoLooperTableViewCell: UITableViewCell {
    weak var timer: Timer?

    func playVideoLoop(url: URL) {
        timer?.invalidate()
        timer = .scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
            if self.forReuse {
                let asset = AVAsset.init(url: url)
                let playerItem = AVPlayerItem(asset: asset)
                let queuePlayer = AVQueuePlayer(playerItem: playerItem)
                self.playerLooper = AVPlayerLooper(player: queuePlayer, templateItem: playerItem)
                self.playerLayer.removeFromSuperlayer()
                self.playerLayer = AVPlayerLayer(player: queuePlayer)
                self.playerLayer.frame = self.imageVideoView.bounds
                self.playerLayer.videoGravity = .resizeAspectFill
                self.imageVideoView.layer.insertSublayer(self.playerLayer, at: 0)
                self.imageViewSizeObserver = self.imageVideoView.observe(\UIImageView.bounds, options: .new) { [unowned self] _, change in
                     guard change.newValue != nil else { return }
                     self.playerLayer.frame = self.imageVideoView.bounds
                     self.playerLayer.layoutIfNeeded()
                 }
                queuePlayer.play()
                self.forReuse = !self.forReuse
            }
        }
    }
    
    var forReuse = true
    private var playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?
    
    @IBOutlet weak var imageVideoView: UIImageView!
    
    var viewModel: VideoLooperCellViewModel!
    private let disposeBag = DisposeBag()
    private var imageViewSizeObserver: NSKeyValueObservation?
    
    func configure(with viewModel: VideoLooperCellViewModel) {
        self.viewModel = viewModel
        self.playerLayer.frame = self.imageVideoView.bounds
        bindOutput()
    }
    
    private func bindOutput() {        
        viewModel.output.videoLooperUrl
            .drive(onNext: self.playVideoLoop)
            .disposed(by: disposeBag)
    }
    
}

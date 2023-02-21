//
//  DemoCell.swift
//  WantedChallengeMarch
//
//  Created by 김지수 on 2023/02/21.
//

import UIKit
import Kingfisher

class DemoCell: UITableViewCell {
    
    var image: String?
    
    @IBOutlet weak var setButton: UIButton!
    @IBOutlet weak var demoImageView: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //        demoImageView.image = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure() {
        setupUI()
        if let url = image {
            setupImage(url: url)
        }
    }
    
    private func setupImage(url: String) {
        demoImageView.image = ImageUrl.defaultImage
        
        // 이전 작업을 취소할 수 있는 DispatchWorkItem을 생성합니다.
        var previousTask: DispatchWorkItem?
        previousTask?.cancel()

        // 2초 후 실행할 작업을 예약합니다.
        let task = DispatchWorkItem { [weak self] in
            // 작업 내용
            self?.demoImageView.kf.setImage(with: URL(string: url)!)
            self?.revertImage()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: task)
        previousTask = task
    }
    
    private func revertImage() {
        
        // 이전 작업을 취소할 수 있는 DispatchWorkItem을 생성합니다.
        var previousTask: DispatchWorkItem?
        previousTask?.cancel()

        // 2초 후 실행할 작업을 예약합니다.
        let task = DispatchWorkItem { [weak self] in
            // 작업 내용
            self?.demoImageView.image = ImageUrl.defaultImage
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: task)
        previousTask = task
    }
    
    private func setupUI() {
        setButton.layer.cornerRadius = 15
        setButton.clipsToBounds = true
    }
    
    @IBAction func setBtnTapped(_ sender: UIButton) {
        if let url = image {
            setupImage(url: url)
        }
    }
}


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
    var previousTask: DispatchWorkItem?
    
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

        previousTask?.cancel()

        // 0.5초 후 실행
        // url 이미지 넣기
        let task = DispatchWorkItem { [weak self] in
            self?.demoImageView.kf.setImage(with: URL(string: url)!)
            self?.revertImage()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: task)
        previousTask = task
    }
    
    private func revertImage() {
        
        previousTask?.cancel()

        // 2초 후 실행
        // 이미지 복구
        let task = DispatchWorkItem { [weak self] in
            self?.demoImageView.image = ImageUrl.defaultImage
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: task)
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


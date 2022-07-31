//
//  HomeFriendCollectionViewCell.swift
//  kingbobne-ios
//
//  Created by sohyeon on 2022/07/26.
//  Copyright © 2022 TNXA6DBCHW. All rights reserved.
//

import UIKit

class HomeFriendCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var characterView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    private func setUI() {
        characterView.layer.cornerRadius = characterView.frame.height / 2
        characterView.layer.borderWidth = 1
        characterView.layer.borderColor = UIColor.Custom.brownGray300.cgColor
        
        nicknameLabel.textColor = .Custom.brownGray300
        nicknameLabel.font = UIFont.setFont(style: .CaptionRegular)
        nicknameLabel.text = "말하는 감자"
        
    }
    
    func config(profileImageURL: URL?, nickname: String) {
        // TODO 프로필 이미지 처리
        
        nicknameLabel.text = nickname
    }

}

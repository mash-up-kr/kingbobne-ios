//
//  HomeFriendCollectionViewCell.swift
//  kingbobne-ios
//
//  Created by sohyeon on 2022/07/26.
//  Copyright © 2022 TNXA6DBCHW. All rights reserved.
//

import UIKit

class HomeFriendCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backgroundCircleView: UIView!
    @IBOutlet weak var characterView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }
    
    private func setUI() {
        backgroundCircleView.layer.cornerRadius = backgroundCircleView.frame.height / 2
        characterView.layer.cornerRadius = characterView.frame.height / 2
        // 임시 컬러
        backgroundCircleView.backgroundColor = .blue
        characterView.backgroundColor = .yellow
    }

}

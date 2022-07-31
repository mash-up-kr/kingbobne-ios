//
//  HomeInfoView.swift
//  kingbobne-ios
//
//  Created by sohyeon on 2022/07/31.
//  Copyright © 2022 TNXA6DBCHW. All rights reserved.
//

import UIKit

class HomeInfoView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var kkilogLabel: UILabel!
    @IBOutlet weak var postKkilogButton: FullButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadXib()
        setUIComponents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadXib()
        setUIComponents()
    }
    
    private func setUIComponents() {
        
        todayLabel.text = "오늘"
        todayLabel.font = UIFont.setFont(style: .Body2Bold)
        
        dateLabel.font = UIFont.setFont(style: .Body2Regular)
        
        let nowDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M월 dd일"
        
        dateLabel.text = "\(dateFormatter.string(from: nowDate))"
        
        kkilogLabel.text = "끼록"
        kkilogLabel.font = UIFont.setFont(style: .Headline1Bold)
        
        [todayLabel, dateLabel, kkilogLabel].forEach({
            $0.textColor = .Custom.brownGray400
        })
        
        postKkilogButton.setButtonStyle(text: "0끼 +", fontStyle: .Headline2Bold, fontColor: .Custom.brandOrange, buttonColor: .white)
        postKkilogButton.layer.cornerRadius = postKkilogButton.layer.frame.height / 2
        postKkilogButton.layer.borderColor = UIColor.Custom.brandOrange.cgColor
        postKkilogButton.layer.borderWidth = 1
        postKkilogButton.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func config(kkilogCount: Int) {
        postKkilogButton.setTitle("\(kkilogCount)끼 +", for: .normal)
    }

}

//
//  PostKkiLogViewController.swift
//  kingbobne-ios
//
//  Created by sohyeon on 2022/07/17.
//  Copyright © 2022 TNXA6DBCHW. All rights reserved.
//

import UIKit

class PostSimpleKkiLogViewController: UIViewController {
    
    private let viewModel = PostKkiLogViewModelCompanion.newInstance()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var postButton: FullButton!
    
    @IBOutlet weak var topDividerView: UIView!
    @IBOutlet var dividerViews: [UIView]!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "끼록하기"
        setUI()
    }
    
    private func setUI() {
        titleLabel.text = "간단 끼록"
        titleLabel.font = .setFont(style: .Body1Bold)
        titleLabel.textColor = .Custom.brownGray500
        closeButton.setImage(UIImage.ic_xclose_44, for: .normal)
        closeButton.titleLabel?.isHidden = true
        closeButton.contentHorizontalAlignment = .fill
        closeButton.contentVerticalAlignment = .fill
        postButton.setButtonStyle(text: "완료", fontStyle: .CaptionBold, fontColor: .Custom.brownGray300, buttonColor: .Custom.brownGray100)
        postButton.layer.cornerRadius = postButton.layer.frame.height / 2
        
        topDividerView.backgroundColor = .Custom.brownGray50
        dividerViews.forEach({
            $0.backgroundColor = .Custom.brownGray100
        })
        
        titleTextField.placeholder = "요리 이름"
        titleTextField.font = .setFont(style: .Body1Bold)
        titleTextField.textColor = .Custom.brownGray500
        
        contentTextView.text = "오늘 만든 요리는 어땠나요?\n레시피, 맛, 기분 어떤 것이든 좋아요"
        contentTextView.font = .setFont(style: .Body3Medium)
        contentTextView.textColor = .Custom.brownGray500
    }

    @IBAction func onClose(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func onPost(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            // TODO: 홈에서 네비게이션으로 작성된 글로 이동 (딜리게이트)
        })
    }
}

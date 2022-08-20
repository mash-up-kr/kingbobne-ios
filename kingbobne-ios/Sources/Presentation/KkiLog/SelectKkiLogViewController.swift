//
//  SelectKkiLogViewController.swift
//  kingbobne-ios
//
//  Created by sohyeon on 2022/08/20.
//  Copyright © 2022 3999WG8MCQ. All rights reserved.
//

import UIKit
import PanModal

final class SelectKkiLogViewController: UIViewController, PanModalPresentable {
    var panScrollable: UIScrollView? {
            return nil
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var simpleKkilogButton: ClearButton!
    @IBOutlet weak var detailKkilogButton: ClearButton!
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(170)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        panModalSetNeedsLayoutUpdate()
        setUI()
    }
    
    private func setUI() {
        titleLabel.font = .setFont(style: .Body1Bold)
        titleLabel.textColor = .Custom.brownGray500
        titleLabel.text = "끼록 추가"
        simpleKkilogButton.setButtonStyle(text: "간단 끼록", fontStyle: .Body1Regular, fontColor: .Custom.brownGray500)
        detailKkilogButton.setButtonStyle(text: "상세 끼록", fontStyle: .Body1Regular, fontColor: .Custom.brownGray500)
        [simpleKkilogButton, detailKkilogButton].forEach({
            $0?.contentHorizontalAlignment = .left
        })
    }
    @IBAction func onSimpleKkilog(_ sender: Any) {
        guard let simpleKkilogViewController = UIStoryboard(name: "SimpleKkilog", bundle: nil).instantiateViewController(withIdentifier: "PostSimpleKkiLogViewController") as? PostSimpleKkiLogViewController else { return }
        
        simpleKkilogViewController.modalPresentationStyle = .overFullScreen
        self.present(simpleKkilogViewController, animated: true)
        
    }
    @IBAction func onDetailKkilog(_ sender: Any) {
        guard let detailKkilogViewController = UIStoryboard(name: "DetailKkilog", bundle: nil).instantiateViewController(withIdentifier: "PostDetailKkiLogViewController") as? PostDetailKkiLogViewController else { return }
        detailKkilogViewController.modalPresentationStyle = .overFullScreen
        self.present(detailKkilogViewController, animated: true)
    }
}

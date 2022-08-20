//
//  SelectKkiLogViewController.swift
//  kingbobne-ios
//
//  Created by sohyeon on 2022/08/20.
//  Copyright © 2022 3999WG8MCQ. All rights reserved.
//

import UIKit
import PanModal
import YPImagePicker

final class SelectKkiLogViewController: UIViewController, PanModalPresentable {
    var panScrollable: UIScrollView? {
            return nil
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var simpleKkilogButton: ClearButton!
    @IBOutlet weak var detailKkilogButton: ClearButton!
    
    var picker: YPImagePicker?
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(170)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        panModalSetNeedsLayoutUpdate()
        configImagePicker()
        setUI()
    }
    
    private func configImagePicker() {
        var config = YPImagePickerConfiguration()
        config.showsPhotoFilters = false
        config.startOnScreen = .library
        config.library.maxNumberOfItems = 10
        config.library.mediaType = .photo
        config.library.numberOfItemsInRow = 3
        config.library.skipSelectionsGallery = true
        
        picker = YPImagePicker(configuration: config)
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
    
    private func presentImagePicker(completion: (([YPMediaItem])-> ())?) {
        if let picker = picker {
            picker.didFinishPicking { [unowned picker] items, _ in
                picker.dismiss(animated: false, completion: {
                    completion?(items)
                })
            }
            present(picker, animated: true, completion: nil)
        }
    }
    
    private func routeToPostSimpleKkilog() {
        guard let simpleKkilogViewController = UIStoryboard(name: "SimpleKkilog", bundle: nil).instantiateViewController(withIdentifier: "PostSimpleKkiLogViewController") as? PostSimpleKkiLogViewController else { return }
        simpleKkilogViewController.modalPresentationStyle = .overFullScreen
        self.present(simpleKkilogViewController, animated: true)
    }
    
    private func routeToPostDetailKkilog() {
        guard let detailKkilogViewController = UIStoryboard(name: "DetailKkilog", bundle: nil).instantiateViewController(withIdentifier: "PostDetailKkiLogViewController") as? PostDetailKkiLogViewController else { return }
        
        detailKkilogViewController.modalPresentationStyle = .overFullScreen
        self.present(detailKkilogViewController, animated: true)
    }
    
    @IBAction func onSimpleKkilog(_ sender: Any) {
        presentImagePicker(completion: { result in
            print("onSimpleKkilog : \(result)")
            self.routeToPostSimpleKkilog()
        })
    }
    
    @IBAction func onDetailKkilog(_ sender: Any) {
        presentImagePicker(completion: { result in
            print("onSimpleKkilog : \(result)")
            self.routeToPostDetailKkilog()
        })
    }
}

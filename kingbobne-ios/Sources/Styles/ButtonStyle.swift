//
//  Buttons.swift
//  kingbobne-ios
//
//  Created by sohyeon on 2022/07/09.
//

import Foundation
import UIKit

class FullButton: UIButton {
    
    var fontStyle: UIFont.Style = .Body1Bold
    var fontColor: UIColor = .black
    var buttonColor: UIColor = .white
    var text: String?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButtonStyle(text: self.text, fontStyle: self.fontStyle, fontColor: self.fontColor, buttonColor: self.buttonColor)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setButtonStyle(text: self.text, fontStyle: self.fontStyle, fontColor: self.fontColor, buttonColor: self.buttonColor)
    }

    func setButtonStyle(text: String?, fontStyle: UIFont.Style, fontColor: UIColor, buttonColor: UIColor) {
        if let text = text {
            let attributedTitle = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont.setFont(style: fontStyle), NSAttributedString.Key.foregroundColor: fontColor])
            self.setAttributedTitle(attributedTitle, for: .normal)
        }
        self.fontColor = fontColor
        backgroundColor = buttonColor
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
}
class ClearButton: UIButton {
    var fontStyle: UIFont.Style = .Body1Bold
    var fontColor: UIColor = .black
    var text: String?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButtonStyle(text: self.text, fontStyle: self.fontStyle, fontColor: self.fontColor)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setButtonStyle(text: self.text, fontStyle: self.fontStyle, fontColor: self.fontColor)
    }

    func setButtonStyle(text: String?, fontStyle: UIFont.Style, fontColor: UIColor) {
        if let text = text {
            let attributedTitle = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont.setFont(style: fontStyle), NSAttributedString.Key.foregroundColor: fontColor])
            self.setAttributedTitle(attributedTitle, for: .normal)
        }
        self.fontColor = fontColor
        backgroundColor = .clear
    }
}

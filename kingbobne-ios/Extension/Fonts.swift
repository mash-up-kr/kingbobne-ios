//
//  Fonts.swift
//  kingbobne-ios
//
//  Created by sohyeon on 2022/07/09.
//

import UIKit

extension UIFont {
    enum Style: String {
        case Headline1Bold, HeadlineBoldEnglish, Headlineline1Regular
        case Headline2Bold, Headline2Regular
        case Body1Bold, Body1Regular
        case Body2Bold, Body2Regular
        case Body3Medium
        case CaptionBold
        case CaptionRegular
    }
    
    static func setFont(style: Style) -> UIFont {
        switch style {
        case .Headline1Bold:
            return UIFont(name: "Pretendard-Bold", size: 22)!
        case .HeadlineBoldEnglish:
            return UIFont(name: "Campton-BoldDEMO", size: 22)!
        case .Headlineline1Regular:
            return UIFont(name: "Pretendard-Regular", size: 22)!
        case .Headline2Bold:
            return UIFont(name: "Pretendard-Bold", size: 18)!
        case .Headline2Regular:
            return UIFont(name: "Pretendard-Regular", size: 18)!
        case .Body1Bold:
            return UIFont(name: "Pretendard-Bold", size: 16)!
        case .Body1Regular:
            return UIFont(name: "Pretendard-Regular", size: 16)!
        case .Body2Bold:
            return UIFont(name: "Pretendard-Bold", size: 14)!
        case .Body2Regular:
            return UIFont(name: "Pretendard-Bold", size: 14)!
        case .Body3Medium:
            return UIFont(name: "Pretendard-Medium", size: 15)!
        case .CaptionBold:
            return UIFont(name: "Pretendard-Bold", size: 11)!
        case .CaptionRegular:
            return UIFont(name: "Pretendard-Regular", size: 11)!
        }
    }
}


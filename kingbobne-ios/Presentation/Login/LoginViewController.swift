//
//  LoginViewController.swift
//  kingbobne-ios
//
//  Created by sohyeon on 2022/07/09.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: FullButton!
    @IBOutlet weak var signUpButton: FullButton!
    @IBOutlet weak var dishImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
    }
    
    func setUpUI() {
        self.view.backgroundColor = .Custom.loginBackground
        loginButton.setButtonStyle(text: "시작하기", fontStyle: .Body1Bold, fontColor: .Custom.brandOrange, buttonColor: .white)
        signUpButton.setButtonStyle(text: "회원가입", fontStyle: .Body1Regular, fontColor: .white, buttonColor: .clear)
        dishImgView.image = UIImage(named: "img_dish")
        titleLabel.numberOfLines = 3
        titleLabel.text = "아침에도\n점심에도\n저녁에도"
        subTitleLabel.text = "끼록!"
        titleLabel.font = .setFont(style: .Headline2Regular)
        titleLabel.textColor = .Custom.brownGray50
        subTitleLabel.font = .setFont(style: .Headline1Bold)
        subTitleLabel.textColor = .white
    }
    
    @IBAction func onLogin(_ sender: Any) {
        
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        
    }
    

}

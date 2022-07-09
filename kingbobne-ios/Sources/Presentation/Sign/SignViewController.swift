//
//  SignViewController.swift
//  kingbobne-ios
//
//  Created by sohyeon on 2022/07/09.
//

import UIKit

class SignViewController: UIViewController {

    @IBOutlet weak var signInButton: FullButton!
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
        signInButton.setButtonStyle(text: "시작하기", fontStyle: .Body1Bold, fontColor: .Custom.brandOrange, buttonColor: .white)
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
    
    @IBAction func onSignIn(_ sender: Any) {
        let signInVC = UIStoryboard(name: "SignIn", bundle: nil).instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        self.navigationController?.pushViewController(signInVC, animated: true)
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        
    }
    

}

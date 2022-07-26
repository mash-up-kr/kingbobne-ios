//
//  HomeViewController.swift
//  kingbobne-ios
//
//  Created by sohyeon on 2022/07/10.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet weak var friendCollectionView: UICollectionView!
    @IBOutlet var bottomViewDividers: [UIView]!
    @IBOutlet weak var recommendMenuButton: ClearButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var myPageButton: UIButton!
    @IBOutlet weak var alarmButton: UIButton!
    @IBOutlet weak var characterImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        setUIComponent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func setCollectionView() {
        friendCollectionView.delegate = self
        friendCollectionView.dataSource = self
        friendCollectionView.showsHorizontalScrollIndicator = false
        friendCollectionView.register(UINib(nibName: "HomeFriendCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeFriendCollectionViewCell")
    }
    
    private func setUIComponent() {
        bottomViewDividers.forEach({
            $0.backgroundColor = .Custom.brownGray300
        })
        descriptionLabel.font = .setFont(style: .Body2Regular)
        descriptionLabel.textColor = .Custom.brownGray200
        questionLabel.font = .setFont(style: .Body1Regular)
        questionLabel.textColor = .Custom.brownGray400
        
        recommendMenuButton.setButtonStyle(text: "뭐먹지", fontStyle: .Body2Regular, fontColor: .Custom.brownGray400)
        recommendMenuButton.imageView?.sizeThatFits(CGSize(width: 32, height: 32))
        
        descriptionLabel.text = "일이삼사오육칠팝구십"
        questionLabel.text = "해가 중천인데 배 안고파요?"
        
        myPageButton.setImage(UIImage.ic_mypage_44, for: .normal)
        alarmButton.setImage(UIImage.ic_alarm_44, for: .normal)
        [myPageButton, alarmButton].forEach({
            $0?.tintColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1.0)
        })
        characterImageView.image = UIImage(named: "Lv3_배부를때")
    }
    
    @IBAction func onAlarmAction(_ sender: Any) {
        // TODO
    }
    
    @IBAction func onMyPageAction(_ sender: Any) {
        // TODO
    }
}
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeFriendCollectionViewCell", for: indexPath) as! HomeFriendCollectionViewCell
        return cell
    }
}

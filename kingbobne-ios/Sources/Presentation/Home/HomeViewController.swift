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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionView()
        setUIComponent()
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

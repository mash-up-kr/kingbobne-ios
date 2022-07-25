//
//  HomeViewController.swift
//  kingbobne-ios
//
//  Created by sohyeon on 2022/07/10.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var friendCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setCollectionView()
    }
    
    private func setCollectionView() {
        friendCollectionView.delegate = self
        friendCollectionView.dataSource = self
        friendCollectionView.showsHorizontalScrollIndicator = false
        friendCollectionView.register(UINib(nibName: "HomeFriendCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeFriendCollectionViewCell")
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

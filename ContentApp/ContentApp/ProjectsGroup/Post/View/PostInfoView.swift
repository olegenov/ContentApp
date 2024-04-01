//
//  PostInfoView.swift
//  ContentApp
//
//  Created by Никита Китаев on 01.04.2024.
//

import UIKit

class PostInfoView: UICollectionView {
    let cellIdentifier = "PostInfoCell"
    var data: Post?
    
    init() {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        
        register(PostTextViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        delegate = self
        dataSource = self
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateData(_ data: Post) {
        self.data = data
        reloadData()
    }
    
    func configure(with: Post) {
        self.data = with
    }
    
    func configureUI() {
        configureCollectionView()
    }
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        collectionViewLayout = layout
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
        delegate = self
        
        register(PostTextViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension PostInfoView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostInfoCell", for: indexPath) as! PostTextViewCell
            
            guard let post = self.data else {
                return cell
            }
            cell.configure(with: post)
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

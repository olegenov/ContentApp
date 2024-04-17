//
//  UserList.swift
//  ContentApp
//
//  Created by Никита Китаев on 15.04.2024.
//

import UIKit

class UserList: CardList {
    override init(cardHeight: CGFloat) {
        super.init(cardHeight: cardHeight)
        
        register(NewInvitationCard.self, forCellWithReuseIdentifier: "NewInvitationCardCell")
        register(UserCard.self, forCellWithReuseIdentifier: "UserCardCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var inviteAction: (() -> Void)?
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count + 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewInvitationCardCell", for: indexPath) as! NewInvitationCard

            cell.configureCardTapAction({ self.inviteAction?() })
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCardCell", for: indexPath) as! UserCard
        let invitation = data[indexPath.item - 1]
        
        cell.configure(with: invitation)
        
        return cell
    }
    
    func configureInviteAction(action: @escaping (() -> Void)) {
        inviteAction = action
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 2 * Constants.horizontalGap)

        return CGSize(width: width, height: self.cardHeight)
    }
}

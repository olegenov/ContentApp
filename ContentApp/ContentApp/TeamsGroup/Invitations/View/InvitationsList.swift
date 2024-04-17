//
//  InvitationsList.swift
//  ContentApp
//
//  Created by Никита Китаев on 13.04.2024.
//

import UIKit

class InvitationsList: CardList {
    override init(cardHeight: CGFloat) {
        super.init(cardHeight: cardHeight)
        
        register(InvitationCard.self, forCellWithReuseIdentifier: "InvitationCardCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var acceptAction: ((Int) -> Void)?
    var rejectAction: ((Int) -> Void)?
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InvitationCardCell", for: indexPath) as! InvitationCard
        let invitation = data[indexPath.item]
        
        cell.configure(with: invitation)
        
        cell.configureAcceptAction({
            self.acceptAction?(invitation.id)
        })
        
        cell.configureRejectAction({
            self.rejectAction?(invitation.id)
        })
        
        return cell
    }
    
    func configureAcceptAction(action: @escaping ((Int) -> Void)) {
        acceptAction = action
    }
    
    func configureRejectAction(action: @escaping ((Int) -> Void)) {
        rejectAction = action
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 2 * Constants.horizontalGap)

        return CGSize(width: width, height: self.cardHeight)
    }
}

//
//  TeamList.swift
//  ContentApp
//
//  Created by Никита Китаев on 31.03.2024.
//

import UIKit

class TeamList: CardList {
    override init(cardHeight: CGFloat) {
        super.init(cardHeight: cardHeight)
        register(MyInvitationsCard.self, forCellWithReuseIdentifier: "InvitationCell")
    }
    
    internal var invitationCardTapAction: (() -> Void)?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count + 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CreateCardCell", for: indexPath) as! CreateCard
            
            cell.configureCardTapAction(addCardTapAction ?? {})
            
            return cell
        }
        
        if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InvitationCell", for: indexPath) as! MyInvitationsCard
            
            if !data.isEmpty {
                cell.configureAmountText(data[0].title)
            }
            
            cell.configureCardTapAction(invitationCardTapAction ?? {})
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! Card
        let team = data[indexPath.item - 1]
        
        cell.configure(with: team)
        cell.configureCardTapAction({
            self.cardTapAction?(team.id)
        })
        
        return cell
    }
    
    func updateInvitationCardAmount(amount: Int) {
        if !data.isEmpty {
            data[0].title = "\(amount)"
        }
        
        reloadData()
    }
    
    func configureInvitationsCardTapAction(_ action: @escaping () -> Void) {
        invitationCardTapAction = action
    }
}

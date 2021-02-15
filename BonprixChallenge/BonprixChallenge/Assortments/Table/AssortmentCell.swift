//
//  AssortmentCell.swift
//  BonprixChallenge
//
//  Created by Sandro Wehrhahn on 08.02.21.
//


import UIKit


class AssortmentCell: UITableViewCell {
    
    var assortment: AssortmentModel? {
        didSet {
            updateFromAssortment()
        }
    }
    
    private func updateFromAssortment() {
        guard let assortment = assortment else { return }
        
        textLabel?.text = assortment.label
        accessoryType = assortment.childrenList.isEmpty ? .none : .disclosureIndicator 
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: true)
    }
    
}

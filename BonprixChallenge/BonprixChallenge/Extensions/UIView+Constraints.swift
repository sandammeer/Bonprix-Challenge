//
//  UIView+Constraints.swift
//  BonprixChallenge
//
//  Created by Sandro Wehrhahn on 08.02.21.
//


import UIKit


public extension UIView {
    
    func addSubViewWithConstraints(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        
        NSLayoutConstraint.activate([
            view.leftAnchor.constraint(equalTo: self.leftAnchor),
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.rightAnchor.constraint(equalTo: self.rightAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func addSubViewInCenter(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
}

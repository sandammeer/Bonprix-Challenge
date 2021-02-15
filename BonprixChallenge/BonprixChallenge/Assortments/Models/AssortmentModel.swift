//
//  AssortmentModel.swift
//  BonprixChallenge
//
//  Created by Sandro Wehrhahn on 08.02.21.
//


import Foundation


public class AssortmentModel: NSObject, Codable {
    
    public var label: String
    public var url: String? = nil
    public var image: String? = nil
    private var children: [AssortmentModel]?
    
    // convenience getter
    public var childrenList: [AssortmentModel] {
        children ?? []
    }
    
    init(label: String, children: [AssortmentModel]) {
        self.label = label
        self.children = children
    }
    
}


/// Wrapper struct for a more convenient use of the codables
public struct AssortmentListModel: Codable {
    
    public let categories: [AssortmentModel]
    
}

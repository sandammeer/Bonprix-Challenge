//
//  AssortsmentTableViewDataSource.swift
//  BonprixChallenge
//
//  Created by Sandro Wehrhahn on 08.02.21.
//


import UIKit


public class AssortsmentsTableDataSource: NSObject {
    
    public var assortment: AssortmentModel
    
    public init(assortment: AssortmentModel) {
        self.assortment = assortment
    }
    
}

// MARK: - Datasource

extension AssortsmentsTableDataSource: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "assortmentCell", for: indexPath) as? AssortmentCell
        else {
            return UITableViewCell()
        }

        cell.assortment = assortment.childrenList[indexPath.row]
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard !assortment.childrenList.isEmpty else { return 0 }
        return assortment.childrenList.count
    }

}

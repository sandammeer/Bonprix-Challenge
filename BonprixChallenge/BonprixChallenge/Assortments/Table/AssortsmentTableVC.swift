//
//  AssortsmentTableVC.swift
//  BonprixChallenge
//
//  Created by Sandro Wehrhahn on 08.02.21.
//


import UIKit


class AssortsmentTableVC: UITableViewController {

    var datasource: AssortsmentsTableDataSource? {
        didSet {
            tableView.dataSource = datasource
            tableView.reloadData()
            updateHeaderFromRootAssortment()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.accessibilityIdentifier = "tableview_assortments"
        tableView.delegate = self
        tableView.register(AssortmentCell.self, forCellReuseIdentifier: "assortmentCell")
    }
    
}

// MARK: - HeaderView

extension AssortsmentTableVC {
    
    private func updateHeaderFromRootAssortment() {
        guard let assortment = datasource?.assortment else { return }
        
        title = assortment.label
        
        AssortmentService.shared.getImageFrom(assortment: assortment) { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                
                DispatchQueue.main.async {
                    let imageView = UIImageView(image: image)
                    imageView.contentMode = .scaleAspectFill
                    imageView.frame = CGRect(x: 0, y: 0, width: 0, height: 180)
                    self.tableView.tableHeaderView = imageView
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}



// MARK: - UITableViewDelegate

extension AssortsmentTableVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let children = datasource?.assortment.childrenList,
            let navigationVC = navigationController as? NavigationVC
        else {
            return
        }

        navigationVC.navigateFor(assortment: children[indexPath.row])
    }
    
}

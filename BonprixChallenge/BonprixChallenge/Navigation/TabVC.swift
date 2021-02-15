//
//  TabVC.swift
//  BonprixChallenge
//
//  Created by Sandro Wehrhahn on 08.02.21.
//


import UIKit


class TabVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabbar()
        updateTabs()
    }
    
    private func setupTabbar() {
        tabBar.isTranslucent = false
        tabBar.tintColor = .systemRed
        tabBar.accessibilityIdentifier = "tabbar_bonprix"
    }

    private func updateTabs() {
        AssortmentService.shared.getAssortments { result in
            switch result {
            case .success(let assortments):
                DispatchQueue.main.async {
                    self.viewControllers = self.viewControllerFrom(assortments: assortments)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func viewControllerFrom(assortments: [AssortmentModel]) -> [UIViewController] {
        // Add rootnode for assortment ViewController
        let sortimentNode = AssortmentModel(label: "Sortiment",
                                            children: Array(assortments[1...]))
        return [
            NavigationVC
                .from(assortment: assortments[0])
                .setTab(title: assortments[0].label,
                        image: UIImage(systemName: "house")!,
                        tag: 1),
            NavigationVC
                .from(assortment: sortimentNode)
                .setTab(title: sortimentNode.label,
                        image: UIImage(systemName: "magnifyingglass")!,
                        tag: 2)
        ]
    }
    
}

extension UIViewController {
    
    func setTab(title: String, image: UIImage, tag: Int) -> Self {
        self.tabBarItem = UITabBarItem(title: title, image: image, tag: tag)
        self.tabBarItem.accessibilityIdentifier = "tabitem_\(tag)"
        return self
    }
    
}

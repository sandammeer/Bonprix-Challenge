//
//  NavigationViewController.swift
//  BonprixChallenge
//
//  Created by Sandro Wehrhahn on 08.02.21.
//


import UIKit
import WebKit


public class NavigationVC: UINavigationController {
    
    /// Returns NavigationVC instance with root ViewController depending on AssortmentModel
    /// - Parameter assortment: AssortmentModel from Backend
    /// - Returns: NavigationVC
    static func from(assortment: AssortmentModel) -> NavigationVC {
        let rootVC = NavigationVC.viewControllerFrom(assortment: assortment)
        return NavigationVC(rootViewController: rootVC)
    }
    
    private static func viewControllerFrom(assortment: AssortmentModel) -> UIViewController {
        if assortment.childrenList.isEmpty {
            let webVC = WebContainerVC()
            webVC.assortment = assortment
            return webVC
        } else {
            let tableVC = AssortsmentTableVC()
            tableVC.datasource = AssortsmentsTableDataSource(assortment: assortment)
            return tableVC
        }
    }

}


// MARK: - Navigation

public extension NavigationVC {
    
    func navigateFor(assortment: AssortmentModel, animated: Bool = true) {
        let vc = NavigationVC.viewControllerFrom(assortment: assortment)
        pushViewController(vc, animated: animated)
    }
    
    func navigatefor(webaction: WKNavigationAction,
                     decisionHandler: (WKNavigationActionPolicy) -> Void) {
        guard let url = webaction.request.url
        else {
            decisionHandler(.allow)
            return
        }
        
        if webaction.navigationType == .linkActivated {
            let destinationVC = WebContainerVC()
            destinationVC.load(url: url)
            decisionHandler(.cancel)
            pushViewController(destinationVC, animated: true)
        } else {
            decisionHandler(.allow)
        }
    }
    
}

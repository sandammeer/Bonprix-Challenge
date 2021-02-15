//
//  WebContainerVC.swift
//  BonprixChallenge
//
//  Created by Sandro Wehrhahn on 10.02.21.
//


import UIKit
import WebKit


public class WebContainerVC: UIViewController {
    
    public var assortment: AssortmentModel? {
        didSet {
            updateFromAssortment()
        }
    }
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.navigationDelegate = self
        webView.accessibilityIdentifier = "webview_container"
        return webView
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubViewWithConstraints(webView)
    }
    
    public func load(url: URL) {
        webView.load(URLRequest(url: url))
    }
    
    private func updateFromAssortment() {
        guard
            let assortment = assortment,
            let urlString = assortment.url,
            let url = URL(string: urlString)
        else { return }
        
        title = assortment.label
        load(url: url)
    }
    
}


extension WebContainerVC: WKNavigationDelegate {

    public func webView(_ webView: WKWebView,
                        decidePolicyFor navigationAction: WKNavigationAction,
                        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let navigationVC = navigationController as? NavigationVC
        else {
            decisionHandler(.allow)
            return
        }
        
        navigationVC.navigatefor(webaction: navigationAction, decisionHandler: decisionHandler)
    }

}

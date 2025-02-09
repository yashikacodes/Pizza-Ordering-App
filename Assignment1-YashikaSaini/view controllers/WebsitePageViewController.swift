//
//  WebsitePageViewController.swift
//  Assignment1-YashikaSaini
//
//  Created by Default User on 2/8/25.
//

import UIKit
import WebKit

class WebsitePageViewController: UIViewController, WKNavigationDelegate {

    
    @IBOutlet var webView: WKWebView!
    @IBOutlet var activity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Step 1: Set URL for Google.ca
        let urlAddress = URL(string: "https://theme.theabstractidea.com/")!
                
        // Step 2: Create a URL Request
        let url = URLRequest(url: urlAddress)
                
        // Step 3: Load the URL in the WebView
        webView.load(url)
                
        // Step 4: Set the navigation delegate
        webView.navigationDelegate = self

        // Do any additional setup after loading the view.
    }
    
    // While loading
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            activity.isHidden = false
            activity.startAnimating()
        }

        // After loading is complete
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            activity.isHidden = true
            activity.stopAnimating()
        }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

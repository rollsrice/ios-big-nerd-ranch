//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Ryan Zhang on 2016-02-09.
//  Copyright © 2016 Ryan Zhang. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = NSURL(string: "https://www.bignerdranch.com") {
            let req = NSURLRequest(URL: url)
            webView?.loadRequest(req)
        }
    }
}

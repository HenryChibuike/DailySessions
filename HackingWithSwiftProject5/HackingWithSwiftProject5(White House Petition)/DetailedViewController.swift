//
//  DetailedViewController.swift
//  HackingWithSwiftProject5(White House Petition)
//
//  Created by Henry-chime chibuike on 2/4/20.
//  Copyright © 2020 Henry-chime chibuike. All rights reserved.
//

import UIKit
import WebKit

class DetailedViewController: UIViewController {
    var WebView: WKWebView!
    var detailItem: Petition?
    
    
    override func loadView() {
        WebView = WKWebView()
        view = WebView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let detailItem = detailItem else{ return}
         
     let html = """
     <html>
     <head>
     <meta name="viewport" content="width=device-width, initial-scale=1">
     <style> body { font-size: 150%; } </style>
     </head>
     <body>
     \(detailItem.body)
     </body>
     </html>
     """
        WebView.loadHTMLString(html, baseURL: nil)
    }
    

}

//
//  WebViewController.swift
//  Popt
//
//  Created by Tomooki on 2016/05/21.
//  Copyright © 2016年 TomookiTatsuguhi. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate{

    var url : NSURL!
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.delegate = self
        self.view.addSubview(webView)
        let request: NSURLRequest = NSURLRequest(URL: self.url!)
        webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func closePage(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}

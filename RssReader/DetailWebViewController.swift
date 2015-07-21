//
//  DetailViewController.swift
//  News
//
//  Created by y-sakumae on 2015/07/02.
//  Copyright (c) 2015年 y-sakumae. All rights reserved.
//

import UIKit
import SwiftyJSON
import TOWebViewController
import SVProgressHUD
/*
class DetailWebViewController: TOWebViewController {
    var webview: UIWebView = UIWebView()
    var entry : Dictionary<String, JSON> = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        self.webview.frame = CGRectMake(0, 65, self.view.bounds.size.width, self.view.bounds.size.height)
        self.webview.delegate = self;
        self.view.addSubview(self.webview)
        
        var url = NSURL(string: self.entry["link"]!.string!)
        var request = NSURLRequest(URL: url!)
        
        SVProgressHUD.show()
        self.webview.loadRequest(request)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension DetailWebViewController : UIWebViewDelegate {
    
    override func webViewDidStartLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
    }
    
    override func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        SVProgressHUD.dismiss()
    }
    
    
}
*/

class DetailWebViewController: UIViewController,UIWebViewDelegate {
    var webView = UIWebView()
    var entry :Dictionary<String,JSON> = [:]
    
    override func viewDidLoad() {
        self.navigationController?.navigationBarHidden = true
        self.webView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)
        self.webView.delegate = self
        self.view.addSubview(self.webView)
        
        var url = NSURL(string: self.entry["link"]!.string!)
        var request = NSURLRequest(URL: url!)
        SVProgressHUD.show()
        self.webView.loadRequest(request)
        
        let toolBar:UIToolbar = UIToolbar(frame: CGRectMake(0, self.view.bounds.size.height-40, self.view.bounds.size.width, 40))
        toolBar.barStyle = UIBarStyle.Default
        toolBar.alpha = 0.9
        
        let backButton:UIBarButtonItem = UIBarButtonItem(title: "Back", style:.Plain, target: self, action: "backButton:")
        toolBar.items = [backButton]
        
        self.view.addSubview(toolBar)
        
    }
    
    func backButton(snder:UIBarButtonItem){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        SVProgressHUD.dismiss()
    }
}

/*
extension DetailWebViewController:UIScrollViewDelegate{
    
    var beginScrollViewOffsetY:CGFloat
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        //self.beginScrollViewOffsetY = scrollView.contentOffset.y
        
        self.beginScrollOffsetY = scrollView.contentOffset.y
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
}
*/
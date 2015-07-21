//
//  ViewController.swift
//  News
//
//  Created by y-sakumae on 2015/07/01.
//  Copyright (c) 2015年 y-sakumae. All rights reserved.
//

import UIKit
import PageMenu

class ViewController: UIViewController,CAPSPageMenuDelegate {
    var pageMenu : CAPSPageMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "RSSReader"
        
        var controllerArray : [UIViewController] = []
        var feedArray: [ Dictionary<String, String!> ] =
        [
            [
                "link" : "http://ajax.googleapis.com/ajax/services/feed/load?v=1.0&q=http://rss.dailynews.yahoo.co.jp/fc/domestic/rss.xml&num=10",
                "title" : "国内"
            ],
            
            [
                "link" : "http://ajax.googleapis.com/ajax/services/feed/load?v=1.0&q=http://rss.dailynews.yahoo.co.jp/fc/economy/rss.xml&num=10",
                "title" : "経済"
            ],
            
            [
                "link" : "http://ajax.googleapis.com/ajax/services/feed/load?v=1.0&q=http://rss.dailynews.yahoo.co.jp/fc/computer/rss.xml&num=10" ,
                "title" : "IT"
            ],
            
            [
                "link" : "http://ajax.googleapis.com/ajax/services/feed/load?v=1.0&q=http://rss.dailynews.yahoo.co.jp/fc/world/rss.xml&num=10" ,
                "title" : "海外"
            ],
            
            [
                "link" : "http://ajax.googleapis.com/ajax/services/feed/load?v=1.0&q=http://rss.dailynews.yahoo.co.jp/fc/local/rss.xml&num=10" ,
                "title" : "地域"
            ],
            
            [
                "link" : "http://ajax.googleapis.com/ajax/services/feed/load?v=1.0&q=http://rss.dailynews.yahoo.co.jp/fc/sports/rss.xml&num=10",
                "title" : "スポーツ"
            ],
            
            [
                "link" : "http://ajax.googleapis.com/ajax/services/feed/load?v=1.0&q=http://rss.dailynews.yahoo.co.jp/fc/science/rss.xml&num=10",
                "title" : "科学"
            ]
        ]
        
        for feed in feedArray {
            
            var feedController = FeedTableViewController()
            feedController.link = feed["link"]!
            feedController.parent = self
            feedController.title = feed["title"]!
            controllerArray.append(feedController)
        }
        
        var parameters: [CAPSPageMenuOption] = [
            .MenuItemSeparatorWidth(4),
            .UseMenuLikeSegmentedControl(true),
            .MenuItemSeparatorPercentageHeight(0.1)
        ]
        
        let statusBarHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.height
        let naviheight = self.navigationController!.navigationBar.frame.size.height
        let y_position = naviheight + statusBarHeight
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, y_position, self.view.frame.width, self.view.frame.height - y_position), pageMenuOptions: parameters)
        pageMenu?.viewBackgroundColor = UIColor.yellowColor()
        pageMenu?.selectedMenuItemLabelColor = UIColor.yellowColor()
        
        
        //pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0,y_position, self.view.frame.width, self.view.frame.height - y_position), options: parameters)
        
        self.view.addSubview(pageMenu!.view)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
}


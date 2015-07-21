//
//  FeedTableViewController.swift
//  News
//
//  Created by y-sakumae on 2015/07/01.
//  Copyright (c) 2015年 y-sakumae. All rights reserved.
//

import UIKit
import SwiftyJSON
import SVProgressHUD
class FeedTableViewController: UITableViewController {
    
    let parse = ParseFeed()
    var link: String = String()
    var entries: [JSON] = []
    var parent: UIViewController = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.show()
        
        //var nib:UINib = UINib(nibName: "CustomCell", bundle: nil)
        self.tableView.registerClass(CustomCell.self, forCellReuseIdentifier: "customCell")
        
        //self.tableView.registerNib(nib, forCellReuseIdentifier: "Cell")
        //self.tableView.backgroundColor = UIColor.greenColor()
        
        parse.parse(self.link, completion: {(data,error) in
            
            self.entries = data!
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
        })
        
        self.tableView.addPullToRefresh({ [weak self] in
            
            self?.tableView.reloadData()
            self?.tableView.stopPullToRefresh()
            
            })
        
        self.tableView.reloadData()
        self.tableView.stopPullToRefresh()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


/*
* カスタムセルの設定
* 取得したJSONデータをカスタムセルにセットする。
*/

extension FeedTableViewController : UITableViewDataSource {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.entries.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("customCell", forIndexPath: indexPath) as! CustomCell
        
        cell.title.text = self.entries[indexPath.row]["title"].string
        
        var contents = ""
        var image = ""
        cell.contents.text = ""
        cell.img.image = UIImage(named:"no_Image")!
        
        parse.getContents(self.entries[indexPath.row]["link"].string!, completion: { (data, error) in
            
            contents = data["content"] as! String
            cell.contents.text = contents
            
            image = data["image"] as! String
            
            if image != ""{
                self.dispatch_async_global {
                    let url = NSURL(string: image)
                    var err: NSError?;
                    var imageData :NSData = NSData(contentsOfURL: url!, options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &err)!
                    
                    self.dispatch_async_main {
                        cell.img.image = UIImage(data:imageData)!
                        cell.layoutSubviews()
                    }
                }
                
            }
            else{
                cell.img.image = UIImage(named:"no_Image")!
            }
        })
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 140
    }
    
    func dispatch_async_main(block: () -> ()) {
        dispatch_async(dispatch_get_main_queue(), block)
    }
    
    func dispatch_async_global(block: () -> ()) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
    }
}
/*
* セルをタップした後の詳細画面に設定
*/
extension FeedTableViewController : UITableViewDelegate {
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let detailViewController = DetailWebViewController()
        detailViewController.entry = self.entries[indexPath.row].dictionary!
        parent.navigationController!.pushViewController(detailViewController , animated: true)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
}
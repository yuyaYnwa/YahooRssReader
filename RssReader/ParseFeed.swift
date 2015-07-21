//
//  ParseFeed.swift
//  News
//
//  Created by y-sakumae on 2015/07/01.
//  Copyright (c) 2015年 y-sakumae. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import HTMLReader

class ParseFeed {
    /*
    * RSSのJSONをパースする
    */
    func parse(url: String, completion: (([JSON]?, NSError?) -> Void)){
        var url = NSURL(string: url)
        Alamofire.request(.GET, url!, parameters: nil, encoding: .JSON)
            
            .responseJSON { (request, response, data, error) in
                
                let json = JSON(data!)
                let entries = json["responseData"]["feed"]["entries"].array
                
                completion(entries, error)
        }
    }
    
    //MARK:URL先の文章と画像を取得
    func getContents (url: String, completion: ((AnyObject, NSError?) -> Void)){
        
        var url = NSURL(string: url)
        var ret : Dictionary<String, String!> = [:]
        
        Alamofire.request(.GET, url!, parameters: nil)
            
            .responseString { (request, response, data, error) in
                
                var content = ""
                let html = HTMLDocument(string: data!)
                let ogTags = html.nodesMatchingSelector("meta[property=\"og:description\"]")
                for tag in ogTags{
                    content = (tag.attributes?["content"] as? String)!
                }
                
                var image = ""
                let imgTags = html.nodesMatchingSelector("img")
                for img in imgTags{
                    if(img.attributes?["data-src"] != nil){
                        image = (img.attributes?["data-src"] as? String)!
                    }
                }
                
                ret = [ "content": content , "image" : image ]
                completion(ret, error)
        }
    }
}


//
//  CustomCell.swift
//  News
//
//  Created by y-sakumae on 2015/07/01.
//  Copyright (c) 2015年 y-sakumae. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    //@IBOutlet weak var img: UIImageView!
    //@IBOutlet weak var title: UILabel!
    //@IBOutlet weak var contents: UILabel!
    var title:UILabel = UILabel()
    var contents:UILabel = UILabel()
    var img:UIImageView = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        title = UILabel(frame: CGRectMake(0, 0, self.frame.width-100, 20))
        title.font = UIFont.boldSystemFontOfSize(17)
        self.addSubview(title)
        
        contents = UILabel(frame: CGRectMake(0, 15, self.frame.width-100, 120))
        contents.font = UIFont.systemFontOfSize(14)
        contents.numberOfLines = 0
        self.addSubview(contents)
        
        img = UIImageView(frame: CGRectMake(self.frame.width*0.8, 15, self.frame.width/3, 100))
        let noImage = UIImage(named: "no_Image")
        img.image = noImage
        self.addSubview(img)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    override func awakeFromNib() {
    super.awakeFromNib()
    //let cell:UITableViewCell = UITableViewCell()
    title = UILabel(frame: CGRectMake(120, 2, 300, 20))
    title.font = UIFont.systemFontOfSize(12)
    self.addSubview(title)
    
    contents = UILabel(frame: CGRectMake(120, 25, 300, 20))
    contents.font = UIFont.systemFontOfSize(18)
    self.addSubview(contents)
    
    img = UIImageView(frame: CGRectMake(1, 1, 100, 100))
    let noImage = UIImage(named: "no_image")
    img.image = noImage
    self.addSubview(img)
    
    }
    */
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

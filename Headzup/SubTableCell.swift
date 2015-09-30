//
//  SubTableCell.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 9/9/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import UIKit

class SubTableCell: UITableViewCell,UITableViewDataSource,UITableViewDelegate {
    
    
    var dataArr:[String] = []
    var subMenuTable:UITableView?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: reuseIdentifier)
        setUpTable()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
       // setUpTable()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpTable()
    }
    
    func setUpTable()
    {
        let contentView =  UIView()
        contentView.backgroundColor = UIColor.blueColor()
        
        subMenuTable = UITableView(frame: CGRectZero, style:UITableViewStyle.Plain)
        subMenuTable?.delegate = self
        subMenuTable?.dataSource = self
        contentView.addSubview(subMenuTable!)
        self.addSubview(contentView)
        contentView.frame = CGRectMake(0, 0, self.bounds.width, 500)
        subMenuTable?.frame = CGRectMake(5, 5, self.bounds.width - 10, 490)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("cellID") as UITableViewCell!
        if(cell == nil)
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cellID")
        }
        cell!.textLabel!.text = dataArr[indexPath.row]
        return cell!
    }
}
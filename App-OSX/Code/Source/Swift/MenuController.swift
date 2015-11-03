//
//  MenuController.swift
//  App-OSX
//
//  Copyright © 2015 Syerit Limited. All rights reserved.
//

import Cocoa
import Core

class MenuController: NSViewController, NSTableViewDataSource,NSTableViewDelegate {
    
    var dataArray: [MenuItem] = [
        MenuItem(title: "Home"),
        MenuItem(title: "RxSearch"),
        MenuItem(title: "Login"),
        MenuItem(title: "AdExample")
    ];
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    
    func numberOfRowsInTableView(aTableView: NSTableView!) -> Int
    {
        let numberOfRows:Int = dataArray.count
        return numberOfRows
    }
    
    func tableView(tableView: NSTableView!, objectValueForTableColumn tableColumn: NSTableColumn!, row: Int) -> AnyObject!
    {
        let object = dataArray[row] as MenuItem
        return object.getTitle()
    }
    
    func tableView(tableView: NSTableView, setObjectValue object: AnyObject?, forTableColumn tableColumn: NSTableColumn?, row: Int)
    {
        //dataArray[row].setObject(object!, forKey: (tableColumn?.identifier)!)
    }
    
}

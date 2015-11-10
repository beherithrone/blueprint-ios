//
//  MenuController.swift
//  App-OSX
//
//  Copyright © 2015 Syerit Limited. All rights reserved.
//

import Cocoa
import Core_OSX

class MenuController: NSViewController, NSTableViewDataSource,NSTableViewDelegate {
    
    var appModel : AppModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        appModel = AppModel()
    }
    
    
    func numberOfRowsInTableView(aTableView: NSTableView!) -> Int
    {
        let numberOfRows:Int = appModel!.menuItems.count
        return numberOfRows
    }
    
    func tableView(tableView: NSTableView!, objectValueForTableColumn tableColumn: NSTableColumn!, row: Int) -> AnyObject!
    {
        let object = appModel!.menuItems[row] as MenuItem
        return object.getTitle()
    }
    
    func tableView(tableView: NSTableView, setObjectValue object: AnyObject?, forTableColumn tableColumn: NSTableColumn?, row: Int)
    {
        //dataArray[row].setObject(object!, forKey: (tableColumn?.identifier)!)
    }
    
}

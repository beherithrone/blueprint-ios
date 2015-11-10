//
//  AwsViewController.swift
//  App-iOS
//
//  Created by Pavel Jacko on 09/11/2015.
//  Copyright © 2015 Syerit Limited. All rights reserved.
//

import UIKit
import RealmSwift
import AWSDynamoDB

class AwsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    
    var tableRows:Array<Template1TableRow>?
    var lock:NSLock?
    var lastEvaluatedKey:[NSObject : AnyObject]!
    var  doneLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Setup Reveal Menu
        //{
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = "revealToggle:"
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        //}
        
        tableRows = []
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func populateDataClicked(sender: AnyObject) {
        generateTestData()
    }

    @IBAction func refreshClicked(sender: AnyObject) {
        refreshList(true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableRows!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func generateTestData() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.defaultDynamoDBObjectMapper()
        
        let tasks = NSMutableArray()
        
        for var i = 0; i < 25; i++ {
            let tableRow = Template1TableRow();
            tableRow.id = "id \(i)"
            tableRow.desc = "Lorem ipsum \(i)";
            tableRow.value = i * 10;
            tableRow.imageUrl = "http://loremflickr.com/240/320"
            
            tasks.addObject(dynamoDBObjectMapper.save(tableRow))
        }
        
        AWSTask(forCompletionOfAllTasks: tasks as [AnyObject]) .continueWithExecutor(AWSExecutor.mainThreadExecutor(), withBlock: { (task:AWSTask!) -> AnyObject! in
            if ((task.error) != nil) {
                print("Error: \(task.error)")
            }
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            
            //self.refreshList(true)
            return nil
        })
    }
    
    func refreshList(startFromBeginning: Bool) {
        
        if startFromBeginning {
            self.lastEvaluatedKey = nil;
            self.doneLoading = false
        }
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.defaultDynamoDBObjectMapper()
        let queryExpression = AWSDynamoDBScanExpression()
        queryExpression.exclusiveStartKey = self.lastEvaluatedKey
        queryExpression.limit = 20;
        dynamoDBObjectMapper.scan(Template1TableRow.self, expression: queryExpression).continueWithExecutor(AWSExecutor.mainThreadExecutor(), withBlock: { (task:AWSTask!) -> AnyObject! in
            
            if self.lastEvaluatedKey == nil {
                self.tableRows?.removeAll(keepCapacity: true)
            }
            
            if task.result != nil {
                let paginatedOutput = task.result as! AWSDynamoDBPaginatedOutput
                for item in paginatedOutput.items as! [Template1TableRow] {
                    self.tableRows?.append(item)
                }
                
                self.lastEvaluatedKey = paginatedOutput.lastEvaluatedKey
                if paginatedOutput.lastEvaluatedKey == nil {
                    self.doneLoading = true
                }
            }
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            self.tableView.reloadData()
            
            if ((task.error) != nil) {
                print("Error: \(task.error)")
            }
            return nil
        })
    }

}

class Template1TableRow :AWSDynamoDBObjectModel ,AWSDynamoDBModeling  {
    
    var id:String?
    var value:NSNumber?
    var desc:String?
    var imageUrl:String?
    
    class func dynamoDBTableName() -> String! {
        return "Template3"
    }
    
    class func hashKeyAttribute() -> String! {
        return "id"
    }
    
    class func rangeKeyAttribute() -> String! {
        return "value"
    }
    
    //MARK: NSObjectProtocol hack
    override func isEqual(object: AnyObject?) -> Bool {
        return super.isEqual(object)
    }
    
    override func `self`() -> Self {
        return self
    }
}


//
//  AwsViewController.swift
//  App-iOS
//
//  Created by Pavel Jacko on 09/11/2015.
//  Copyright © 2015 Syerit Limited. All rights reserved.
//

import UIKit
import RealmSwift

class AwsViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func populateDataClicked(sender: AnyObject) {
        
    }

    @IBAction func refreshClicked(sender: AnyObject) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

/*class Template1TableRow :AWSDynamoDBObjectModel ,AWSDynamoDBModeling  {
    
    var id:String?
    var value:String?
    //var value:NSNumber?
    //var desc:String? = "Lorem ipsum"
    
    class func dynamoDBTableName() -> String! {
        return "Template1"
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
}*/


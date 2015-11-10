//
//  LoginViewController.swift
//  App-iOS
//
//  Created by Pavel Jacko on 09/11/2015.
//  Copyright © 2015 Syerit Limited. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import FBSDKShareKit

class LoginViewController: UIViewController/*, FBSDKLoginButtonDelegate*/ {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var fbLoginButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    private let loader = FacebookUserLoader()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
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
        
        /*
        //Facebook
        
        let token : FBSDKAccessToken? = FBSDKAccessToken.currentAccessToken()
        
        if(token != nil) {
            
        } else {
            let button = FBSDKLoginButton()
            button.center = self.view.center;
            button.delegate = self
            self.view.addSubview(button)
        }
        */
        
        
        
        
    }
    @IBAction func fbButtonClicked(sender: AnyObject) {
        textView.text = ""
        
        loader.load(askEmail: true, onError: { [weak self] in
            self?.textView.text = "Error occured"
            },
            onSuccess: { [weak self] user in
                self?.onUserLoaded(user)
            })
    }
    
    private func onUserLoaded(user: TegFacebookUser) {
        var fields = ["User id: \(user.id)"]
        
        if let name = user.name {
            fields.append("Name: \(name)")
        }
        
        if let email = user.email {
            fields.append("Email: \(email)")
        }
        
        fields.append("Access token: \(user.accessToken)")
        
        let outputText = "\n\n" + fields.joinWithSeparator(".")
        
        textView.text = outputText
        print(outputText)
    }

    
    
    /*func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        let token : FBSDKAccessToken? = FBSDKAccessToken.currentAccessToken()
        
        
    }
    
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
    }*/
    

}

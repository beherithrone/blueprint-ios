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
import Google

class LoginViewController: UIViewController/*, FBSDKLoginButtonDelegate*/, GIDSignInDelegate {

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
        
        
        GIDSignIn.sharedInstance().delegate = self
        
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
    
    // [START signin_handler]
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
        withError error: NSError!) {
            if (error == nil) {
                // Perform any operations on signed in user here.
                let userId = user.userID                  // For client-side use only!
                let idToken = user.authentication.idToken // Safe to send to the server
                let name = user.profile.name
                let email = user.profile.email
                // [START_EXCLUDE]
                NSNotificationCenter.defaultCenter().postNotificationName(
                    "ToggleAuthUINotification",
                    object: nil,
                    userInfo: ["statusText": "Signed in user:\n\(name)"])
                // [END_EXCLUDE]
            } else {
                print("\(error.localizedDescription)")
                // [START_EXCLUDE silent]
                NSNotificationCenter.defaultCenter().postNotificationName(
                    "ToggleAuthUINotification", object: nil, userInfo: nil)
                // [END_EXCLUDE]
            }
    }
    // [END signin_handler]
    
    // [START disconnect_handler]
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
        withError error: NSError!) {
            // Perform any operations when the user disconnects from app here.
            // [START_EXCLUDE]
            NSNotificationCenter.defaultCenter().postNotificationName(
                "ToggleAuthUINotification",
                object: nil,
                userInfo: ["statusText": "User has disconnected."])
            // [END_EXCLUDE]
    }
    // [END disconnect_handler]
    

}

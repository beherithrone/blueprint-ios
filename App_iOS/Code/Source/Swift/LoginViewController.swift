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
import Core_iOS

class LoginViewController: UIViewController/*, FBSDKLoginButtonDelegate*/, GIDSignInDelegate, GIDSignInUIDelegate {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var fbLoginButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    var appModel : AppModel?
    
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
        
        //Google
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
        
        let gButton = GIDSignInButton()
        gButton.center = self.view.center
        self.view.addSubview(gButton)
        
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
        appModel!.userFacebook = UserInfo(id: user.id, name: user.name!, email: user.email, token: user.accessToken)
        
        populateText(appModel!.userFacebook!)
    }
    
    func populateText(user : UserInfo) -> Void {
        var fields = ["User id: \(user.id)"]
        
        fields.append("Name: \(user.name)")
        
        fields.append("Email: \(user.email)")
        
        fields.append("Access token: \(user.token)")
        
        let outputText = "\n\n" + fields.joinWithSeparator(".")
        
        textView.text = outputText
        print(outputText)
    }
    
    // [START signin_handler]
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
        withError error: NSError!) {
            if (error == nil) {
                appModel!.userGoogle = UserInfo(id: user.userID, name: user.profile.name, email: user.profile.email, token: user.authentication.idToken)
                
                // [START_EXCLUDE]
                NSNotificationCenter.defaultCenter().postNotificationName(
                    "ToggleAuthUINotification",
                    object: nil,
                    userInfo: ["statusText": "Signed in user:\n\(appModel!.userGoogle!.name)"])
                // [END_EXCLUDE]
                
                populateText(appModel!.userGoogle!)
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
    

    
    // pressed the Sign In button
    func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
        //myActivityIndicator.stopAnimating()
    }
    
    // Present a view that prompts the user to sign in with Google
    func signIn(signIn: GIDSignIn!,
        presentViewController viewController: UIViewController!) {
            self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func signIn(signIn: GIDSignIn!,
        dismissViewController viewController: UIViewController!) {
            self.dismissViewControllerAnimated(true, completion: nil)
    }
}

//
//  LoginVC.swift
//  FinalProject
//
//  Created by Drashti Akbari on 2020-04-18.
//  Copyright © 2020 Drashti Akbari. All rights reserved.
//

import UIKit
import Google
import GoogleSignIn

class LoginVC: UIViewController, GIDSignInDelegate  {
    
    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var error : NSError?
        GGLContext.sharedInstance().configureWithError(&error)
        if error != nil {
            print(error ?? "some error")
            return
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if error != nil {
            print(error ?? "some error")
            return
        }
        else
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "FirstPageVC") as! FirstPageVC
            self.navigationController?.pushViewController(controller, animated: true)
            let fullName = user.profile.name
            let logintype = "google"
            UserDefaults.standard.set(fullName, forKey: "username")
            UserDefaults.standard.set(logintype, forKey: "logintype")
            UserDefaults.standard.synchronize()
        }
    }
    
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func btn_googleSignIn(_ sender: Any) {
        GIDSignIn.sharedInstance().delegate=self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
    }
}

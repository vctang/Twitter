//
//  LoginViewController.swift
//  Twitter
//
//  Created by Vicky Tang on 2/21/17.
//  Copyright © 2017 Vicky Tang. All rights reserved.
//  TODO: Make sure favorite/rewteet can only be pressed once/decremented. Make profile pictures rounded corner

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLoginButton(_ sender: Any) {
        TwitterClient.sharedInstance?.login(success: { () -> () in
            self.performSegue(withIdentifier: "loginSegue", sender: self)
        }) {(error: Error) -> () in
            print("error: \(error.localizedDescription)")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

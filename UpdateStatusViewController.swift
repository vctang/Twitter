//
//  UpdateStatusViewController.swift
//  Twitter
//
//  Created by Vicky Tang on 3/6/17.
//  Copyright © 2017 Vicky Tang. All rights reserved.
//

import UIKit

class UpdateStatusViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetImageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var sendTweetButton: UIBarButtonItem!
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLabel.text = tweet.user?.name as String?
        self.usernameLabel.text = "@\((tweet.user?.screenname as String?)!)"
        
        if let profileURL = tweet.user?.profileUrl{
            self.tweetImageView.setImageWith(profileURL as URL)
        }
        
        self.textView.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTweetPressed(_ sender: Any) {
        let userID = tweet.user?.userID as String?
        TwitterClient.sharedInstance!.statusUpdate(id: (tweet.id), tweetStatus: self.textView.text, tweetID: userID!, success: {
            _ = self.navigationController?.popToRootViewController(animated: true)
        }, failure: { (error) in
            print("Error: \(error.localizedDescription)")
        })
        
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

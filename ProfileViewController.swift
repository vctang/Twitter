//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Vicky Tang on 3/5/17.
//  Copyright © 2017 Vicky Tang. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // TOP
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var tweetImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var tweetButton: UIBarButtonItem!
    
    // BOTTOM
    @IBOutlet weak var tweetTableView: UITableView!
    
    var tweets: [Tweet]!
    var tweet: Tweet!
    var dictionary: NSDictionary!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TOP
        self.nameLabel.text = tweet.user?.name as String?
        self.usernameLabel.text = "@\((tweet.user?.screenname as String?)!)"
        self.tweetCountLabel.text = "\((tweet.user?.numTweets)!)"
        self.followersCountLabel.text = "\((tweet.user?.followers)!)"
        self.followingCountLabel.text = "\((tweet.user?.following)!)"
        
        if let profileURL = tweet.user?.profileUrl{
            self.tweetImageView.setImageWith(profileURL as URL)
        }

        if let backgroundURL = tweet.user?.backgroundURL{
            self.backgroundView.setImageWith(backgroundURL as URL)
        }
        
        // BOTTOM
        self.tweetTableView.dataSource = self
        self.tweetTableView.delegate = self
        
        tweetTableView.rowHeight = UITableViewAutomaticDimension
        tweetTableView.estimatedRowHeight = 120
        
        TwitterClient.sharedInstance?.userTimeLine(success: { ( tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tweetTableView.reloadData()
        }, failure: { (error: Error) -> () in
            print(error.localizedDescription)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ProfileToTweetSegue"){
            let detailViewController = segue.destination as! UpdateStatusViewController
            detailViewController.tweet = tweet
        }
    }
    
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tweetTableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileTableViewCell
        cell.tweetData = self.tweets?[indexPath.row] ?? nil
        return cell
    }
}

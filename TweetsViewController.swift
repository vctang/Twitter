//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Vicky Tang on 2/23/17.
//  Copyright © 2017 Vicky Tang. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {

    @IBOutlet weak var tweetsTableView: UITableView!
    
    var tweets: [Tweet]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tweetsTableView.dataSource = self
        self.tweetsTableView.delegate = self
        
        tweetsTableView.rowHeight = UITableViewAutomaticDimension
        tweetsTableView.estimatedRowHeight = 120

        TwitterClient.sharedInstance?.homeTimeLine(success: { ( tweets: [Tweet]) -> () in
            self.tweets = tweets
            /*for tweet in tweets {
                print(tweet.text!)
            }*/
            self.tweetsTableView.reloadData()
        }, failure: { (error: Error) -> () in
            print(error.localizedDescription)
        })
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButton(_ sender: Any) {
        TwitterClient.sharedInstance!.logout()
    }

    // Deselect tableView cell
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.tweetsTableView.indexPathForSelectedRow{
            self.tweetsTableView.deselectRow(at: index, animated: true)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "CellToProfileSegue"){
            let button = sender as! UIButton
            let cell = button.superview?.superview as! UITableViewCell
            let indexPath = tweetsTableView.indexPath(for: cell);
            let tweet = self.tweets![(indexPath?.row)!]
            
            let detailViewController = segue.destination as! ProfileViewController
            detailViewController.tweet = tweet
            detailViewController.user = tweet.user
        } else if(segue.identifier == "CellToDetailSegue"){
            let cell = sender as! UITableViewCell
            let indexPath = tweetsTableView.indexPath(for: cell);
            let tweet = self.tweets![(indexPath?.row)!]
            
            let detailViewController = segue.destination as! TweetDetailsViewController
            detailViewController.tweet = tweet
        } else if (segue.identifier == "CellToTweetSegue") {
            let button = sender as! UIButton
            let cell = button.superview?.superview as! UITableViewCell
            let indexPath = tweetsTableView.indexPath(for: cell);
            let tweet = self.tweets![(indexPath?.row)!]
            
            let detailViewController = segue.destination as! UpdateStatusViewController
            detailViewController.tweet = tweet
        }
    }
    

}

extension TweetsViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.tweets?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tweetsTableView.dequeueReusableCell(withIdentifier: "TweetsTableCell", for: indexPath) as! TweetsTableViewCell
        cell.tweetData = self.tweets?[indexPath.row] ?? nil
        return cell
    }
}

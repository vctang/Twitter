//
//  TweetDetailsViewController.swift
//  Twitter
//
//  Created by Vicky Tang on 2/28/17.
//  Copyright © 2017 Vicky Tang. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {

    @IBOutlet weak var tweetImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweet: Tweet!
    
    func formatDate(dates: Date) -> String {
        let currentCalendar = Calendar.current
        let currentTimer = Date()
        let flags: NSCalendar.Unit =
            [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
        let components = (currentCalendar as NSCalendar).components(flags, from: dates,to: currentTimer, options: [])
        
        if let year = components.year, year >= 2 {
            return "\(year)y"
        }
        
        if let year = components.year, year >= 1 {
            return "Last year"
        }
        
        if let month = components.month, month >= 2{
            return "\(month)m"
        }
        
        if let month = components.month, month >= 1 {
            return "Last month"
        }
        
        if let week = components.weekOfYear, week >= 2 {
            return "\(week)w"
        }
        
        if let week = components.weekOfYear, week >= 1{
            return "Last week"
        }
        
        if let day = components.day, day >= 1 {
            return "\(day)d"
        }
        
        if let hour = components.hour, hour >= 1{
            return "\(hour)h"
        }
        
        if let minute = components.minute, minute >= 1{
            return "\(minute)m"
        }
        
        if let second = components.second, second >= 1{
            return "\(second)s"
        }
        
        return "Now"
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameLabel.text = tweet.user?.name as String?
        self.usernameLabel.text = tweet.user?.screenname as String?
    // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

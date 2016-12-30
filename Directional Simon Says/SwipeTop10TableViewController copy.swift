//
//  SwipeTop10TableViewController.swift
//  Directional Simon Says
//
//  Created by Deanna Yee on 12/10/16.
//  Copyright © 2016 cisstudent. All rights reserved.
//

//import Foundation
import UIKit

class SwipeTop10TableViewController: UITableViewController {
    
    //Score Store object
    var scoreStore: ScoreStore!
    var scoresCount: Int = 0
    
    //Only shows the top 10 scores
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if scoreStore.topTenSwipeScores.count < 10{
            scoresCount = scoreStore.topTenSwipeScores.count
        }
        else{
            scoresCount = 10
        }
        return scoresCount
    }
    
    //Displays the scores into the table
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //Create an instance of UITableViewCell, with default appearance
        //let cell = tableView.dequeueReusableCellWithIdentifier("ScoreCell", forIndexPath: indexPath) as! ScoreCell
        let cell = tableView.dequeueReusableCellWithIdentifier("ScoreCell", forIndexPath: indexPath) as! ScoreCell
        
        //Set the text on the cell with the description of the item
        //That is at the nth index of items, where n = row this cell
        //well appear in on the tableview
        if scoreStore.topTenSwipeScores.count != 0 {
            let score = scoreStore.topTenSwipeScores[indexPath.row]
            cell.nameLabel.text = score.name
            cell.rankLabel.text = "\(score.rank)"
            cell.scoreLabel.text = "\(score.score)"
        }
        return cell
    }
    
    //passes the score store back to the main menu
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "MainMenu" {
            let mainViewController = segue.destinationViewController as! MainMenuViewController
            mainViewController.scoreStore = scoreStore
        }
        
    }
    
    
    //Allows for scrolling and makes the row height to be 60
    override func viewDidLoad() {
        super.viewDidLoad()
        if (self.tabBarController != nil){
            let tbvc = self.tabBarController as! ScoreTabBarController
            scoreStore = tbvc.scoreStore
        }
        
        let height = UIApplication.sharedApplication().statusBarFrame.height
        
        let insets = UIEdgeInsets(top: height, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        tableView.rowHeight = 60
    }
    
}

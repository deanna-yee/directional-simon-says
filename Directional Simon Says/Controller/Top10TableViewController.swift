//
//  TapTop10TableViewController.swift
//  Directional Simon Says
//
//  Created by Deanna Yee on 12/10/16.
//  Copyright © 2016 cisstudent. All rights reserved.
//

//import Foundation
import UIKit

class Top10TableViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource {
    //Score Store object
    var scoreStore: ScoreStore!
    var scoresCount: Int = 0
    
    //Only shows the top 10 scores
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if scoreStore.topTenTapScores.count < 10{
            scoresCount = scoreStore.topTenTapScores.count
        }
        else{
            scoresCount = 10
        }
        return scoresCount
    }
    
    //Displays the scores into the table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Create an instance of UITableViewCell, with default appearance
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath) as! ScoreCell
            
        //Set the text on the cell with the description of the item
        //That is at the nth index of items, where n = row this cell
        //well appear in on the tableview
        let score = scoreStore.topTenTapScores[indexPath.row]
        cell.updateCell(score: score)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    //passes the score store back to the main menu
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Main" {
            let mainViewController = segue.destination as! MainMenuViewController
            mainViewController.scoreStore = scoreStore
        }
        
    }
    
    
    //Allows for scrolling and makes the row height to be 60
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.tabBarController != nil{
            let tbvc = self.tabBarController as! ScoreTabBarController
            scoreStore = tbvc.scoreStore
        }
    }
    
}

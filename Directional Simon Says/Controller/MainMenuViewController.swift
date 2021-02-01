//
//  MainMenuViewController.swift
//  Directional Simon Says
//
//  Created by Deanna Yee on 12/9/16.
//  Copyright © 2016 cisstudent. All rights reserved.
//

//import Foundation
import UIKit

class MainMenuViewController: UIViewController {
    
    //scoreStore for the whole application
    var scoreStore : ScoreStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreStore.updateScoresLists()
    }
 
    //passes the store to the table or to the tap simon says controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "scores" {
            let topTenViewController = segue.destination as!
                Top10TableViewController
            topTenViewController.scoreStore = scoreStore
        }
        else if segue.identifier == "tap" || segue.identifier == "swipe"{
            let simonSaysViewController = segue.destination as! SimonSaysViewController
            simonSaysViewController.scoreStore = scoreStore
            simonSaysViewController.gameType = segue.identifier
        }
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
    }
    
}

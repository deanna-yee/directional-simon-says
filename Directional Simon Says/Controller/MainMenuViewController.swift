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
    }
 
    
    
    //passes the store to the table or to the tap simon says controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "scores" {
            let topTenViewController = segue.destination as!
                ScoreTabBarController
            topTenViewController.scoreStore = scoreStore
        }
        else if segue.identifier == "Tap" || segue.identifier == "Swipe"{
            let simonSaysViewController = segue.destination as! SimonSaysViewController
            simonSaysViewController.scoreStore = scoreStore
            if segue.identifier == "Tap"{
                simonSaysViewController.gameType = "Tap"
            }else{
                simonSaysViewController.gameType = "Swipe"
            }
        }
       
        
        
        
    }
    
    
    
}

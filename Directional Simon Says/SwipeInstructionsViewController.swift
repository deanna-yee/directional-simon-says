//
//  SwipeInstructionsViewController.swift
//  Directional Simon Says
//
//  Created by Deanna Yee on 1/4/17.
//  Copyright © 2017 cisstudent. All rights reserved.
//

//import Foundation
import UIKit

class SwipeInstructionsViewController: UIViewController{
  
    var scoreStore: ScoreStore!
    
    //passes the score store back to the main menu
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "swipeToMain" {
            let mainViewController = segue.destination as! MainMenuViewController
            mainViewController.scoreStore = scoreStore
        }
        
    }
    
    
    //Allows for scrolling and makes the row height to be 60
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.tabBarController != nil{
            let tbvc = self.tabBarController as! InstructionsTabBarController
            scoreStore = tbvc.scoreStore
        }
    }
}

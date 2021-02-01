//
//  InstructionViewController.swift
//  Directional Simon Says
//
//  Created by Deanna Yee on 1/31/21.
//

import UIKit

class InstructionViewController: UIViewController {
    
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var selectionControl: UISegmentedControl!
    
    let instructions : [String] = ["Watch the pattern that is displayed on the screen. Once the game says 'Your Turn'. Tap the arrows in the same pattern that was displayed on the screen. Repeat the steps until the game says 'Game Over'. Once the game is over tap the continue button to go to the next screen.'",
        "Watch the pattern that is displayed on the screen. Once the game says 'Your Turn'. Swipe the arrows in the direction it is pointing in the same pattern that was displayed on the screen. Repeat the steps until the game says 'Game Over'. Once the game is over tap the continue button to go to the next screen."]

    override func viewDidLoad() {
        super.viewDidLoad()
        instructionLabel.text = instructions[selectionControl.selectedSegmentIndex]
        // Do any additional setup after loading the view.
    }
    
    @IBAction func goToMainMenu(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func switchInstructions(_ sender: UISegmentedControl) {
        instructionLabel.text = instructions[sender.selectedSegmentIndex]
    }
    
}

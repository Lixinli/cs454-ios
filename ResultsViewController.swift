//
//  ResultsViewController.swift
//  roshambo
//
//  Created by Li, Xinli on 6/30/16.
//  Copyright (c) 2016 Li, Xinli. All rights reserved.
//

import UIKit
var numbers: [Int] = [0, 0, 0]
enum Shape: String {
    case Rock = "Rock"
    case Paper = "Paper"
    case Scissors = "Scissors"
    
    // This function randomly generates an opponent's play
    static func randomShape() -> Shape {
        let shapes = ["Rock", "Paper", "Scissors"]
        let randomChoice = Int(arc4random_uniform(3))
        return Shape(rawValue: shapes[randomChoice])!
    }
}

class ResultsViewController: UIViewController {
    
   
    @IBOutlet weak var resultImage: UIImageView!
    
    @IBOutlet weak var resultLabel: UILabel!
    //rock:0, paper:1, scissor:2
    
    // MARK: Shapes
    
    // When the ResultsViewController is initialized a userChoice is passed in and an opponent's play is generated.
    var userChoice: Shape!
    private let opponentChoice: Shape = Shape.randomShape()
    
    // MARK: -
    // MARK: View Lifecycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        displayResult()
    }
    // The displayResult method generates the image and message for the results of a match.
    private func displayResult() {
        // Ideally, most of this would be handled by a model.
        var imageName: String
        var text: String
        let matchup = "\(userChoice.rawValue) vs. \(opponentChoice.rawValue)"
        
        // Why is an exclamation point necessary? :)
        switch (userChoice!, opponentChoice) {
        case let (user, opponent) where user == opponent:
            text = "\(matchup): it's a tie!"
            imageName = "tie"
        case (.Rock, .Scissors), (.Paper, .Rock), (.Scissors, .Paper):
            text = "You win with \(matchup)!"
            imageName = "\(userChoice.rawValue)-\(opponentChoice.rawValue)"
        default:
            text = "You lose with \(matchup) :(."
            imageName = "\(opponentChoice.rawValue)-\(userChoice.rawValue)"
        }
        
        switch (userChoice!) {
        case let (user) where user == .Rock:
            numbers[0]+=1
        default:
            numbers[2]+=1
        }
        
        imageName = imageName.lowercaseString
        
        print(numbers[0])
        
        resultImage.image = UIImage(named: imageName)
        resultLabel.text = text
    }
    
    @IBAction private func playAgain() {
        dismissViewControllerAnimated(true, completion: nil)
    }


}

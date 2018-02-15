//
//  ViewController.swift
//  Walk of Fame (based on Apple Pie)
//
//  Created by Alex Witkamp on 15-02-18.
//  Copyright © 2018 Alex Witkamp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // define the names of the game
    var listOfWords = ["Tom Hanks", "Harrison Ford", "Dwayne Johnson", "Michael Keaton", "Cameron Diaz", "Johnny Depp", "Jamie Foxx", "Reese Witherspoon", "Daniel Radcliffe", "James Franco", "Ryan Reynolds"]
    
    // define the rules of the game
    let incorrectMovesAllowed = 5
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLoses = 0 {
        didSet {
            newRound()
        }
    }
    
    // walk of fame image and labels outlets
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    // contains all letters in a outlet collection
    @IBOutlet var letterButtons: [UIButton]!
    
    // define what happens when a letter is pressed
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        // disable letter after press
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        //let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letterString)
        updateGameState()
    }
    
    var currentGame: Game!
    
    // start a new game round by loading word and update UI
    func newRound() {
        for button in letterButtons {
            button.layer.cornerRadius = 10
            button.clipsToBounds = true
        }
        
        // perform when actors are not yet guessed
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        }
        else {
            enableLetterButtons(false)
        }
    }
    
    // enables all the buttons in new round
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    // updates UI and game score
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLoses += 1
            updateUI()
        }
        else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
            updateUI()
        }
        else {
            updateUI()
        }
    }
    
    // update the labels and walk of fame image
    func updateUI() {
        scoreLabel.text = "wins: \(totalWins), Loses: \(totalLoses)"
        treeImageView.image = UIImage(named: "walk \(currentGame.incorrectMovesRemaining)")
        
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // begin new round at start
        newRound()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


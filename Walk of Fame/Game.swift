//
//  Game.swift
//  Walk of Fame (based on Apple Pie)
//
//  Created by Alex Witkamp on 15-02-18.
//  Copyright © 2018 Alex Witkamp. All rights reserved.
//

import Foundation

// the struct for each game containing the word and the guessed letters
struct Game {
    var word: String
    var incorrectMovesRemaining: Int
    var guessedLetters: [Character]
    
    mutating func playerGuessed(letter: String) {
        
        // add both upper and lower case to letters
        guessedLetters.append(Character(letter.lowercased()))
        guessedLetters.append(Character(letter.uppercased()))
        
        // if the character is not in word, decrement moves remaining
        if !word.contains(Character(letter.lowercased())) && !word.contains(Character(letter.uppercased())) {
            incorrectMovesRemaining -= 1
        }
    }
    
    var formattedWord: String {
        var guessedWord = ""
        
        for letter in word {
            
            // add letter to guessedWord string
            if guessedLetters.contains(letter) {
                guessedWord += "\(letter)"
            }
                
            // ignore spaces in name of actor
            else if letter == " " {
                guessedWord += " "
            }
                
            // add space if letter or space in other case
            else {
                guessedWord += "_"
            }
        }
        return guessedWord
    }
}


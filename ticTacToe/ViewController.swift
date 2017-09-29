//
//  ViewController.swift
//  ticTacToe
//
//  Created by C4Q  on 9/27/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var brain = ticTacToeBrain()
    
    @IBOutlet weak var ticTacToeView: UIView!
    @IBOutlet weak var gameInfoLabel: UILabel!
    
    @IBAction func ticTacToeButtonPressed(_ sender: GameButton) {
        switch brain.didSelectPosition(row: sender.row, column: sender.column) {
        case .playerOneCompletedMove:
            sender.setTitle("X", for: .normal)
            gameInfoLabel.text = "Player Two's Turn"
        case .playerTwoCompletedMove:
            sender.setTitle("O", for: .normal)
            gameInfoLabel.text = "Player One's Turn"
        case .invalidMove:
            gameInfoLabel.text = "You can't move there!  It's still " + (gameInfoLabel.text)!
        case .gameOver(let winner):
            lockBoard()
            switch winner {
            case .playerOneVictory:
                gameInfoLabel.text = "Player One Wins!"
            case .playerTwoVictory:
                gameInfoLabel.text = "Player Two Wins"
            case .catsGame:
                gameInfoLabel.text = "Cat's Game!"
            }
        }
    }
    
    @IBAction func newGameButtonPressed(_ sender: UIButton) {
        resetBoard()
    }
    func lockBoard() {
        toggleButtons(.disabled)
    }
    func resetBoard() {
        toggleButtons(.blank)
        brain = ticTacToeBrain()
        gameInfoLabel.text = "Player One's Turn!"
    }
    enum NewButtonState {
        case disabled, blank
    }
    func toggleButtons(_ state: NewButtonState) {
        for view in ticTacToeView.subviews {
            if let button = view as? UIButton {
                button.isEnabled = state == .disabled
                button.setTitle(state == .blank ? "" : button.currentTitle!, for: .normal)
            }
        }
    }
}


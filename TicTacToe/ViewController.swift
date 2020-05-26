//
//  ViewController.swift
//  TicTacToe
//
//  Created by Xenia Sidorova on 15.04.2020.
//  Copyright © 2020 Xenia Sidorova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var First: UIButton!
    @IBOutlet weak var second: UIButton!
    @IBOutlet weak var third: UIButton!
    @IBOutlet weak var fourth: UIButton!
    @IBOutlet weak var fifth: UIButton!
    @IBOutlet weak var sixth: UIButton!
    @IBOutlet weak var seventh: UIButton!
    @IBOutlet weak var eighth: UIButton!
    @IBOutlet weak var nineth: UIButton!
    @IBOutlet weak var player: UILabel!
    @IBOutlet weak var newGame: UIButton!
    @IBOutlet weak var exit: UIButton!
    
    func newGameStarted () {
        for button in gameFieldsList() {
            button.setImage(nil, for: .normal)
            button.isEnabled = true
        }
        
        sessionState = State(currentState: true)
        fieldsMap = []
        playerTurn()
        newGame.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newGame.isHidden = true
    }

    let christ = UIImage(named: "christ.png")
    let circle = UIImage(named: "circle.png")
    var sessionState = State(currentState: true)
    var fieldsMap : [Field] = []
    
    struct State {
        var currentState : Bool
        mutating func change() {
            self.currentState = !currentState
        }
    }

    struct Field {
        let line: Int
        let column: Int
        var image: UIImage?
    }
    

    @IBAction func FirstFieldPressed(_ sender: UIButton) {
        round(
            sender,
            field: Field(line: 1, column: 1, image: currentImage())
        )
    }
    @IBAction func secondFieldPressed(_ sender: UIButton) {
        round(
            sender,
            field: Field(line: 1, column: 2, image: currentImage())
        )
    }
    @IBAction func thirdFieldPressed(_ sender: UIButton) {
        round(
            sender,
            field: Field(line: 1, column: 3, image: currentImage())
        )
    }
    @IBAction func fourthFieldPressed(_ sender: UIButton) {
        round(
            sender,
            field: Field(line: 2, column: 1, image: currentImage())
        )
    }
    @IBAction func fifthFieldPressed(_ sender: UIButton) {
        round(
            sender,
            field: Field(line: 2, column: 2, image: currentImage())
        )
    }
    @IBAction func sixthFieldPressed(_ sender: UIButton) {
        round(
            sender,
            field: Field(line: 2, column: 3, image: currentImage())
        )
    }
    @IBAction func seventhFieldPressed(_ sender: UIButton) {
        round(
            sender,
            field: Field(line: 3, column: 1, image: currentImage())
        )
    }
    @IBAction func eighthFieldPressed(_ sender: UIButton) {
        round(
            sender,
            field: Field(line: 3, column: 2, image: currentImage())
        )
    }
    @IBAction func ninethFieldPressed(_ sender: UIButton) {
        round(
            sender,
            field: Field(line: 3, column: 3, image: currentImage())
        )
    }
    @IBAction func newGameAction(_ sender: Any) {
        newGameStarted()
        
    }
    @IBAction func exitPressed(_ sender: Any) {
        Darwin.exit(0)
    }
    
    func round(_ button: UIButton, field: Field) {
        button.setImage(field.image, for: .normal)
        button.isEnabled = false
        fieldsMap.append(field)

        if isVictory() {
            player.text = "\(currentPlayer()) WON!"
            newGame.isHidden = false
            for button in gameFieldsList() {
                button.isEnabled = false
            }
        } else if isDraw() {
            player.text = "It's draw!"
            newGame.isHidden = false
            for button in gameFieldsList() {
                button.isEnabled = false
            }
        } else {
            sessionState.change()
            playerTurn()
        }
    }
    
    func playerTurn() {
        player.text = currentPlayer()
    }

    func currentPlayer() -> String {
        sessionState.currentState ? "1st player" : "2nd player"
    }
        
    private func gameFieldsList () -> [UIButton] {
      return [First, second, third, fourth, fifth, sixth, seventh, eighth, nineth]
    }

    private func currentImage() -> UIImage? {
        sessionState.currentState ? christ : circle
    }
        
    private func isDraw() -> Bool {
        let totalFieldsCount = 9
        return fieldsMap.count == totalFieldsCount
    }
        
    private func isVictory() -> Bool {
        let currentPlayerFields = fieldsMap.filter{$0.image == currentImage()}

        guard currentPlayerFields.count > 2 else { return false }

        for field in currentPlayerFields {
            if currentPlayerFields.filter({$0.line == field.line}).count == 3 {
                return true
            }
            if currentPlayerFields.filter({$0.column == field.column}).count == 3 {
                return true
            }
            if isMainDiagonal(currentPlayerFields) || isSideDiagonal(currentPlayerFields) {
                return true
            }
        }

        return false
    }

    private func isMainDiagonal(_ fieldsMap: [Field]) -> Bool {
        return isDiagonal(
            fieldsMap: fieldsMap,
            creteria: [Field(line: 1, column: 1), Field(line: 3, column: 3)]
        )
    }

    private func isSideDiagonal(_ fieldsMap: [Field]) -> Bool {
        return isDiagonal(
            fieldsMap: fieldsMap,
            creteria: [Field(line: 1, column: 3), Field(line: 3, column: 1)]
        )
    }

    private func isDiagonal(fieldsMap: [Field], creteria: [Field]) -> Bool {
        guard fieldsMap.contains(where: {$0.line == 2 && $0.column == 2}) else { return false }

        var sorted : [Field] = []
        for creterium in creteria {
            let maybeElement = fieldsMap.first(where: {$0.line == creterium.line && $0.column == creterium.column})
            if let elem = maybeElement { sorted.append(elem) }
        }

        return sorted.count == creteria.count
    }
}



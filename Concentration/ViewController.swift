//
//  ViewController.swift
//  Concentration
//
//  Created by Salvador Ariza on 11/20/17.
//  Copyright © 2017 Salvador Ariza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var flipCount = 0 {
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    var numberOfPairsOfCards: Int { return (cardButtons.count + 1)/2 }
    lazy var game = Concentration(withNumberOfPairs: numberOfPairsOfCards);
    
    @IBOutlet weak var gameStartButton: UIButton!
    @IBAction func resetGame(_ sender: UIButton) {
        game.resetGame()
        gameStartButton.alpha = 0;
        gameStartButton.isEnabled = false;
        flipCount = 0;
        updateViewWithModel()
    }
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender), cardButtons[cardNumber].backgroundColor != #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
            !game.cards[cardNumber].isFaceUp{
            
            flipCount += 1;
            game.chooseCard(at: cardNumber)
            updateViewWithModel()
        }
    }
    
    override func viewDidLoad() {
        gameStartButton.alpha = 0;
        gameStartButton.isEnabled = false;
    }
    
    func updateViewWithModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }else{
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        
        if (game.isDone()){
            print ("Game Over!")
            gameStartButton.alpha = 1;
            gameStartButton.isEnabled = true;
        }
    }
    
    var emojiChoices = ["👻","🎃","👿","☠️","👹","👺","🤡","👽","🤖", "🧟‍♂️", "🧟‍♀️", "🧛‍♀️"]
    var emoji = [Int:String]()
    func emoji(for card: Card ) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
//        if (emoji[card.identifier] != nil ){
//            return emoji[card.identifier]!
//        }else{
//            return "?"
//        }
        return emoji[card.identifier] ?? "?"
    }
}


//
//  Concentration.swift
//  Concentration
//
//  Created by Salvador Ariza on 11/20/17.
//  Copyright © 2017 Salvador Ariza. All rights reserved.
//

import Foundation

struct Card{
    var isFaceUp = false;
    var isMatched = false;
    var identifier: Int;
    
    init(identifier: Int) {
        self.identifier = identifier
    }
}

class Concentration{
    lazy var cards = [Card]()
    var numberOfPairs: Int
    var pairsMatched = 0 {
        didSet {
            if (pairsMatched == numberOfPairs){
                gameIsDone = true
                print("Game Over!")
            }
        }
    }
    private var gameIsDone = false;
    
    func isDone() -> Bool {
        return gameIsDone;
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex:Int?;
            for i in cards.indices{
                if cards[i].isFaceUp{
                    if foundIndex == nil{
                        foundIndex = i
                    }else{
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set{
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    init (withNumberOfPairs number:Int){
        self.numberOfPairs = number;
        for identifier in 1...numberOfPairs{
            let card = Card(identifier: identifier)
            cards += [card, card]
        }
        
        print ("New Game: \(number) pairs loaded")
    }
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfTheOneAndOnlyFaceUpCard, matchIndex != index{
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    pairsMatched += 1;
                }
                cards[index].isFaceUp = true
            } else{
                indexOfTheOneAndOnlyFaceUpCard = index
            }
        }
    }
}

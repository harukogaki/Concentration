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
        for identifier in 1...number{
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
                }
                cards[index].isFaceUp = true
            } else{
                indexOfTheOneAndOnlyFaceUpCard = index
            }
        }
    }
}

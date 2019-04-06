//
//  PokerViewController.swift
//  pokerTwentyone
//
//  Created by Yolanda H. on 2019/3/30.
//  Copyright © 2019 Yolanda H. All rights reserved.
//

import UIKit

class PokerViewController: UIViewController {

    @IBOutlet weak var passButton: UIButton!
    @IBOutlet weak var dealButton: UIButton!
    @IBOutlet weak var pokerBack: UIImageView!
    @IBOutlet var pokers: [UIImageView]!
    @IBOutlet weak var resultLabel: UILabel!
    var numbers = ["1","2","3","4","5","6","7","8","9","10","11","12","13"]
    var suits = ["clubs","diamonds","hearts","spades"]
    var pokerImageName = ""
    var card:PokerCards?
    var cardArray = [PokerCards(Level: 1, Number: 1, PokerName: "clubs1", Suit: "clubs")]
    var z = 0
    var y = 5
    var k = 0
    var player = 0
    var playerA = 0
    var bank = 0
    var bankA = 0
    func pokerFunc()-> [PokerCards] {
        for i in 0 ..< suits.count {
            for j in 0 ..< numbers.count {
                pokerImageName = suits[i] + numbers[j]
                card = PokerCards(Level: i+1 , Number: j+1 , PokerName: pokerImageName, Suit: suits[i] )
                if let card = card {
                cardArray += [card]
                }
            }
        }
        cardArray.removeFirst()
        return cardArray
    }

    func dealOneFunc(){
        var playerPoint = cardArray[k].Number
        
        if cardArray[k].Number > 10 {
            playerPoint = 10
        }else if cardArray[k].Number == 1 {
            playerPoint = 11
            playerA += 1
        }
        
        player += playerPoint
       
        pokers[z].alpha = 1
        pokers[z].image = UIImage(named:cardArray[k].PokerName)
        k += 1
        
        
        if bank < 17 || bank < player, player <= 21 {
            var bankPoint = cardArray[k].Number
            if cardArray[k].Number > 10 {
               
                bankPoint = 10
            }else if cardArray[k].Number == 1 {
               
                bankPoint = 11
                bankA += 1
            }
            pokers[y].alpha = 1
            pokers[y].image = UIImage(named: cardArray[k].PokerName)
            bank += bankPoint
            
            k += 1
            y += 1
        }
        z += 1
        
    }
    func bustFunc(){
        
        if player > 21, playerA != 0 {
            player -= 10
            playerA -= 1
        }
        if bank > 21, bankA != 0 {
            bank -= 10
            bankA -= 1
        }
        
        if bank <= 21, player > 21{
            resultLabel.text = "Bust! you lost"
            resultLabel.textColor = UIColor.red
            dealButton.isHidden = true
            passButton.isHidden = true
            
        }else if bank > 21, player <= 21 {
            resultLabel.text = "you win!"
            resultLabel.textColor = UIColor.yellow
            dealButton.isHidden = true
            passButton.isHidden = true
        }else if bank > 21, player > 21{
            resultLabel.text = "Bust! you lost"
            resultLabel.textColor = UIColor.red
            dealButton.isHidden = true
            passButton.isHidden = true
        }else if player == 21, bank < 21 {
            resultLabel.text = "you win!"
            resultLabel.textColor = UIColor.yellow
            dealButton.isHidden = true
            passButton.isHidden = true
        }
        print("莊家分數"+String(bank))
        print("玩家分數"+String(player))
    }
    func resultFunc(){
        if player > 21, playerA != 0 {
            player -= 10
            playerA -= 1
        }
        if bank > 21, bankA != 0 {
            bank -= 10
            bankA -= 1
        }
        if player > 21{
            resultLabel.text = "Bust! you lost"
            resultLabel.textColor = UIColor.red
            dealButton.isHidden = true
            passButton.isHidden = true
        }else if player == 21 {
            if bank == player {
                resultLabel.text = "Push"
                resultLabel.textColor = UIColor.white
            }else {
                resultLabel.text = "you win!"
                resultLabel.textColor = UIColor.yellow
                dealButton.isHidden = true
                passButton.isHidden = true
            }
        }else if player < 21 {
            if player > bank {
                resultLabel.text = "you win!"
                resultLabel.textColor = UIColor.yellow
                dealButton.isHidden = true
                passButton.isHidden = true
            }else if player <= bank, bank <= 21 {
                resultLabel.text = "you lost"
                resultLabel.textColor = UIColor.white
                dealButton.isHidden = true
                passButton.isHidden = true
            }else if player <= bank, bank > 21 {
                resultLabel.text = "you win!"
                resultLabel.textColor = UIColor.yellow
                dealButton.isHidden = true
                passButton.isHidden = true
            }
        }
        print("莊家分數"+String(bank))
        print("玩家分數"+String(player))
    }
    func emptyFunc(){
        if k >= 51 {
            dealButton.isHidden = true
            passButton.isHidden = true
            k = 0
            pokerBack.alpha = 0
            resultLabel.text = "No cards!"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        cardArray = pokerFunc()
        cardArray.shuffle()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func dealFunc(_ sender: UIButton) {
        emptyFunc()
        if z < 4 {
                dealOneFunc()
            bustFunc()
            
        }else if z == 4 {
                dealOneFunc()
            resultFunc()
        }
        else {
            sender.isHidden = true
        }
        
    }
    @IBAction func passFunc(_ sender: UIButton) {
        emptyFunc()
       
            while bank < player {
                if player <= 21, z < 4, bank < 21, k < 51 {
                    var bankPoint = cardArray[k+1].Number
                    if cardArray[k+1].Number > 10 {
                        bankPoint = 10
                    }else if cardArray[k].Number == 1 {
                        bankPoint = 11
                        bankA += 1
                    }
                    
                    pokers[y].alpha = 1
                    pokers[y].image = UIImage(named: cardArray[k+1].PokerName)
                    y += 1
                    k += 1
                    bank += bankPoint
                }
            }
        
        resultFunc()
    }
    @IBAction func restarFunc(_ sender: UIButton) {
        for i in 0...9 {
            pokers[i].alpha = 0
        }
        
        dealButton.isHidden = false
        passButton.isHidden = false
        
        cardArray.shuffle()
        resultLabel.textColor = UIColor.black
        resultLabel.text = "Black Jack"
        z = 0
        y = 5
        player = 0
        bank = 0
        playerA = 0
        bankA = 0
        print( "剩餘張數" + String(k) )
        pokerBack.alpha = 1
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


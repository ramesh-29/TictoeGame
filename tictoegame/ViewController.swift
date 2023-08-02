//
//  ViewController.swift
//  tictoegame
//
//  Created by Ramesh Vishnoi on 31/07/23.
//

import UIKit

class ViewController: UIViewController {
    
    enum Turn {
        case Cross
        case Nought
    }
    
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var c3: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a1: UIButton!
    var firstTurn = Turn.Cross
    var currTurn = Turn.Cross
    var Nought = "O"
    var Cross = "X"
    var crossScore = 0
    var noughtScore = 0
    var board = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBoard()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func boardTapAction(_ sender: UIButton) {
        addToBoard(sender);
        if(winGameCheck(Cross))
        {
            crossScore +=  1
            resultAlert(title: "Crosses Win!")
        }
        if(winGameCheck(Nought))
        {
            noughtScore += 1
            resultAlert(title: "Noughts Win!")
        }
        if(fullBoard())
        {
            resultAlert(title: "Draw")
        }
        
    }
    
    func initBoard()
    {
        board.append(a1)
        board.append(a2)
        board.append(a3)
        board.append(b1)
        board.append(b2)
        board.append(b3)
        board.append(c1)
        board.append(c2)
        board.append(c3)
        
    }
    
    func addToBoard(_ sender: UIButton){
        if(sender.title(for: .normal) == nil)
        {
            if(currTurn == Turn.Cross){
                sender.setTitle(Cross, for: .normal)
                currTurn = Turn.Nought
                turnLabel.text = Nought
            }else if(currTurn == Turn.Nought){
                sender.setTitle(Nought, for: .normal)
                currTurn = Turn.Cross
                turnLabel.text = Cross
            }
        }
    }
    
    func fullBoard() -> Bool{
        for button in board
        {
            if button.title(for: .normal) == nil{
                return false
            }
        }
        return true
    }
    
    func resultAlert(title: String)
    {
        let message = "\nNoughts " + String(noughtScore) + "\nCrosses " + String(crossScore)
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reselt", style: .default, handler: {(_) in self.resetBoard()
            
        }))
        self.present(ac, animated: true)
    }
    
    
    func resetBoard()
    {
        for button in board
        {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if(firstTurn == Turn.Nought)
        {
            firstTurn = Turn.Cross
            currTurn = Turn.Cross
        }else if(firstTurn == Turn.Cross)
        {
            firstTurn = Turn.Nought
            currTurn = Turn.Nought
        }
    }
    
    func winGameCheck(_ s: String)-> Bool{
        // horizontal
        if thisSymbol(a1,s) && thisSymbol(a2,s) && thisSymbol(a3,s)
        {
            return true
        }
        
        if thisSymbol(b1,s) && thisSymbol(b2,s) && thisSymbol(b3,s)
        {
            return true
        }
        
        if thisSymbol(c1,s) && thisSymbol(c2,s) && thisSymbol(c3,s)
        {
            return true
        }
        //vertical
        if thisSymbol(a1,s) && thisSymbol(b1,s) && thisSymbol(c1,s)
        {
            return true
        }
        if thisSymbol(a2,s) && thisSymbol(b2,s) && thisSymbol(c2,s)
        {
            return true
        }
        if thisSymbol(a3,s) && thisSymbol(b3,s) && thisSymbol(c3,s)
        {
            return true
        }
        // diagonal
        if thisSymbol(a1,s) && thisSymbol(b2,s) && thisSymbol(c3,s)
        {
            return true
        }
        if thisSymbol(a3,s) && thisSymbol(b2,s) && thisSymbol(c1,s)
        {
            return true
        }
        
            return false
    }
    func thisSymbol(_ button : UIButton,_ symbol : String) -> Bool{
        return button.title(for: .normal) == symbol
    }
}

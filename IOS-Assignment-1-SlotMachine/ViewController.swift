//
//  ViewController.swift
//  IOS-Assignment-1-SlotMachine
//
//  Created by Krisuv Bohara on 2023-01-22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resetBt: UIButton!
    @IBOutlet weak var exitBtn: UIButton!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var spinBtn: UIButton!
    
    @IBOutlet weak var minus: UIButton!
    @IBOutlet weak var plus: UIButton!
    
    @IBOutlet weak var imageOne : UIImageView!
    @IBOutlet weak var imageTwo : UIImageView!
    @IBOutlet weak var imageThree : UIImageView!
    @IBOutlet weak var imageFour : UIImageView!
    @IBOutlet weak var imageFive : UIImageView!
    @IBOutlet weak var imageSix : UIImageView!
    @IBOutlet weak var imageSeven : UIImageView!
    @IBOutlet weak var imageEight : UIImageView!
    @IBOutlet weak var imageNine : UIImageView!
    
    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var totalMoneyLabel: UILabel!
    @IBOutlet weak var betCount: UILabel!
    
    let images = [
        "image 25",
        "image 26",
        "image 27",
        "image 28",
        "image 29",
        "image 25",
        "image 25",
        "image 25",
        "image 25",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backView.layer.cornerRadius = 12
        resetBt.layer.cornerRadius = resetBt.bounds.width / 2
        resetBt.clipsToBounds = true
        exitBtn.clipsToBounds = true
        exitBtn.layer.cornerRadius = exitBtn.bounds.width / 2
        generateRandomImages()
    }
    
    //this function is responsible for generating random images in the main jackpotfield !!
    func generateRandomImages(){
        imageOne.image = UIImage(named: images.randomElement()!)
        imageTwo.image = UIImage(named: images.randomElement()!)
        imageThree.image = UIImage(named: images.randomElement()!)
        imageFour.image = UIImage(named: images.randomElement()!)
        imageFive.image = UIImage(named: images.randomElement()!)
        imageSix.image = UIImage(named: images.randomElement()!)
        imageSeven.image = UIImage(named: images.randomElement()!)
        imageEight.image = UIImage(named: images.randomElement()!)
        imageNine.image = UIImage(named: images.randomElement()!)
    }

    //this function is responsible for generating border around the 3 main mid section when jackpot is won !!
    func addBorders(){
        imageTwo.layer.cornerRadius = 8
        imageTwo.layer.borderColor = UIColor.systemYellow.cgColor
        imageTwo.layer.borderWidth = 2
        imageTwo.layer.masksToBounds = true
        
        imageFive.layer.cornerRadius = 8
        imageFive.layer.borderColor = UIColor.systemYellow.cgColor
        imageFive.layer.borderWidth = 2
        imageFive.layer.masksToBounds = true
        
        imageEight.layer.cornerRadius = 8
        imageEight.layer.borderColor = UIColor.systemYellow.cgColor
        imageEight.layer.borderWidth = 2
        imageEight.layer.masksToBounds = true
    }
    
    func onJackPot(){
        let totalMoneySplit = totalMoneyLabel.text?.components(separatedBy: " ")
        let bet : Int = Int(betCount.text!)!
        let totalMoney : Int = Int(totalMoneySplit![0])!
        
        if imageTwo.image == UIImage(named: "image 25") && imageFive.image == UIImage(named: "image 25") && imageEight.image == UIImage(named: "image 25"){
            let newTotal = totalMoney + (bet * 2)
            totalMoneyLabel.text = String(newTotal) + " $"
            addBorders()
            msgLabel.text = "WOW, You have won the Jackpot !!"
            msgLabel.textColor = UIColor.systemYellow
        }else{
            let newTotal = totalMoney - bet
            totalMoneyLabel.text = String(newTotal) + " $"
        }
    }
    
    
    @IBAction func onSpinPressed(_ sender: UIButton) {
        if(betCount.text == "0"){
            let popUpMsg = UIAlertController(title: "Alert", message: "Place a Bet !!", preferredStyle: UIAlertController.Style.alert)
            popUpMsg.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(popUpMsg, animated: true, completion: nil)
        }else{
            clear()
            generateRandomImages()
            onJackPot()
            
        }
    }
    
    
    func clear(){
        msgLabel.text = "Spin to win !!"
        msgLabel.textColor = UIColor.white
        
        imageTwo.layer.masksToBounds = false
        imageTwo.layer.borderWidth = 0

        imageFive.layer.masksToBounds = false
        imageFive.layer.borderWidth = 0

        imageEight.layer.masksToBounds = false
        imageEight.layer.borderWidth = 0
    }
    
    
    @IBAction func addBtn(_ sender: UIButton) {
        var bet : Int = Int(betCount.text!)!
        bet += 10
        betCount.text = String(bet)
    }
    
    @IBAction func subBtn(_ sender: UIButton) {
        var bet : Int = Int(betCount.text!)!
        if bet > 0{
            bet -= 10
            betCount.text = String(bet)
        }else{

        }
    }
    
    @IBAction func resetBtn(_ sender: UIButton) {
        clear()
        betCount.text = "0"
        totalMoneyLabel.text = "1000 $"
    }
}


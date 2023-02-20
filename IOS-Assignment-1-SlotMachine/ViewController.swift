/*
 File Name: ViewController
 Author: Krisuv Bohara(301274636), Niraj Nepal(301211100), Sarthak Vasistha(301245284)
 Date: 2023-02-05
 Description: Creates the main UI of the Jackpot app
 Version: 1.0
 */

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
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
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var models = [PayoutDatabase]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationPermission()

        backView.layer.cornerRadius = 12
        resetBt.layer.cornerRadius = resetBt.bounds.width / 2
        resetBt.clipsToBounds = true
        exitBtn.clipsToBounds = true
        exitBtn.layer.cornerRadius = exitBtn.bounds.width / 2
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorInset = tableView.layoutMargins
        
        fetchPayouts()
        generateRandomImages()
    }
    
    func notificationPermission(){
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings {settings in
            switch settings.authorizationStatus {
            case .authorized:
                print("DOne")
            case .denied:
                return
            case .notDetermined:
                center.requestAuthorization { didAllow, error in
  
                    if(didAllow){
                        print("Done")
                    }
                }
            default:
                return
            }
        }
    }
    
    func fetchPayouts(){
        
        //Fetching data from CoreData and isplaying in the Table View
        do{
           models =  try context.fetch(PayoutDatabase.fetchRequest())
            //sorting the data on highest money earned
            models.sort { $0.pay > $1.pay }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }catch{
            
        }
    }
    
    func uploadData(date: String, payout: String, pay: Int){
        let newItem = PayoutDatabase(context: context)
        newItem.payout = payout
        newItem.date = date
        newItem.pay = Int16(pay)
        
        do{
            try context.save()
            fetchPayouts()
        }
        catch{
            
        }
        
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
        let date = Date()
        let totalMoneySplit = totalMoneyLabel.text?.components(separatedBy: " ")
        let bet : Int = Int(betCount.text!)!
        let totalMoney : Int = Int(totalMoneySplit![0])!
        
        if imageTwo.image == UIImage(named: "image 25") && imageFive.image == UIImage(named: "image 25") && imageEight.image == UIImage(named: "image 25"){
            
            let newTotal = totalMoney + (bet * 3)
            totalMoneyLabel.text = String(newTotal) + " $"
            
            addBorders()
            msgLabel.text = "WOW, You have won the Jackpot !!"
            msgLabel.textColor = UIColor.systemYellow
            
            let formatter3 = DateFormatter()
            formatter3.dateFormat = "MMM d"
            
            formatter3.string(from: date)
            
            uploadData(date:  formatter3.string(from: date),
                       payout: String(newTotal) + " $", pay: newTotal)
            pushNotification(money: newTotal)
            
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
    
    func pushNotification(money : Int) {
        
        let userNotificationCenter = UNUserNotificationCenter.current()
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Congratulations"
        notificationContent.body = "JackPot your new total amount is \(money) $"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1,
                                                        repeats: false)
        
        let request = UNNotificationRequest(identifier: "jackpot",
                                            content: notificationContent,
                                            trigger: trigger)
        
        userNotificationCenter.add(request) { (error) in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cells = tableView.dequeueReusableCell(withIdentifier: "cells", for: indexPath) as! CustomTableViewCell
        cells.dateLabel.text = model.date
        cells.payoutLabel.text = model.payout
        return cells
    }
    
}


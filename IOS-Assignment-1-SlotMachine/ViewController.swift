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
    @IBOutlet weak var spinBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetBt.layer.cornerRadius = resetBt.bounds.width / 2
        resetBt.clipsToBounds = true
        exitBtn.clipsToBounds = true
        exitBtn.layer.cornerRadius = exitBtn.bounds.width / 2
        spinBtn.clipsToBounds = true
        spinBtn.layer.cornerRadius = spinBtn.bounds.width / 2
        // Do any additional setup after loading the view.
    }


}


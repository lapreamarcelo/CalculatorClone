//
//  ViewController.swift
//  Calculator Clone
//
//  Created by Marcelo Laprea on 01/11/2018.
//  Copyright © 2018 AvilaTek. All rights reserved.
//

import UIKit

enum OperationType: Int {
    case addition
    case substraction
    case multiplication
    case divition
    case percentage
    case sign
}

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var acButton: UIButton!
    @IBOutlet weak var signButton: UIButton!
    @IBOutlet weak var divisionButton: UIButton!
    @IBOutlet weak var percentageButton: UIButton!
    @IBOutlet weak var additionButton: UIButton!
    @IBOutlet weak var multiplicationButton: UIButton!
    @IBOutlet weak var substractionButton: UIButton!
    @IBOutlet weak var equalButton: UIButton!
    @IBOutlet weak var decimalButton: UIButton!
    
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    
    var firstValue: Double?
    var secondValue: Double?
    var signChanged = false
    var decimalAdded = false
    var operationType: OperationType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @IBAction func resultButtonPressed(_ sender: UIButton) {
        guard let firstValue = firstValue, let secondValue = Double(resultLabel.text!), let operation = operationType else {
            return
        }
        
        switch operation {
        case .addition:
            addtionOperation(firstValue: firstValue, secondValue: secondValue)
        case .divition:
            divitionOperation(firstValue: firstValue, secondValue: secondValue)
        case .substraction:
            substractionOperation(firstValue: firstValue, secondValue: secondValue)
        case .multiplication:
            multiplicatinoOperation(firstValue: firstValue, secondValue: secondValue)
        default:
            break
        }
        
        operationType = nil
    }
    
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        checkOperation()
        resultLabel.text = resultLabel.text! + String(sender.tag)
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        resultLabel.text = "0"
        clear()
    }
    
    @IBAction func decimalButtonPressed(_ sender: UIButton) {
        if !decimalAdded {
            resultLabel.text = resultLabel.text! + "."
        }
    }
    
    @IBAction func operationButtonPressed(_ sender: UIButton) {
        guard let operation = OperationType(rawValue: sender.tag) else {
            return
        }
        
        self.operationType = operation
        self.firstValue = Double(resultLabel.text!)
        
        if operation == .sign {
            self.signOperation()
        } else if operation == .percentage {
            self.percentageOperation()
        }
    }
    
    private func setup() {
        roundButton(button: acButton)
        roundButton(button: signButton)
        roundButton(button: percentageButton)
        roundButton(button: divisionButton)
        
        roundButton(button: sevenButton)
        roundButton(button: eightButton)
        roundButton(button: nineButton)
        roundButton(button: multiplicationButton)
        
        roundButton(button: fourButton)
        roundButton(button: fiveButton)
        roundButton(button: sixButton)
        roundButton(button: substractionButton)
        
        roundButton(button: oneButton)
        roundButton(button: twoButton)
        roundButton(button: threeButton)
        roundButton(button: additionButton)
        
        roundButton(button: zeroButton)
        roundButton(button: decimalButton)
        roundButton(button: equalButton)
    }

    private func roundButton(button: UIButton) {
        button.layer.cornerRadius = button.frame.height / 2
    }
    
    private func clear() {
        self.operationType = nil
        self.firstValue = nil
        self.secondValue = nil
        self.signChanged = false
    }
    
    private func checkOperation() {
        if operationType != nil || resultLabel.text == "0" || firstValue != nil {
            resultLabel.text = ""
        }
    }
    
    private func addtionOperation(firstValue: Double, secondValue: Double) {
        let result = firstValue + secondValue
        self.resultLabel.text = String(result)
    }
    
    private func substractionOperation(firstValue: Double, secondValue: Double) {
        let result = firstValue - secondValue
        self.resultLabel.text = String(result)
    }
    
    private func multiplicatinoOperation(firstValue: Double, secondValue: Double) {
        let result = firstValue * secondValue
        self.resultLabel.text = String(result)
    }
    
    private func divitionOperation(firstValue: Double, secondValue: Double) {
        let result = firstValue / secondValue
        self.resultLabel.text = String(result)
    }

    private func signOperation() {
        guard let result = resultLabel.text else {
            return
        }
        
        var resultChanged = result
        
        if signChanged {
            resultChanged.remove(at: resultChanged.startIndex)
        } else {
            resultChanged.insert("-", at: resultChanged.startIndex)
        }
        
        operationType = nil
        signChanged = !signChanged
        resultLabel.text = resultChanged
    }
    
    private func percentageOperation() {
        guard let result = Double(resultLabel.text!) else {
            return
        }

        resultLabel.text = String(result/100)
    }
    
}

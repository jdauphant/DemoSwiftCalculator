//
//  ViewController.swift
//  DemoSwiftCalculator
//
//  Created by Julien DAUPHANT on 16/03/15.
//  Copyright (c) 2015 Siz. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        switch operation {
        case "x" : performOperation(*)
        case "%" : performOperation({$1 / $0})
        case "+" : performOperation({$0 + $1})
        case "-" : performOperation({$1 - $0})
        case "√" : performOperation(sqrt)
        default: break
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double){
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation(operation: Double -> Double){
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
    }

    
    @IBAction func reset() {
        userIsInTheMiddleOfTypingANumber = false
        displayValue = 0
        operandStack.removeAll()
    }
    
    let formatter = NSNumberFormatter()
    
    var displayValue: Double {
        get {
            var displayString = display.text!
            return (displayString as NSString).doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
}


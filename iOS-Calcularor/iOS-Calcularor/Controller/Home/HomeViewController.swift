//
//  HomeViewController.swift
//  iOS-Calcularor
//
//  Created by Germán González on 10/6/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: Outlets
    // Result Label
    @IBOutlet weak var label: UILabel!

    // Operators Buttons
    @IBOutlet weak var acButton: UIButton!
    @IBOutlet weak var plusMinusButton: UIButton!
    @IBOutlet weak var additionButton: UIButton!
    @IBOutlet weak var substractButton: UIButton!
    @IBOutlet weak var multiplicationButton: UIButton!
    @IBOutlet weak var divisionButton: UIButton!
    @IBOutlet weak var percentageButton: UIButton!
    @IBOutlet weak var equalButton: UIButton!
    
    // Numbers and Comma Buttons
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
    @IBOutlet weak var commaButton: UIButton!
    
    // MARK: - Variables
    private var total:Double = 0 // Total
    private var temp:Double = 0 // Screen Value
    private var operating = false // Indicates if a button operator was selected
    private var decimal = false // Indicates if the value is decimal
    private var operation:OperationType = .none // Type of Operation
    
    // MARK: - Constants
    private let kDecimalSeparator = Locale.current.decimalSeparator! // Gets the decimal separator of the gadget
    private let kMaxLength = 9 // As in iOS Calculator app, sets the max lenght of the digits
    private let kTotal = "total" // Stores the last value when the app closes

    // Enum to support the Calculator operations
    private enum OperationType {
        case none, addition, substraction, multiplication, division, percentage
    }
    
    // Auxiliar Formatter to Values
    private let auxFormatter:NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = ""
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 100
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 100
        return formatter
    }()
    
    // Formatter to Print Value in Screen
    private let printFormatter:NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = locale.groupingSeparator
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 9
        formatter.minimumIntegerDigits = 0
        formatter.minimumFractionDigits = 0
        return formatter
    }()
    
    // Formatter to Print Value in Scientific Notation
    private let printScientificFormatter:NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .scientific
        formatter.maximumFractionDigits = 3
        formatter.exponentSymbol = "e"
        return formatter
    }()
    
    // Auxiliar Formatter to Total
    private let auxTotalFormatter:NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = ""
        formatter.decimalSeparator = ""
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 100
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 100
        return formatter
    }()
    
    // MARK: - Initialization
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets the comma button to Default Value for Locale
        commaButton.setTitle(kDecimalSeparator, for: .normal)
        
        // Retrieves the last stored total value
        total = UserDefaults.standard.double(forKey: kTotal)
        
        // Sets the initial value
        result()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Apply rounding shape to each button
        acButton.round()
        plusMinusButton.round()
        additionButton.round()
        substractButton.round()
        multiplicationButton.round()
        divisionButton.round()
        percentageButton.round()
        equalButton.round()
        
        zeroButton.round()
        oneButton.round()
        twoButton.round()
        threeButton.round()
        fourButton.round()
        fiveButton.round()
        sixButton.round()
        sevenButton.round()
        eightButton.round()
        nineButton.round()
        commaButton.round()
    }
    
    // MARK: - Button Actions
    // Operators
    @IBAction func acButtonAction(_ sender: UIButton) {
        // Clears the screen and the information
        clear()
        
        // Highlights the button
        sender.shine()
    }
    
    @IBAction func plusMinusButtonAction(_ sender: UIButton) {
        // Changes the sign of the screen value
        temp *= -1
        
        // Prints in the screen
        label.text = printFormatter.string(from: NSNumber(value: temp))
        
        // Highlights the button
        sender.shine()
    }
    
    @IBAction func percentageButtonAction(_ sender: UIButton) {
        // If there is an active operation different to percentage, executes it
        if operation != .percentage {
            // Calculates the total
            result()
        }
        
        // Indicates that there is a pending operation
        operating = true
        
        // Sets the type of operation
        operation = .percentage
        
        // Calculates the total
        result()
        
        // Highlights the button
        sender.shine()
    }
    
    @IBAction func additionButtonAction(_ sender: UIButton) {
        // Calculates the total
        if operation != .none {
            result()
        }
        
        // Indicates that there is a pending operation
        operating = true
        
        // Sets the type of operation
        operation = .addition
        
        // Mark the button as selected
        sender.selectOperation(true)
        
        // Highlights the button
        sender.shine()
    }
    
    @IBAction func substractionButtonAction(_ sender: UIButton) {
        // Calculates the total
        if operation != .none {
            result()
        }
        
        // Indicates that there is a pending operation
        operating = true
        
        // Sets the type of operation
        operation = .substraction
        
        // Mark the button as selected
        sender.selectOperation(true)
        
        // Highlights the button
        sender.shine()
    }
    
    @IBAction func multiplicationButtonAction(_ sender: UIButton) {
        // Calculates the total
        if operation != .none {
            result()
        }
        
        // Indicates that there is a pending operation
        operating = true
        
        // Sets the type of operation
        operation = .multiplication
        
        // Mark the button as selected
        sender.selectOperation(true)
        
        // Highlights the button
        sender.shine()
    }
    
    @IBAction func divisionButtonAction(_ sender: UIButton) {
        // Calculates the total
        if operation != .none {
            result()
        }
        
        // Indicates that there is a pending operation
        operating = true
        
        // Sets the type of operation
        operation = .division
        
        // Mark the button as selected
        sender.selectOperation(true)
        
        // Highlights the button
        sender.shine()
    }
    
    @IBAction func equalButtonAction(_ sender: UIButton) {
        // Calculates the total
        result()
        
        // Highlights the button
        sender.shine()
    }
    
    // Numbers and Comma
    @IBAction func numberButtonAction(_ sender: UIButton) {
        // Changes the button title
        acButton.setTitle("C", for: .normal)
        
        // Gets the flat value of the screen without points and commas divisors
        var currentTemp = auxTotalFormatter.string(from: NSNumber(value: temp))!
        
        // If the count of the value is max of the max lenght it does nothing
        if !operating && currentTemp.count >= kMaxLength {
            return
        }
        
        currentTemp = auxFormatter.string(from: NSNumber(value: temp))!
        
        // Checks if an operation has been selected
        if operating {
            total = total == 0 ? temp : total
            label.text = ""
            currentTemp = ""
            operating = false
        }
        
        // Checks if a decimal operations has been selected
        if decimal {
            currentTemp = "\(currentTemp)\(kDecimalSeparator)"
            decimal = false
        }
        
        // Obtains the number
        let number = sender.tag
        
        // Sets the current value
        temp = Double(currentTemp + String(number))!
        
        // Prints in the screen
        label.text = printFormatter.string(from: NSNumber(value: temp))
        
        // Deselects the operation button
        selectVisualOperation()
        
        // Highlights the button
        sender.shine()
    }
    
    @IBAction func commaButtonAction(_ sender: UIButton) {
        // If there is a pending decimal operation, it does nothing
        if !decimal {
            
            // Gets the flat value of the screen without points and commas divisors
            let currentTemp = auxTotalFormatter.string(from: NSNumber(value: temp))!
            
            // If the count of the value is max of the max lenght it does nothing
            if !operating && currentTemp.count >= kMaxLength {
                return
            }
            
            // Accesses to the label and adds the decimal separator and shows in the screen
            label.text = label.text! + kDecimalSeparator
            
            // Indicates that the decimal has been presented, if the decimal button is pressed again, does not execute
            decimal = true
            
        }
        
        // Deselects the operation button
        selectVisualOperation()
        
        // Highlights the button
        sender.shine()
    }
    
    // MARK: - Custom Functions
    // Cleans the values
    private func clear() {
        // Sets the operation in none
        operation = .none
        
        // Changes the button title
        acButton.setTitle("AC", for: .normal)
        
        // If the screen value is not zero, erases it and shows in the screen
        if temp != 0 {
            temp = 0
            label.text = "0"
        } else {
            // Otherwise, calculates the total
            total = 0
            result()
        }
    }
    
    // Gets the final result
    private func result() {
        // Inspects the Type of the Operation
        switch operation {
        case .none:
            // None operation
            break
        case .addition:
            total += temp
            break
        case .substraction:
            total -= temp
            break
        case .multiplication:
            total *= temp
            break
        case .division:
            total /= temp
            break
        case .percentage:
            temp /= 100
            total = temp
            break
        }
        
        // Formats the Screen
        if let currentTotal = auxTotalFormatter.string(from: NSNumber(value: total)), currentTotal.count > kMaxLength {
            label.text = printScientificFormatter.string(from: NSNumber(value: total))
        } else {
            label.text = printFormatter.string(from: NSNumber(value: total))
        }
        
        // Initialize the Operation
        operation = .none
        
        // Deselects the operation button
        selectVisualOperation()
        
        // Store the total in the memomry of the app
        UserDefaults.standard.set(total, forKey: kTotal)
        
        // Prints in console
        print("Total: \(total)")
    }
    
    // Shows the button who is selected
    private func selectVisualOperation() {
        
        if !operating {
            additionButton.selectOperation(false)
            substractButton.selectOperation(false)
            multiplicationButton.selectOperation(false)
            divisionButton.selectOperation(false)
        } else {
            switch operation {
            case .none, .percentage:
                additionButton.selectOperation(false)
                substractButton.selectOperation(false)
                multiplicationButton.selectOperation(false)
                divisionButton.selectOperation(false)
                break
            case .addition:
                additionButton.selectOperation(true)
                substractButton.selectOperation(false)
                multiplicationButton.selectOperation(false)
                divisionButton.selectOperation(false)
                break
            case .substraction:
                additionButton.selectOperation(false)
                substractButton.selectOperation(true)
                multiplicationButton.selectOperation(false)
                divisionButton.selectOperation(false)
                break
            case .multiplication:
                additionButton.selectOperation(false)
                substractButton.selectOperation(false)
                multiplicationButton.selectOperation(true)
                divisionButton.selectOperation(false)
                break
            case .division:
                additionButton.selectOperation(false)
                substractButton.selectOperation(false)
                multiplicationButton.selectOperation(false)
                divisionButton.selectOperation(true)
                break
            }
        }
    }
}

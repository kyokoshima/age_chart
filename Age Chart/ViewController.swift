//
//  ViewController.swift
//  Age Chart
//
//  Created by 横島健一 on 2017/11/19.
//  Copyright © 2017年 info.tmpla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var ages: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var baloon: BalloonView!
    @IBOutlet weak var actualAge: UILabel!
    @IBOutlet weak var actualNumberOfDigit: UILabel!
    
    var dataSource = [[String: String]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        addDoneButtonOnKeyboard()
        //        ages.addTarget(self, action: #selector(ViewController.textFieldEditingChanged(sender:)), for: UIControlEvents.editingChanged)
        // Do any additional setup after loading the view, typically from a nib.
        //        let comparisonRule = ValidationRuleComparison<Int>(min: 20, max: 200, error: ValidationError(message: ""))
        //
        //        ages.validationRules = ValidationRuleSet<String>()
        ages.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x:0, y:0, width:view.bounds.width, height:50))
        doneToolbar.barStyle = UIBarStyle.blackTranslucent
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem =
            UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(ViewController.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.ages.inputAccessoryView = doneToolbar
        
    }
    
    @objc func doneButtonAction()
    {
//        self.ages.perform(#selector(textFieldShouldReturn(_:)))
        if let age = ages.text {
            validate(age)
        }
        self.ages.resignFirstResponder()
        
    }
    
}

extension ViewController : UITableViewDelegate {
    
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "agesCell", for: indexPath)
        
        if let item = dataSource[indexPath.row].first {
            let text = "\(item.key)進法で\(item.value)歳です"
            cell.textLabel?.text = text
        }
        return cell
        
    }
}

extension ViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let str = string.trimmingCharacters(in: .newlines)
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = str.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        let isNumber = str == numberFiltered
        var validated:Bool = true
        var message:String = ""
        if (!isNumber) {
            message = "数字で入力！"
            validated = false
        }
        
        //        self.validationLabel.text = message
        //        self.validationLabel.isHidden = validated
        showValidationError(message, result: validated)
        if validated {
            
        }
        return validated
    }
    
    
    
    
    func validateAge(_ age: String?) -> Bool {
        var validated = false
        var message:String = ""
        if let age:Int = Int((age)!) {
            if (age > 150) {
                validated = false
                message = "嘘でしょ"
            } else if (age < 20) {
                validated = false
                message = "若すぎ"
            } else {
                validated = true
            }
            
        } else {
            validated = false
        }
//        self.validationLabel.isHidden = validated
//        self.validationLabel.text = message
        showValidationError(message, result: validated)
        return validated
    }
    
    
    func convertToNumberString(_ baseNumber: Int, decimalNumber: Int) -> String? {
        //        let baseNumber = 10
        //        if (decimalNumber == 10) {
        //            return baseNumber.description
        //        }
        
        var character = ""
        var surplus = baseNumber
        var calcedNumber = baseNumber
        while (calcedNumber > decimalNumber)  {
            surplus = calcedNumber % decimalNumber
            calcedNumber = calcedNumber / decimalNumber
            //            var nextNumber = surplus
            character.append(contentsOf: convertToDigitCharacter(surplus, decimalNumber: decimalNumber))
            if (calcedNumber < decimalNumber) {
                //                nextNumber = calcedNumber
                character.append(contentsOf: convertToDigitCharacter(calcedNumber, decimalNumber: decimalNumber))
            }
            //            character.append(contentsOf: "\(nextNumber)+")
            //            character.append(contentsOf: convertToDigitCharacter(nextNumber, decimalNumber: decimalNumber))
        }
        
        return String(character.reversed())
    }
    
    func showValidationError(_ message:String, result:Bool) {
        if !result {
            if !message.isEmpty {
                baloon.label.text = message
                baloon.isHidden = false
            }
        } else {
            baloon.label.text = ""
            baloon.isHidden = true
        }
    }
    func convertToDigitCharacter(_ number: Int, decimalNumber: Int) -> String {
        if (number < 10) {
            return number.description
        }
        let baseCode = 87 // a - 10
        let difference = number
        let character = UnicodeScalar(baseCode + difference)?.description
        return (character?.description)!
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //        if let age: Int = Int(textField.text!)! {
        //            var validated:Bool = false
        //            var message:String = ""
        //            if (age > 150) {
        //                validated = false
        //                message = "嘘でしょ"
        //            } else if (age < 20) {
        //                validated = false
        //                message = "若すぎ"
        //            } else {
        //                validated = true
        //            }
        //            if (!validated) {
        //                return false
        //            }
        //            self.validationLabel.isHidden = validated
        return validate(textField.text!)
//        if (validateAge(textField.text)) {
//            var source = [[String: String]]()
//            if let age = Int(textField.text!) {
//                var decimalNumber = 10
//                while (26 > decimalNumber) {
//
//                    if let value = convertToNumberString(age, decimalNumber: decimalNumber) {
//                        //                        let value = "\(Int(firstDigit).description)\(secondDigit)"
//                        source.append([decimalNumber.description: value])
//                    }
//
//                    //                    }
//                    decimalNumber = decimalNumber + 1
//                }
//            }
//            dataSource = source
//            tableView.reloadData()
//
//            //            } else {
//            //                self.validationLabel.text = message
//            //
//            //            }
//            //        }
//            return true
//        }
//        return false
    }
    
    func validate(_ age:String) -> Bool {
        if (validateAge(age)) {
            var source = [[String: String]]()
            if let age = Int(age) {
                var decimalNumber = 10
                while (26 > decimalNumber) {
                    
                    if let value = convertToNumberString(age, decimalNumber: decimalNumber) {
                        //                        let value = "\(Int(firstDigit).description)\(secondDigit)"
                        source.append([decimalNumber.description: value])
                    }
                    
                    //                    }
                    decimalNumber = decimalNumber + 1
                }
            }
            dataSource = source
            tableView.reloadData()
            
            //            } else {
            //                self.validationLabel.text = message
            //
            //            }
            //        }
            return true
        }
        return false
    }
    
}







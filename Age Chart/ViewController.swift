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
    var dataSource = [[String: String]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        addDoneButtonOnKeyboard()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTextValueChanged(_ sender: Any) {
        var source = [[String: String]]()
        if let textField = sender as? UITextField {
            let age = textField.text as! String
            source.append(["1": age])
            source.append(["2": age])
            source.append(["3": age])
            dataSource = source
            tableView.reloadData()
        }
        
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x:0, y:0, width:320, height:50))
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
        //ここで先ほど指定した『beginnerCell』を呼んでる。
        let text = dataSource[indexPath.row].first?.value as! String
        cell.textLabel?.text = text
        
        return cell
        
    }
}

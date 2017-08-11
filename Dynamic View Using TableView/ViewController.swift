//
//  ViewController.swift
//  Dynamic View Using TableView
//
//  Created by Nitin Bhatia on 11/08/17.
//  Copyright © 2017 Nitin Bhatia. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    @IBOutlet var dynamicTableView: UITableView!
    var fields : NSArray!
    var controls = [String]()
    var dataControls = [Int:String]()
    var sections = [String]()
    var controlsEnum = 0
    var pp = [[]]
    var checkedButton : [Int:[Int : Bool]] = [:]
    var checkTick : [Int:Bool] = [:]
    var radioTick = [Int:Bool]()
    var radioButton = [Int: [Int:Bool]]()
    var dynamicGroupName = [Int:String]()
    var textFieldText = [String:String]()



    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        readJSONFile()
        if UIDevice.current.model == "iPad"{
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        }
        
        //Dynamic controls
        dynamicTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func keyboardWillShow(_ notification:Notification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            dynamicTableView.contentInset = UIEdgeInsetsMake(0, 0, keyboardSize.height - 20, 0)
        }
    }
    func keyboardWillHide(_ notification:Notification) {
        
        if let _ = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            dynamicTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldText[textField.placeholder!] = textField.text
        dynamicTableView.isScrollEnabled = false
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        textFieldText[textField.placeholder!] = textField.text
        dynamicTableView.isScrollEnabled = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        self.scrollview.setContentOffset(CGPoint(x: 0,y :self.sixthButtonViewContainer.frame.origin.y), animated: false)
        dynamicTableView.isScrollEnabled = true
    }
    
    //Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        if(tableView == self.dynamicTableView){
            return sections.count
            
        }
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
       if (tableView == self.dynamicTableView){
            count = pp[section].count
        }
        
        return count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell?
        
        if(tableView == self.dynamicTableView){
            
            tableView.tableFooterView = UIView()
            
            if (controls[indexPath.section] == "text") {
                
                let cell = dynamicTableView.dequeueReusableCell(withIdentifier: "text", for: indexPath) as! TextTableViewCell
                cell.txt.placeholder = pp[indexPath.section][indexPath.row] as? String
                print(pp[indexPath.section])
                if let x = self.textFieldText[cell.txt.placeholder!] {
                    cell.txt.text = x
                } else{
                    cell.txt.text = ""
                }
                
                //                if(textFieldText[cell.txt.placeholder!] != nil){
                //                    cell.txt.text = self.textFieldText[cell.txt.placeholder!]
                //                } else {
                //                }
                //
                cell.txt.delegate = self
                cell.txt.tag = controlsEnum
                cell.txt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
                controlsEnum = controlsEnum + 1
                return cell
                
                
                
            } else if (controls[indexPath.section] == "check") {
                let cell = dynamicTableView.dequeueReusableCell(withIdentifier: "check", for: indexPath) as! CheckTableViewCell
                cell.txt.text = pp[indexPath.section][indexPath.row] as! String
                cell.txt.sizeToFit()
                cell.layoutIfNeeded()
                
                let pi = checkedButton[indexPath.section]!
                cell.btn.tag = Array(pi.keys)[indexPath.row]
                
                cell.btn.isUserInteractionEnabled = false
                
                if (!pi[cell.btn.tag]!){
                    let image = UIImage(named: "unchecked_checkbox")
                    
                    cell.btn.setImage(image, for: .normal)
                } else {
                    let image = UIImage(named: "checkbox_checked")
                    
                    cell.btn.setImage(image, for: .normal)
                    
                }
                
                controlsEnum = controlsEnum + 1
                
                
                return cell
                
                
                
            } else {
                let  cell = dynamicTableView.dequeueReusableCell(withIdentifier: "radio", for: indexPath) as! RadioTableViewCell
                cell.txt.text = pp[indexPath.section][indexPath.row] as! String
                cell.txt.sizeToFit()
                cell.layoutIfNeeded()
                cell.btn.isUserInteractionEnabled = false
                let pi = radioButton[indexPath.section]!
                cell.btn.tag = Array(pi.keys)[indexPath.row]
                
                if (pi[cell.btn.tag] == false){
                    let image = UIImage(named: "radiobutton-unchecked")
                    cell.btn.setImage(image, for: .normal)
                } else {
                    let image = UIImage(named: "radiobutton-checked")
                    cell.btn.setImage(image, for: .normal)
                }
                
                dynamicGroupName[cell.btn.tag] = self.sections[indexPath.section]
                controlsEnum = controlsEnum + 1
                return cell
            }
            
        }
        
        return cell!
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//       
//    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(tableView == dynamicTableView && sections[section] != ""){
            print(sections.count)
            print(section)
            print(sections[section])
            return sections[section]
        }
                return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
         if(tableView == dynamicTableView && sections[section] != ""){
            return 50
        }
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        
         if(tableView == dynamicTableView && sections[section] != ""){
            return 50
        }
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
          if(tableView == dynamicTableView){
            if(sections[section] != "" ){
                let headerView = UIView(frame: CGRect(x:0, y:0, width:tableView.frame.size.width, height:40))
                headerView.backgroundColor = UIColor.lightGray
                let lbl = UILabel(frame: CGRect(x:0, y:0, width:tableView.frame.size.width, height:40))
                lbl.text = sections[section]
                headerView.addSubview(lbl)
                return headerView
            }
            return nil
        }
        
        return nil
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        if(tableView == dynamicTableView){
            if(controls[indexPath.section] == "check"){
                let cell = dynamicTableView.cellForRow(at: indexPath) as! CheckTableViewCell
                let pressedTag = cell.btn.tag
                var image : UIImage!
                let pi = checkedButton[indexPath.section]!
                
                
                if (!pi[pressedTag]!){
                    image = UIImage(named: "checkbox_checked")
                    self.checkedButton[indexPath.section]?[pressedTag] = true
                } else {
                    image = UIImage(named: "unchecked_checkbox")
                    self.checkedButton[indexPath.section]?[pressedTag] = false
                }
                cell.btn.setImage(image, for: .normal)
            }
            
            
            
            
            if(controls[indexPath.section] ==  "radio" ){
                
                let cell = dynamicTableView.cellForRow(at: indexPath) as! RadioTableViewCell
                let pressedTag = cell.btn.tag
                
                for i in 0..<pp[indexPath.section].count{
                    
                    let indexPath23 = NSIndexPath(row: i, section: indexPath.section) as IndexPath
                    if(indexPath23.row != indexPath.row){
                        dynamicTableView.deselectRow(at: indexPath23 as IndexPath, animated: true)
                        
                        for (key,_) in self.radioButton[indexPath.section]! {
                            if (key != pressedTag){
                                self.radioButton[indexPath.section]?[key] = false
                            } else {
                                self.radioButton[indexPath.section]?[key] = true
                            }
                        }
                        
                        if let cell = dynamicTableView.cellForRow(at: indexPath23) as? RadioTableViewCell{
                            let image = UIImage(named: "radiobutton-unchecked")
                            let btn : UIButton = cell.btn
                            btn.setImage(image, for: .normal)
                        }
                        
                    } else {
                        let image = UIImage(named: "radiobutton-checked")
                        // tb.scrollToRow(at: indexPath23, at: .none, animated: false)
                        
                        if let cell = dynamicTableView.cellForRow(at: indexPath23) as? RadioTableViewCell{
                            cell.btn.setImage(image, for: .normal)
                        }
                        
                    }
                    
                }
            }
        }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
         if(tableView == dynamicTableView){
            
            if(controls[indexPath.section] == "check"){
                let cell = dynamicTableView.cellForRow(at: indexPath) as! CheckTableViewCell
                let pressedTag = cell.btn.tag
                var image : UIImage!
                let pi = checkedButton[indexPath.section]!
                
                
                if (!pi[pressedTag]!){
                    image = UIImage(named: "checkbox_checked")
                    self.checkedButton[indexPath.section]?[pressedTag] = true
                } else {
                    image = UIImage(named: "unchecked_checkbox")
                    self.checkedButton[indexPath.section]?[pressedTag] = false
                }
                cell.btn.setImage(image, for: .normal)
            }
        }
    }
    

    //read json file
    func readJSONFile(){
        
        var tag = 1
        var index = -1
        var check = false
        
        if let path = Bundle.main.path(forResource: "new", ofType: "json") {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                if let jsonResult: NSDictionary =  try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                {
                    self.fields = jsonResult["fields"] as! NSArray
                    
                    for i in fields  {
                        let j = i as! [String:AnyObject]
                        
                        if(j["kind"] as! String  == "CharField") {
                            if(!check){
                                index = index + 1
                                check = true
                                pp.append([])
                                sections.append("")
                                self.controls.append("text")
                            }
                            
                            let data =  j["kwargs"] as! [String:AnyObject]
                            dataControls[tag] = data["label"] as? String
                            tag = tag + 1
                            pp[index].append((data["label"] as? String!)!)
                            self.textFieldText[(data["label"] as? String!)!] = ""
                            
                            
                        }
                        
                        if(j["kind"] as! String == "MultipleChoiceField") {
                            
                            
                            check = false
                            index = index + 1
                            pp.append([])
                            let data =  j["kwargs"] as! [String:AnyObject]
                            sections.append((data["label"] as? String)!)
                            self.controls.append("check")
                            
                            for k in data["choices"] as! [String]{
                                dataControls[tag] = k
                                
                                pp[index].append(k)
                                checkTick[tag] = false
                                tag = tag + 1
                            }
                            let sectionIndex = sections.index(of: (data["label"] as? String)!)
                            
                            checkedButton[sectionIndex!] = checkTick
                            
                            
                        }
                        
                        if(j["kind"] as! String == "ChoiceField") {
                            let data =  j["kwargs"] as! [String:AnyObject]
                            check = false
                            index = index + 1
                            pp.append([])
                            sections.append((data["label"] as? String)!)
                            
                            self.controls.append("radio")
                            
                            for k in data["choices"] as! [String]{
                                //self.addRadioButton(heading: k,groupName: data["label"] as! String)
                                dataControls[tag] = k
                                radioTick[tag] = false
                                tag = tag + 1
                                pp[index].append(k)
                                
                                
                            }
                            let sectionIndex = sections.index(of: (data["label"] as? String)!)
                            self.radioButton[sectionIndex!] = self.radioTick
                            self.radioTick.removeAll()
                        }
                        
                        
                    }
                    
                    print(pp.count)
                    self.dynamicTableView.reloadData()
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
    }

}


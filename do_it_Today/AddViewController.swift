//
//  AddViewController.swift
//  do_it_ios
//
//  Created by 박성영 on 09/01/2020.
//  Copyright © 2020 박성영. All rights reserved.
//

import UIKit
import MapKit


class AddViewController: UIViewController , UITextFieldDelegate ,SendBackDelegate {
    
    var addToDo = ""
    var date = Date()
    var addItem = MKMapItem()
    
    let formatter2 = DateFormatter()
    let chckTimeError = DateFormatter()

  
    @IBOutlet var tfWhereDo: UITextField!
    @IBOutlet var tfWhatDo: UITextField!
    
    @IBOutlet var whenTime: UILabel!
    @IBOutlet var whenYear: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
       //키보드가 textField를 가리는 문제 해결
        NotificationCenter.default.addObserver(self, selector:
            #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification,
            object: nil)
        NotificationCenter.default.addObserver(self, selector:
            #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        formatter2.dateFormat = "HH시 mm분"
        chckTimeError.dateFormat = "yyyy년MM월dd일HH시 mm분"
        whenYear.text = formatter1.string(from: Date())
        whenTime.text = formatter2.string(from: Date())
        tfWhereDo.delegate = self
        tfWhatDo.delegate = self
      
    }
    
    //키보드가 textField 가리는 문제 해결
    @objc func keyboardWillShow(_ sender:Notification){
        self.view.frame.origin.y = -150
    }
        
    @objc func keyboardWillHide(_ sender:Notification){
        self.view.frame.origin.y = 0
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func btnAddItem(_ sender: UIButton) { //새로운 일정 추가
        
        let addSchecule = ToDoModel(towhen_year: whenYear.text!, towhen_time: whenTime.text!, towhere: tfWhereDo.text!, towhat: tfWhatDo.text!, matchingItem: addItem)

        toDo.append(addSchecule)
        tfWhereDo.text = ""
        tfWhatDo.text = ""
        _ =  navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func openCalender(_ sender: Any) {
        let aleter = UIAlertController(title: "날짜", message: nil, preferredStyle: .alert)
        aleter.isModalInPresentation = true
        
        let datePickerView = UIDatePicker(frame: CGRect(x: 10, y: 30 , width: aleter.view.frame.width * 0.65, height: aleter.view.frame.height * 0.15))
        datePickerView.datePickerMode = .date
        datePickerView.locale = Locale(identifier: "Korean")
        datePickerView.minimumDate = Date()
        aleter.view.addSubview(datePickerView)
        let errorOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        aleter.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            (UIAlertAction) in
            
            let myTime = self.chckTimeError.date(from: formatter1.string(from: datePickerView.date) + self.whenTime.text! )
              let curTime = self.chckTimeError.date(from: self.chckTimeError.string(from: Date()))
              let remainTime = myTime!.timeIntervalSince((curTime!))
              if Double(remainTime/86400) <= 0 {
                  let error = UIAlertController(title: "오류", message: "이미 지난 시간입니다. 다시 설정해주세요.", preferredStyle: .alert)
                  error.isModalInPresentation = true
                  error.addAction(errorOk)
                  //let action = UIAlertAction(title : "확인")
                  self.present(error, animated: true, completion: nil)
                  
              }
              else {
                  self.whenYear.text = formatter1.string(from: datePickerView.date)
              }
        }))
        let height:NSLayoutConstraint = NSLayoutConstraint(item: aleter.view as Any, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: self.view.frame.height * 0.25)
        aleter.view.addConstraint(height)
        
        self.present(aleter, animated: true, completion: nil)
        
    }
    
    @IBAction func openClock(_ sender: Any) {
        let aleter = UIAlertController(title: "시간", message: nil, preferredStyle: .alert)
        aleter.isModalInPresentation = true
        
        let timePickerView = UIDatePicker(frame: CGRect(x: 10, y: 30 , width: aleter.view.frame.width * 0.65, height: aleter.view.frame.height * 0.15))
        timePickerView.datePickerMode = .time
        timePickerView.locale = Locale(identifier: "Korean")
        //timePickerView.minimumDate = Date()
        aleter.view.addSubview(timePickerView)
        let errorOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        aleter.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            (UIAlertAction) in
            
            let myTime = self.chckTimeError.date(from: self.whenYear.text! + self.formatter2.string(from: timePickerView.date))
            let curTime = self.chckTimeError.date(from: self.chckTimeError.string(from: Date()))

          
            let remainTime = myTime!.timeIntervalSince((curTime!))
            if Double(remainTime/86400) <= 0 {
                let error = UIAlertController(title: "오류", message: "이미 지난 시간입니다. 다시 설정해주세요.", preferredStyle: .alert)
                error.isModalInPresentation = true
                error.addAction(errorOk)
                //let action = UIAlertAction(title : "확인")
                self.present(error, animated: true, completion: nil)
                
            }
            else {
                 self.whenTime.text = self.formatter2.string(from: timePickerView.date)
            }
            
        }))
        let height:NSLayoutConstraint = NSLayoutConstraint(item: aleter.view as Any, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: self.view.frame.height * 0.25)
        aleter.view.addConstraint(height)
        
        self.present(aleter, animated: true, completion: nil)
        
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
       // print(textField)
        if textField == tfWhereDo{
            performSegue(withIdentifier: "sgfindarea", sender: textField)
            //이 부분 최종 수정 performSegue 추가했음
        }
    }
    
    
    func dataReceived(data: MKMapItem) { //약속장소가 없으면 장소 정보는 "Unkown Location"
        tfWhereDo.text = data.name
       
        addItem = data
        //이부분 추가 할 것(mapItem) 추가
       
       }
    
     // MARK: - Navigation     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "sgfindarea" {
            let searchareavc : SearchAreaViewController = segue.destination as! SearchAreaViewController
            searchareavc.delegate = self
        }
        
     }
     
    
}

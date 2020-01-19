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
    
    var select = 0
    var addToDo = ""
    var date = Date()
    var address = ""

    //var myMapItem = MKPointAnnotation()
    
   // let formatter1 = DateFormatter()
    let formatter2 = DateFormatter()
    let chckTimeError = DateFormatter()
  //  @IBOutlet var image: UIImageView!
  //  @IBOutlet var tfWhoDo: UITextField!
  
    @IBOutlet var tfWhereDo: UITextField!
    @IBOutlet var tfWhatDo: UITextField!
   // @IBOutlet var pickerView: UIPickerView!
    
    @IBOutlet var whenTime: UILabel!
    @IBOutlet var whenYear: UILabel!
    
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return 3
//    }
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return itemsImageFile[row]
//    }
//
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//        let imageView = UIImageView(image: UIImage(named: itemsImageFile[row]))
//        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//        return imageView
//    }
//    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
//        return 100
//    }
//    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
//        return 100
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        select = row
//        image.image = UIImage(named: itemsImageFile[row])
//    }
//
    
    override func viewDidLoad() {
        super.viewDidLoad()
    //    formatter1.dateFormat = "yyyy년MM월d일"
        formatter2.dateFormat = "HH시 mm분"
        chckTimeError.dateFormat = "yyyy년MM월dd일HH시 mm분"
        whenYear.text = formatter1.string(from: Date())
        whenTime.text = formatter2.string(from: Date())
        tfWhereDo.delegate = self
        tfWhatDo.delegate = self
       
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func btnAddItem(_ sender: UIButton) { //새로운 일정 추가
        
        addToDo.append(whenYear.text! + " ")
        addToDo.append(whenTime.text! + " ")
        toWhen.append(whenYear.text! + whenTime.text!)
        addToDo.append(tfWhereDo.text! + " ")
        addToDo.append(tfWhatDo.text!)
        toDo.append(addToDo)
        
        D_day.append( whenYear.text!)
        
        tfWhereDo.text = ""
        tfWhatDo.text = ""
        // tfWhenDo.text = ""
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
    
    
    func dataReceived(data: MKMapItem) {
        tfWhereDo.text = data.name
        //이부분 추가 할 것(mapItem) 추가
        matchingItems.append(data)
       
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

//
//  DetailViewController.swift
//  do_it_ios
//
//  Created by 박성영 on 09/01/2020.
//  Copyright © 2020 박성영. All rights reserved.
//
import UIKit
import MapKit

class DetailViewController: UIViewController ,UIScrollViewDelegate{
    
    var receiveItem = ""
    var receiveMap = ""
    var receiveTime = ""
    var receiveDay = ""
    
    var mTimer : Timer?
    
    var dest = MKMapItem()
    
    @IBOutlet var lblItem: UILabel!
    @IBOutlet var mapInform: UILabel!
    @IBOutlet var remainDay: UILabel!
    @IBOutlet var remainTime: UILabel!
    
    @IBOutlet var showNavi: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        showTime()
        
        lblItem.text = receiveItem
        mapInform.text = receiveMap
        if receiveMap == "약속정보 없음" {
            showNavi.isEnabled = false
        }
        mTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true) //타이머를 1초동안 계속 불러옴
    }
    
    
    
    override func viewDidDisappear(_ animated: Bool) {
        mTimer?.invalidate()   //뷰를 나가면 타이머 기능 끄기
    }
    
    
    @objc func updateTime() {  //타이머 작동 함수
        let timerFormatter = DateFormatter()
        let currentTime = Date()
        timerFormatter.dateFormat = "yyyy년MM월dd일HH시 mm분ss초"
        
        let myTime = timerFormatter.date(from: receiveTime )
        let remain = myTime!.timeIntervalSince(currentTime)
        var cal = Int(remain)
        if remain <= 0{  //타이머가 0일때 알람기능 사용
            //view.backgroundColor = UIColor.gray
        }
        else { //타이머가 0이 아닐때
            
            remainDay.text! = String(Int(remain/86400)) + "일"
            cal = cal % 86400
            remainTime.text = String(Int(cal/3600)) + ":"
            cal = cal % 3600
            remainTime.text = remainTime.text! + String(format : "%02d",Int(cal/60)) + ":" + String(format : "%02d" ,Int(cal%60))
            //view.backgroundColor = UIColor.green
        }
        // print(remain)
    }
    
    func showTime(){
        let timerFormatter = DateFormatter()
        let currentTime = Date()
        timerFormatter.dateFormat = "yyyy년MM월dd일HH시 mm분ss초"
        
        let myTime = timerFormatter.date(from: receiveTime )
        let remain = myTime!.timeIntervalSince(currentTime)
        var cal = Int(remain)
        
        if remain <= 0 {
            remainDay.text = String("D-DAY")
            remainTime.text = String("00:00")
        }
        else{
            remainDay.text! = String(Int(remain/86400)) + "일"
            cal = cal % 86400
            remainTime.text = String(Int(cal/3600)) + ":"
            cal = cal % 3600
            remainTime.text = remainTime.text! + String(format : "%02d",Int(cal/60)) + ":" + String(format : "%02d" ,Int(cal%60))
        }
    }
    
    
    func receiveItem( _ item :String){
        receiveItem = item
        
    }
    
    func receiveMap( _ map : MKMapItem){
        dest = map
        if String(map.name!) == "Unknown Location" {
            receiveMap = "약속정보 없음"
        }
        else{
            receiveMap = String(map.name!)
        }
    }
    
    func receiveTime( _ day : String,  _ time : String ){
        receiveTime = time
        //remainDay.text? = day
        print(receiveTime)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "sgshownavi"{
            
            let detailNavivc = segue.destination as! DetailNavigationViewController
            detailNavivc.receiveAnnotaion(dest)
        }
        
        
    }
    
    
}

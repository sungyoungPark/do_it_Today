//
//  DetailViewController.swift
//  do_it_ios
//
//  Created by 박성영 on 09/01/2020.
//  Copyright © 2020 박성영. All rights reserved.
//
import UIKit
import MapKit

class DetailViewController: UIViewController {

    var receiveItem = ""
    var receiveMap = ""
    var receiveTime = ""
    var receiveDay = ""
    
    var mTimer : Timer?
    
    @IBOutlet var lblItem: UILabel!
    @IBOutlet var mapInform: UILabel!
    @IBOutlet var remainDay: UILabel!
    @IBOutlet var remainTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         mTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true) //타이머를 1초동안 계속 불러옴
       
        lblItem.text = receiveItem
        mapInform.text = receiveMap
       
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
        if remain == 0{  //타이머가 0일때
            view.backgroundColor = UIColor.gray
        }
        else { //타이머가 0이 아닐때
           
            remainDay.text! = String(Int(remain/86400)) + "일"
            
            cal = cal % 86400
            remainTime.text = String(Int(cal/3600)) + ":"
            cal = cal % 3600
            remainTime.text = remainTime.text! + String(format : "%02d",Int(cal/60)) + ":" + String(format : "%02d" ,Int(cal%60))
            view.backgroundColor = UIColor.green
        }
    }
    
    
    func receiveItem( _ item :String){
        receiveItem = item
        
    }
    
    func receiveMap( _ map : MKMapItem){
        receiveMap = String(map.placemark.coordinate.latitude) + " / "
            + String(map.placemark.coordinate.longitude)
    }
    
    func receiveTime( _ day : String,  _ time : String ){
        receiveTime = time
        //remainDay.text? = day
        print(receiveTime)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

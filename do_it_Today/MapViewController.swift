//
//  MapViewController.swift
//  do_it_ios
//
//  Created by 박성영 on 13/01/2020.
//  Copyright © 2020 박성영. All rights reserved.
//

import UIKit
import MapKit


protocol SendBackDelegate {
    func dataReceived(data : MKMapItem)
}

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    
    @IBOutlet var myMap: MKMapView!
    @IBOutlet var appointmentArea: UILabel!
    
   // @IBOutlet var searchText: UITextField!
    
    
    var delegate : SendBackDelegate?
    var searchAddress = ""
    var addressDetail = ""
    var resultItem = MKMapItem()
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appointmentArea.text = addressDetail
        //locationManager.delegate = self
        
       // locationManager.desiredAccuracy = kCLLocationAccuracyBest
       // locationManager.requestWhenInUseAuthorization()
       // locationManager.startUpdatingLocation()
       // myMap.showsUserLocation = true
        self.performSerach()
        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    func goLocation(latitudeValue : CLLocationDegrees, longitudeValue : CLLocationDegrees, delta span : Double)
        -> CLLocationCoordinate2D {
            
            // 지도 위치 바꿔주는 함수
            let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
            let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
            let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
            myMap.setRegion(pRegion, animated: true)
            return pLocation
            
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        //지도 위치 업데이트
//        let pLocation = locations.last
//        _ = goLocation(latitudeValue: (pLocation?.coordinate.latitude)! , longitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01)
//
//
//        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {
//            (placemarks, error) -> Void in
//            let pm = placemarks!.first
//            let country = pm!.country
//            var address : String = country!
//            if pm!.locality != nil {
//                address += " "
//                address += pm!.locality!
//            }
//            if pm!.thoroughfare != nil {
//                address += " "
//                address += pm!.thoroughfare!
//            }
//            print(address)
//            self.startLocation.text = "시작점 : " + address
//
//        })
//        locationManager.stopUpdatingLocation()
//    }
    
    
//    @IBAction func searchArea(_ sender: Any) {  //텍스트 필드에 찾는 장소 검색
//        resignFirstResponder()
//        // if myMap.annotations
//        myMap.removeAnnotations(myMap.annotations )
//        self.performSerach()
//    }
    
    func performSerach() {  //장소 검색 후 pin point 지정
        // 배열 값 삭제
        let request = MKLocalSearch.Request()
        // 텍스트 필드의 값으로 초기화된 MKLocalSearchRequest 인스턴스를 생성
        request.naturalLanguageQuery = searchAddress
        request.region = myMap.region
        // 검색 요청 인스턴스에 대한 참조체로 초기화
        let search = MKLocalSearch(request: request)
        // MKLocalSearchCompletionHandler 메서드가 호출되면서 검색이 시작
        search.start(completionHandler: {(response: MKLocalSearch.Response!, error: Error!) in
            if error != nil {
                print("Error occured in search: \(error.localizedDescription)")
            } else if response.mapItems.count == 0 {
                print("No matches found")
            } else {
                print("Matches found")
                self.resultItem = response.mapItems.first!
               
                _ = self.goLocation(latitudeValue: (response.mapItems.first?.placemark.coordinate.latitude)!, longitudeValue: (response.mapItems.first?.placemark.coordinate.longitude)!, delta: 0.01)
                // 일치된 값이 있다면 일치된 위치에 대한 mapItem 인스턴스의 배열을 가지고 mapItem 속성에 접근한다.
                for item in response.mapItems as [MKMapItem] {
                    if item.name != nil {
                        print("Name = \(item.name!)")
                    }
                    if item.phoneNumber != nil {
                        print("Phone = \(item.phoneNumber!)")
                    }
                    
//                    self.matchingItems.append(item as MKMapItem)
//                    print("Matching items = \(self.matchingItems.count)")
                    // 맵에 표시할 어노테이션 생성
                    let annotation = MKPointAnnotation()
                    // 위치에 어노테이션을 표시
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name
                    annotation.subtitle = item.phoneNumber
                    
                    self.myMap.addAnnotation(annotation)
                    
                }
            }
        })
    }
    

    @IBAction func btnConfirm(_ sender: UIButton) {
        
        delegate?.dataReceived(data: resultItem)
        
        let vc = navigationController?.viewControllers[1]
        navigationController?.popToViewController(vc!, animated: true)
        
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  
     
      
    }
    
    func receiveAddress( _ address : MKLocalSearchCompletion ) {
        searchAddress = address.title
        addressDetail = address.subtitle
        
    }
    
    
}

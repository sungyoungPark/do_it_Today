//
//  DetailNavigationViewController.swift
//  do_it_Today
//
//  Created by 박성영 on 20/01/2020.
//  Copyright © 2020 박성영. All rights reserved.
//

import UIKit
import MapKit


class DetailNavigationViewController: UIViewController ,CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, MKLocalSearchCompleterDelegate {
    
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var currentLocation: UILabel!
    @IBOutlet var searchBar: UISearchBar!
    //@IBOutlet var naviMap: MKMapView!
    @IBOutlet var naviMap: MKMapView!
    @IBOutlet var resultTable: UITableView!
    
    private var searchCompleter = MKLocalSearchCompleter()
    private var searchResults = [MKLocalSearchCompletion]()
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.isHidden = true
        resultTable.isHidden = true
        searchBar.showsCancelButton = true
        self.searchBar.becomeFirstResponder()
        searchBar.delegate = self
        
        resultTable.delegate = self
        resultTable.dataSource = self
        
        searchCompleter.delegate = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        naviMap.showsUserLocation = true
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "startCell", for: indexPath)
        //print(cell.bounds.height)
        cell.textLabel?.text = searchResults[indexPath.row].title
        
        return cell
    }
    
  
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        resultTable.isHidden = false
        if searchText == "" {
               searchResults.removeAll()
                resultTable.reloadData()
           }
           searchCompleter.queryFragment = searchText
    }
    
    
    
    
    func goLocation(latitudeValue : CLLocationDegrees, longitudeValue : CLLocationDegrees, delta span : Double) {
        // 지도 위치 바꿔주는 함수
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        naviMap.setRegion(pRegion, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //지도 위치 업데이트
        let pLocation = locations.last
        goLocation(latitudeValue: (pLocation?.coordinate.latitude)! , longitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01)
        
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {
            (placemarks, error) -> Void in
            let pm = placemarks!.first
            let country = pm!.country
            var address : String = country!
            if pm!.locality != nil {
                address += " "
                address += pm!.locality!
            }
            if pm!.thoroughfare != nil {
                address += " "
                address += pm!.thoroughfare!
            }
            print(address)
            self.currentLocation.text = address
            // self.startLocation.text = "시작점 : " + address
            
        })
        locationManager.stopUpdatingLocation()
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        resultTable.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error)
    }
    
    @IBAction func segChanged(_ sender: Any) {
        switch  segmentedControl.selectedSegmentIndex {
        case 0:
            searchBar.isHidden = true
            resultTable.isHidden = true
            currentLocation.isHidden = false
        // self.naviMap.bounds.origin.y = +56
        case 1:
            searchBar.isHidden = false
            currentLocation.isHidden = true
        //self.naviMap.frame.origin.y = -56
        default:
            searchBar.isHidden = true
        }
    }
    
    
    //    func myLocation(latitude: CLLocationDegrees, longitude : CLLocationDegrees, delta : Double){
    //        let coordinateLocation = CLLocationCoordinate2DMake(latitude, longitude)
    //        let spanValue = MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
    //        let locationRegion = MKCoordinateRegion(center: coordinateLocation, span: spanValue)
    //        myMap.setRegion(locationRegion, animated: true)
    //    }
    //
    //
    //    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    //        let lastLocation = locations.last
    //        myLocation(latitude: (lastLocation?.coordinate.latitude)!, longitude: (lastLocation?.coordinate.longitude)!, delta: 0.01)
    //    }
    //
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

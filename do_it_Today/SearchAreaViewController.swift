//
//  SearchAreaViewController.swift
//  do_it_ios
//
//  Created by 박성영 on 15/01/2020.
//  Copyright © 2020 박성영. All rights reserved.
//

import UIKit
import MapKit


class SearchAreaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, MKLocalSearchCompleterDelegate ,SendBackDelegate{
    
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var searchBarResult: UITableView!
    
    private var searchCompleter = MKLocalSearchCompleter()
    private var searchResults = [MKLocalSearchCompletion]()
    
    var delegate : SendBackDelegate?
    var resultArea = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.showsCancelButton = true
        self.searchBar.becomeFirstResponder()
        self.searchCompleter.delegate = self
        //self.searchCompleter.resultTypes =
        self.searchCompleter.filterType = .locationsOnly
        self.searchBar.delegate = self
        self.searchBarResult.dataSource = self
        self.searchBarResult.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(searchResults)
        //searchResults[searchResults.startIndex].l
        return searchResults.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "areaCell", for: indexPath)
        cell.textLabel?.text = searchResults[indexPath.row].title
        
        return cell
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            searchResults.removeAll()
            searchBarResult.reloadData()
        }
        searchCompleter.queryFragment = searchText
        
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        searchBarResult.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error)
    }
    
    
    func dataReceived(data: MKMapItem) {
        delegate?.dataReceived(data: data)
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "sgmapdetail"{
            let cell = sender as! UITableViewCell
            let indexPath = self.searchBarResult.indexPath(for: cell)
            let mapView = segue.destination as! MapViewController
            mapView.delegate = self
            mapView.receiveAddress(searchResults[((indexPath as NSIndexPath?)?.row)!])
            
        }
        
    }
    
    
}

//
//  DetailNavigationViewController.swift
//  do_it_Today
//
//  Created by 박성영 on 20/01/2020.
//  Copyright © 2020 박성영. All rights reserved.
//

import UIKit

class DetailNavigationViewController: UIViewController {

    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var currentLocation: UILabel!
    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func segChanged(_ sender: Any) {
        switch  segmentedControl.selectedSegmentIndex {
        case 0:
            searchBar.isHidden = true
            currentLocation.isHidden = false
        case 1:
            searchBar.isHidden = false
            currentLocation.isHidden = true
        default:
            searchBar.isHidden = true
        }
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

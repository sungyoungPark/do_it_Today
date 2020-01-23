//
//  ToDoModel.swift
//  do_it_Today
//
//  Created by 박성영 on 23/01/2020.
//  Copyright © 2020 박성영. All rights reserved.
//

import Foundation
import MapKit

class ToDoModel {
    
    private var _toWhen_year : String!
    private var _toWhen_time : String!
    private var _toWhere : String!
    private var _toWhat : String!
    private var _matchingItems : MKMapItem!
    
    var toWhen_year : String! {
        get{
            return _toWhen_year
        }
        set{
            _toWhen_year = newValue
        }
    }
    
    var toWhen_time : String! {
        get{
            return _toWhen_time
        }
        set{
            _toWhen_year = newValue
        }
    }
    
    
    var toWhere : String! {
        get {
            return _toWhere
        }
        set {
            _toWhere = newValue
        }
    }
    
    var toWhat : String! {
        get{
            return _toWhat
        }
        set{
            _toWhat = newValue
        }
    }
    
    var matchingItems : MKMapItem! {
        get {
            return _matchingItems
        }
        set{
            _matchingItems = newValue
        }
    }
    
    
    
    init(){
        self._toWhen_year = ""
        self._toWhen_time = ""
        self._toWhere = ""
        self._toWhat = ""
        self._matchingItems = MKMapItem()
    }
    
    init( towhen_year : String, towhen_time : String, towhere : String, towhat : String , matchingItem : MKMapItem) {
        
        self._toWhen_year = towhen_year
        self._toWhen_time = towhen_time
        self._toWhere = towhere
        self._toWhat = towhat
        self._matchingItems = matchingItem
    }
    
    var fullSchedule : String {
        return _toWhen_year + _toWhen_time + toWhere + toWhat
    }
    
    var scheduleItem : MKMapItem {
        return _matchingItems
    }
    
}

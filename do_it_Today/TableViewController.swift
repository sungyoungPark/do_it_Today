//
//  TableViewController.swift
//  do_it_ios
//
//  Created by 박성영 on 09/01/2020.
//  Copyright © 2020 박성영. All rights reserved.
//

import UIKit
import MapKit

//var items = ["책 구매","철수와 약속","스터디 준비하기"]
//var itemsImageFile = ["cart.jpg","clock.png","pencil.jpeg"]

//var toDo = [String]()
var toDo = [ToDoModel]()

var D_day = [String]()
var day = ""

let myDo = ToDoModel()

let formatter1 = DateFormatter()

class TableViewController: UITableViewController {
    
    @IBOutlet var tvListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter1.dateFormat = "yyyy년MM월d일"
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDo.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        // cell.textLabel?.text = toWho[(indexPath as NSIndexPath).row]
        //let startDate = formatter1.date(from: D_day[(indexPath as NSIndexPath).row])
        let startDate = formatter1.date(from: toDo[(indexPath as NSIndexPath).row].toWhen_year)
        let endDate = formatter1.date(from:formatter1.string(from: Date()))!
        let interval = startDate!.timeIntervalSince(endDate)
        
        if Int(interval/86400) == 0 {
            cell.textLabel?.text = "D-DAY" + "  |  "
            day.append("D-DAY")
        }
        else{
            cell.textLabel?.text = "D-" + String(Int(interval/86400)) + "  |  "
            day.append("D-" + String(Int(interval/86400)))
        }
        
        
      //  cell.textLabel?.text = cell.textLabel!.text! + toDo[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = cell.textLabel!.text! + toDo[(indexPath as NSIndexPath).row].fullSchedule
        //cell.imageView?.image = UIImage(named: itemsImageFile[( indexPath as NSIndexPath).row])
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete { //목록을 제거해주는 부분
            // Delete the row from the data source
            toDo.remove(at: (indexPath as NSIndexPath).row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }
    
    
    
    // Override to support rearranging the table view.
    //목록을 재배치해주는 코드
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let itemToMove = toDo[(fromIndexPath as NSIndexPath).row]
        toDo.remove(at: (fromIndexPath as NSIndexPath).row)
        toDo.insert(itemToMove, at: (to as NSIndexPath).row)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        tvListView.reloadData()
        
    }
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgdetail"{
            let cell = sender as! UITableViewCell
            let indexPath = self.tvListView.indexPath(for: cell)
            let detailView = segue.destination as! DetailViewController

            detailView.receiveItem(toDo[((indexPath as NSIndexPath?)?.row)!].fullSchedule)
            detailView.receiveTime(day,toDo[((indexPath as NSIndexPath?)?.row)!].toWhen_year + toDo[((indexPath as NSIndexPath?)?.row)!].toWhen_time  + "00초")
            //여기까지 했음
            detailView.receiveMap(toDo[((indexPath as NSIndexPath?)?.row)!].scheduleItem)
            //print(toWhen[((indexPath as NSIndexPath?)?.row)!])
        }
    }
    
    
}

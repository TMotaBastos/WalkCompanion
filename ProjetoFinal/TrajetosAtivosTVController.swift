//
//  TrajetosAtivosTVController.swift
//  ProjetoFinal
//
//  Created by Thiago Mota Bastos on 9/22/17.
//  Copyright © 2017 Thiago Mota Bastos. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class TrajetosAtivosTVController: UITableViewController {
    
    //var tableData = [["CIn - CAC", "12:00", "RotaCINCAC"], ["CIn - CTG", "15:00", ""], ["CIn - CCSA", "17:00", ""]]
    var tableData:[[String]] = []
    var rowSelected:[String]?

    override func viewDidLoad() {
        super.viewDidLoad()

        let user = Auth.auth().currentUser
        if let user = user {
            let storage = Database.database().reference()
            let pathsRef = storage.child("paths")
            let userRef = storage.child("users").child(user.uid).child("paths")
            
            var refHandle1 = userRef.observe(DataEventType.value, with: { (snapshot) in
                var dbData = snapshot.value as? [String : AnyObject] ?? [:]
                //let dbKey = snapshot.key as? String
                
                print("Carregou")
                print(dbData)
                for d in dbData {
                    print(d.key)
                    pathsRef.child(d.key).observe(DataEventType.value, with: { (snapshot) in
                        var pathData = snapshot.value as? [String : AnyObject] ?? [:]
                        print(pathData)
                        
                        if let saida = pathData["saida"], let destino = pathData["destino"], let data = pathData["data"] {
                            self.tableData.append([((saida as! String) + " - " + (destino as! String)), data as! String])
                        }
                    })
                }
                //print(dbData.popFirst()?.key)
                //print(dbKey)
            })
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trajetosAtivosCell", for: indexPath) as! TrajetosAtivosTVCell

        // Configure the cell...
        cell.lblRoute?.text = tableData[indexPath.row][0]
        cell.lblTime?.text = tableData[indexPath.row][1]

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewTrajeto" {
            let destiny = segue.destination as! DescricaoTrajetoViewController
            destiny.obj = rowSelected
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowSelected = tableData[indexPath.row]
        self.performSegue(withIdentifier: "viewTrajeto", sender: self)
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

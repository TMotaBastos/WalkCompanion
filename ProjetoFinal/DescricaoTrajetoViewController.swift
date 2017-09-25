//
//  DescricaoTrajetoViewController.swift
//  ProjetoFinal
//
//  Created by Thiago Mota Bastos on 9/22/17.
//  Copyright © 2017 Thiago Mota Bastos. All rights reserved.
//

import UIKit

class DescricaoTrajetoViewController: UIViewController {

    var obj:[String]?
    
    @IBOutlet weak var lblRoute: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var imgRoute: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lblRoute.text = obj![0]
        self.lblTime.text = obj![1]
        self.imgRoute.image = UIImage(named: obj![2])
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

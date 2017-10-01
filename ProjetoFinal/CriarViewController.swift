//
//  CriarViewController.swift
//  ProjetoFinal
//
//  Created by Barbara Cristina Lima de Oliveira on 9/25/17.
//  Copyright © 2017 Thiago Mota Bastos. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CriarViewController: UIViewController , UIPickerViewDataSource, UIPickerViewDelegate{
    
    @IBOutlet weak var saidaPicker: UIPickerView!
    @IBOutlet weak var chegadaPicker: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var saidaBtn: UIButton!
    @IBOutlet weak var chegadaBtn: UIButton!
    @IBOutlet weak var horarioBtn: UIButton!
    
    @IBOutlet weak var criarBtn: UIButton!
    
    let pickerData = ["CCEN - Parada Externa",
                       "CIn - Saída Principal",
                       "CTG - Parada Externa",
                       "CAC/CFCH - Parada Externa",
                       "CTG - Parada Interna",
                       "Niate CTG",
                       "CTG - Entrada Principal",
                       "Area 2",
                       "Centro de Educação Física",
                       "Grêmio Estudantil - Parada Externa",
                       "CAC - Parada Interna",
                       "CAC/CFCH - Entradas Principais",
                       "CE",
                       "Niate CFCH/CCSA",
                       "CCSA",
                       "CCSA/Corpo Discente - Saída Externa",
                       "CCS - Parada Externa",
                       "CCB/Niate CCB - Parada",
                       "HC-BR101 - Parada",
                       "Biblioteca Central - Parada"].sorted()
    
    let dateFormatter = DateFormatter()
    
    let storage = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.saidaPicker.dataSource = self
        self.saidaPicker.delegate = self
        
        self.chegadaPicker.dataSource = self
        self.chegadaPicker.delegate = self
        
        self.saidaPicker.isHidden = true
        self.chegadaPicker.isHidden = true
        self.datePicker.isHidden = true
        
        self.datePicker.minimumDate = Date()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.locale = Locale(identifier: "pt_BR")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func saidaBtnAction(_ sender: Any) {
        saidaPicker.isHidden = !saidaPicker.isHidden
        chegadaPicker.isHidden = true
        datePicker.isHidden = true
    }
    
    @IBAction func chegadaBtnAction(_ sender: Any) {
        saidaPicker.isHidden = true
        chegadaPicker.isHidden = !chegadaPicker.isHidden
        datePicker.isHidden = true
    }
    
    @IBAction func horarioBtnAction(_ sender: Any) {
        saidaPicker.isHidden = true
        chegadaPicker.isHidden = true
        datePicker.isHidden = !datePicker.isHidden
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData.sorted()[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == saidaPicker {
            saidaBtn.setTitle(pickerData[row], for: .normal)
        } else if pickerView == chegadaPicker {
            chegadaBtn.setTitle(pickerData[row], for: .normal)
        }
    }
    
    @IBAction func datePickerDidSelectRow(_ sender: Any) {
        let strDate = dateFormatter.string(from: datePicker.date)
        horarioBtn.setTitle(strDate, for: .normal)
    }
    
    @IBAction func hidePickers(_ sender: Any) {
        self.saidaPicker.isHidden = true
        self.chegadaPicker.isHidden = true
        self.datePicker.isHidden = true
    }
    
    @IBAction func handleCriar(_ sender: Any) {
        var saida = pickerData[saidaPicker.selectedRow(inComponent: 0)]
        var destino = pickerData[chegadaPicker.selectedRow(inComponent: 0)]
        var data = datePicker.date
        
        let saidaId = saida.replacingOccurrences(of: "/", with: "-")
        let destinoId = destino.replacingOccurrences(of: "/", with: "-")
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "dd-MM-yyyy HH:mm"
        let dataStr = formatter.string(from: data)
        let dataStrId = formatter2.string(from: data)
        
        let storage = Database.database().reference()
        let pathsRef = storage.child("paths")
        let usersRef = storage.child("users")
        
        let user = Auth.auth().currentUser
        if let user = user {
            let key = saidaId + " -> " + destinoId + " -> " + dataStrId
            pathsRef.observeSingleEvent(of: .value, with: { (snapshot) in
                if snapshot.hasChild(key) {
                    pathsRef.child(key).child("users").child(user.uid).setValue("true")
                } else {
                    pathsRef.child(key).setValue(["saida": saida, "destino": destino, "data": dataStr])
                }
                usersRef.child(user.uid).child("paths").child(key).setValue("true")
            })
            
            ////let path = pathsRef.childByAutoId()
            //let path = pathsRef.child(saidaId + " -> " + destinoId + " -> " + dataStrId)
            //path.setValue(["saida": saida, "destino": destino, "data": dataStr])
            //path.child("users").child(user.uid).setValue("true")
            /*let key = saidaId + " -> " + destinoId + " -> " + dataStrId
            let post = ["saida": saida, "destino": destino, "data": dataStr]
            let post2 = [user.uid: "true"]
            let childUpdates = ["/paths/\(key)": post,
                                "/paths/\(key)/users": post2]
            
            storage.updateChildValues(childUpdates)*/
            
            //usersRef.child(user.uid).child("paths").child(path.key).setValue("true")
        }
        
        self.tabBarController?.selectedIndex = 0
        //self.navigationController?.popViewController(animated: true)
        //self.performSegue(withIdentifier: "trajetoCriado", sender: self)
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

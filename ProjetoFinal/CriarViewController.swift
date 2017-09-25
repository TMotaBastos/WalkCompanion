//
//  CriarViewController.swift
//  ProjetoFinal
//
//  Created by Barbara Cristina Lima de Oliveira on 9/25/17.
//  Copyright © 2017 Thiago Mota Bastos. All rights reserved.
//

import UIKit

class CriarViewController: UIViewController , UIPickerViewDataSource, UIPickerViewDelegate{
    
    @IBOutlet weak var saidaPicker: UIPickerView!
    
    @IBOutlet weak var chegadaPicker: UIPickerView!
    
    let pickerSaida = ["Parada Externa CCEN",
                       "Saída Principal Cin",
                       "Parada Externa CTG",
                       "Parada Externa CAC/CFCH",
                       "Parada Interna CTG/Oceanografia",
                       "Niate CTG",
                       "Entrada Principal CTG",
                       "Area 2",
                       "Centro de Educação Física",
                       "Parada Externa Grêmio Estudantil",
                       "Parada Interna CAC",
                       "Entradas Principais CAC/CFCH",
                       "CE",
                       "Niate CFCH/CCSA",
                       "CCSA",
                       "Saída Externa CCSA/Corpo Discente",
                       "Parada Externa CCS",
                       "Parada CCB/Niate CCB",
                       "Parada HC-BR101",
                       "Parada Biblioteca Central"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.saidaPicker.dataSource = self
        self.saidaPicker.delegate = self
        self.chegadaPicker.delegate = self
        self.chegadaPicker.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerSaida.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerSaida.sorted()[row]
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

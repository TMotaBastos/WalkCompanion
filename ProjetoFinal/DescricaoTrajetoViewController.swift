//
//  DescricaoTrajetoViewController.swift
//  ProjetoFinal
//
//  Created by Thiago Mota Bastos on 9/22/17.
//  Copyright © 2017 Thiago Mota Bastos. All rights reserved.
//

import UIKit
import MapKit

class DescricaoTrajetoViewController: UIViewController {
    
    var obj:[String]?
    
    @IBOutlet weak var lblRoute: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    var pinos:[Pinos] = []
    //let pino:Pinos = Pinos(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>, nome: <#T##String#>)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblRoute.text = obj![0]
        self.lblTime.text = obj![1]
        initPinos()
        //pino.adcPonto(mapView,pinos)
        
    }
    func initPinos () {
        pinos.append(Pinos(latitude: -8.05649, longitude: -34.9535, nome: "Area2"))
        pinos.append(Pinos(latitude:-8.05768,longitude:-34.95219,nome:"Parada externa CCEN"))
        pinos.append(Pinos(latitude:-8.05573,longitude:-34.95115,nome:"Saída Principal Cin"))
        pinos.append(Pinos(latitude:-8.05512,longitude: -34.95275,nome:"Niate CTG"))
        pinos.append(Pinos(latitude:-8.05404,longitude: -34.9536,nome:"Parada Interna CTG/Oceanografia"))
        pinos.append(Pinos(latitude:-8.05281,longitude: -34.95397,nome:"Entrada Principal CTG"))
        pinos.append(Pinos(latitude:-8.05288,longitude:-34.95557,nome:"Parada Externa CTG"))
        pinos.append(Pinos(latitude:-8.05157,longitude: -34.95331,nome:"Parada Interna CAC"))
        pinos.append(Pinos(latitude:-8.0505,longitude:-34.95387,nome:"Entradas Principais CAC/CFCH"))
        pinos.append(Pinos(latitude:-8.04963,longitude:-34.95464,nome:"Parada Externa CAC/CFCH"))
        pinos.append(Pinos(latitude:-8.04947,longitude:-34.95386,nome:"CE"))
        pinos.append(Pinos(latitude:-8.04927,longitude: -34.95238,nome:"Niate CFCH/CCSA"))
        pinos.append(Pinos(latitude:-8.04858,longitude: -34.95117,nome:"CCSA"))
        pinos.append(Pinos(latitude:-8.04644,longitude: -34.95029,nome:"Saída Externa CCSA/Corpo Discente"))
        pinos.append(Pinos(latitude:-8.04758,longitude:-34.94536,nome:"Parada HC-BR101"))
        pinos.append(Pinos(latitude:-8.05056,longitude: -34.94599,nome:"Parada Externa CCS"))
        pinos.append(Pinos(latitude:-8.05407,longitude: -34.94659,nome:"Parada Externa Grêmio Estudantil"))
        pinos.append(Pinos(latitude:-8.05183,longitude:-34.94809,nome:"Parada CCB/Niate CCB"))
        pinos.append(Pinos(latitude:-8.05402,longitude:-34.94829,nome:"Centro de Educação Física"))
        
        for pino in pinos {
            pino.adcPonto(mapView)
        }
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

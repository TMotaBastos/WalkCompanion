//
//  DescricaoTrajetoViewController.swift
//  ProjetoFinal
//
//  Created by Thiago Mota Bastos on 9/22/17.
//  Copyright © 2017 Thiago Mota Bastos. All rights reserved.
//

import UIKit
import MapKit

class DescricaoTrajetoViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var obj:[String]?
    
    @IBOutlet weak var lblRoute: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var PessoasCollection: UICollectionView!
    @IBOutlet weak var mapView: MKMapView!
    var pinos:[Pinos] = []
    var pessoas = [["dog","cachorrinho"],["dog","cachorrinho"],["dog","cachorrinho"],["dog","cachorrinho"],["dog","cachorrinho"],["dog","cachorrinho"],["dog","cachorrinho"]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblRoute.text = obj![0]
        self.lblTime.text = obj![1]
        initPinos()
        self.PessoasCollection.delegate = self
        self.PessoasCollection.dataSource = self
        //pino.adcPonto(mapView,pinos)
        
    }
    func initPinos () {
        pinos.append(Pinos(latitude: -8.05649, longitude: -34.9535, nome: "Area2"))
        pinos.append(Pinos(latitude:-8.05768,longitude:-34.95219,nome:"CCEN - Parada Externa"))
        pinos.append(Pinos(latitude:-8.05573,longitude:-34.95115,nome:"CIn - Saída Principal"))
        pinos.append(Pinos(latitude:-8.05512,longitude: -34.95275,nome:"Niate CTG"))
        pinos.append(Pinos(latitude:-8.05404,longitude: -34.9536,nome:"CTG - Parada Interna"))
        pinos.append(Pinos(latitude:-8.05281,longitude: -34.95397,nome:"CTG - Entrada Principal"))
        pinos.append(Pinos(latitude:-8.05288,longitude:-34.95557,nome:"CTG - Parada Externa"))
        pinos.append(Pinos(latitude:-8.05157,longitude: -34.95331,nome:"CAC - Parada Interna"))
        pinos.append(Pinos(latitude:-8.0505,longitude:-34.95387,nome:"CAC/CFCH - Entradas Principais"))
        pinos.append(Pinos(latitude:-8.04963,longitude:-34.95464,nome:"CAC/CFCH - Parada Externa"))
        pinos.append(Pinos(latitude:-8.04947,longitude:-34.95386,nome:"CE"))
        pinos.append(Pinos(latitude:-8.04927,longitude: -34.95238,nome:"Niate CFCH/CCSA"))
        pinos.append(Pinos(latitude:-8.04858,longitude: -34.95117,nome:"CCSA"))
        pinos.append(Pinos(latitude:-8.04644,longitude: -34.95029,nome:"CCSA/Corpo Discente - Saída Externa"))
        pinos.append(Pinos(latitude:-8.04758,longitude:-34.94536,nome:"HC-BR101 - Parada"))
        pinos.append(Pinos(latitude:-8.05056,longitude: -34.94599,nome:"CCS - Parada Externa"))
        pinos.append(Pinos(latitude:-8.05407,longitude: -34.94659,nome:"Grêmio Estudantil - Parada Externa"))
        pinos.append(Pinos(latitude:-8.05183,longitude:-34.94809,nome:"CCB/Niate CCB - Parada"))
        pinos.append(Pinos(latitude:-8.05402,longitude:-34.94829,nome:"Centro de Educação Física"))
        pinos.append(Pinos(latitude:-8.051296,longitude:-34.951412,nome:"Biblioteca Central - Parada"))
        
        for pino in pinos {
            pino.adcPonto(mapView)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pessoas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pessoas", for: indexPath) as! PessoasCollectionViewCell
        
        cell.fotoPessoa.image = UIImage (named: pessoas[indexPath.row][0])
        cell.nome.text = pessoas[indexPath.row][1]
        return cell
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor(colorLiteralRed: 0.78, green:  0.192, blue:  0.141, alpha: 1)
        renderer.lineWidth = 4.0
        
        return renderer
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

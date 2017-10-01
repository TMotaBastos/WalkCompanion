//
//  DescricaoTrajetoViewController.swift
//  ProjetoFinal
//
//  Created by Thiago Mota Bastos on 9/22/17.
//  Copyright © 2017 Thiago Mota Bastos. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase
import FirebaseStorage

class DescricaoTrajetoViewController: UIViewController, MKMapViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    struct Items {
        let image: UIImage
        let name: String
    }
    
    var obj:[String]?
    
    @IBOutlet weak var lblRoute: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var PessoasCollection: UICollectionView!
    @IBOutlet weak var mapView: MKMapView!
    var pinos:[Pinos] = []
    var pessoas:[Items] = []
    //var pessoas = [["dog","cachorrinho"],["dog","cachorrinho"],["dog","cachorrinho"],["dog","cachorrinho"],["dog","cachorrinho"],["dog","cachorrinho"],["dog","cachorrinho"]]
    
    var saida:String = ""
    var destino:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //var ret = obj![0].characters.split(separator: " -> ")
        var ret = obj![0].components(separatedBy: " -> ")
        print(ret)
        saida = ret[0]
        destino = ret[1]
        
        self.lblRoute.text = obj![0]
        self.lblTime.text = obj![1]
        initPinos()
        loadPeople()
        self.PessoasCollection.delegate = self
        self.PessoasCollection.dataSource = self
        //pino.adcPonto(mapView,pinos)
        mapView.delegate = self
        func centerMapOnLocation(location: CLLocation) {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,2000, 2000)
            mapView.setRegion(coordinateRegion, animated: true)
        }
        centerMapOnLocation(location: CLLocation(latitude: -8.051779, longitude: -34.950013))
        
    }
    func initPinos () {
        pinos.append(Pinos(latitude: -8.05649, longitude: -34.9535, nome: "Area 2"))
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
            if pino.nome == saida || pino.nome == destino{
                pino.adcPonto(mapView)
            }
        }
    }
    
    func loadPeople() {
        let pathId = obj![0].replacingOccurrences(of: "/", with: "-")
        let dataId = obj![1].replacingOccurrences(of: "/", with: "-")
        let key = pathId + " -> " + dataId
        
        let storage = Database.database().reference()
        let imageStorage = Storage.storage().reference()
        let pathsRef = storage.child("paths").child(key).child("users")
        let userImageRef = imageStorage.child("images")
        let usersRef = storage.child("users")
        
        pathsRef.observe(DataEventType.value, with: { (snapshot) in
            var pathData = snapshot.value as? [String : AnyObject] ?? [:]
            print(pathData)
            
            for d in pathData {
                userImageRef.child(d.key).child("profile.jpg").getData(maxSize: 2 * 1024 * 1024) { data, error in
                    let image = UIImage(data: data!)
                    
                    usersRef.child(d.key).observe(DataEventType.value, with: { (snapshot) in
                        var pathData = snapshot.value as? [String : AnyObject] ?? [:]
                        print(pathData)
                        
                        self.pessoas.append(Items(image: image!, name: pathData["name"] as! String))
                        self.PessoasCollection.reloadData()
                    })
                }
            }
            //self.tableView.reloadData()
        })
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
        
        //cell.fotoPessoa.image = UIImage (named: pessoas[indexPath.row][0])
        //cell.nome.text = pessoas[indexPath.row][1]
        cell.fotoPessoa.image = pessoas[indexPath.row].image
        cell.nome.text = pessoas[indexPath.row].name
        
        return cell
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

//
//  Pinos.swift
//  ProjetoFinal
//
//  Created by Barbara Cristina Lima de Oliveira on 9/27/17.
//  Copyright © 2017 Thiago Mota Bastos. All rights reserved.
//

import Foundation
import MapKit

class Pinos {
    var latitude:CLLocationDegrees?
    var longitude:CLLocationDegrees?
    let nome:String?
    //var pinos:[Pinos] = []
    
    init (latitude:CLLocationDegrees,longitude:CLLocationDegrees,nome:String) {
        self.longitude = longitude
        self.latitude = latitude
        self.nome = nome
        
    }
//    init (_ pinos:[Pinos],_ mapa: MKMapView){
//        adcPonto(pinos,mapa)
//    }
//    func retornaPinos () -> [Pinos]{
//        return self.pinos
//    }
    
    func adcPonto (_ mapa: MKMapView/*,_ pinos:[Pinos]*/){

        //for c in pinos {
        let startCoord = CLLocationCoordinate2DMake(latitude!,longitude!)
        let adjustedRegion = mapa.regionThatFits(MKCoordinateRegionMakeWithDistance(startCoord, 1000, 1000))
        mapa.setRegion(adjustedRegion, animated: true)
        let annotation = MKPointAnnotation()
        annotation.title = nome
        annotation.coordinate = startCoord
        mapa.addAnnotation(annotation)
      //}
    }
    

    

    
}






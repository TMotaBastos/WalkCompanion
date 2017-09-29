//
//  Path.swift
//  ProjetoFinal
//
//  Created by Thiago Mota Bastos on 9/29/17.
//  Copyright © 2017 Thiago Mota Bastos. All rights reserved.
//

import Foundation

class Path {
    let nome:String?
    let data:String?
    let users:[String]?
    
    init(nome:String, data:String, users:[String]) {
        self.nome = nome
        self.data = data
        self.users = users
    }
}

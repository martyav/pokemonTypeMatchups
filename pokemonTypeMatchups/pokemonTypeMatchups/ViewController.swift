//
//  ViewController.swift
//  pokemonTypeMatchups
//
//  Created by Marty Avedon on 1/1/17.
//  Copyright © 2017 Marty Hernandez Avedon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mon = Pokemon(type1: .Normal, type2: .None)
        mon.listTypes()
        mon.defensivelyStrongAgainst()
        mon.defensivelyWeakAgainst()
        mon.offensivelyStrongAgainst()
        mon.offensivelyWeakAgainst()
        
        let mon2 = Pokemon(type1: .Dark, type2: .Fighting)
        mon2.listTypes()
        mon2.defensivelyStrongAgainst()
        mon2.defensivelyWeakAgainst()
        mon2.offensivelyStrongAgainst()
        mon2.offensivelyWeakAgainst()
    }
}


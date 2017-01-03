//
//  ViewController.swift
//  pokemonTypeMatchups
//
//  Created by Marty Avedon on 1/1/17.
//  Copyright © 2017 Marty Hernandez Avedon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var presentOutput: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mon = Pokemon(type1: .Water, type2: .Flying)
        print(mon.listTypes())
        print(mon.defensivelyStrongAgainst())
        print(mon.defensivelyWeakAgainst())
        print(mon.offensivelyStrongAgainst())
        print(mon.offensivelyWeakAgainst())
        print(" ")
        let mon2 = Pokemon(type1: .Dark, type2: .Fairy)
        mon2.listTypes()
        mon2.defensivelyStrongAgainst()
        mon2.defensivelyWeakAgainst()
        mon2.offensivelyStrongAgainst()
        mon2.offensivelyWeakAgainst()
        print(" ")
        let mon3 = Pokemon(type1: .Ghost, type2: .Normal)
        mon3.listTypes()
        mon3.defensivelyStrongAgainst()
        mon3.defensivelyWeakAgainst()
        mon3.offensivelyStrongAgainst()
        mon3.offensivelyWeakAgainst()
    }
}


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
        
        let mon = Pokemon(name: "Gyrados", type1: .Water, type2: .Flying)
        presentOutput.text = mon.listTypes() + "\n\n" + mon.defenseOverview() + "\n\n" + mon.offenseOverview()
    }
}


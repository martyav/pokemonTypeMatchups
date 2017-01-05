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
        
        let mon = Pokemon(name: "Pyroar", type1: .Fire, type2: .Normal)
        presentOutput.text = mon.listTypes() + "\n\n" + mon.offenseOverview() + "\n\n" + mon.defenseOverview()
    }
}


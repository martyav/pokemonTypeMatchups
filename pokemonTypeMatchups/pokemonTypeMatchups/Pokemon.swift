//
//  Pokemon.swift
//  pokemonTypeMatchups
//
//  Created by Marty Avedon on 1/1/17.
//  Copyright © 2017 Marty Hernandez Avedon. All rights reserved.
//

import Foundation

class Pokemon {
    let type1: Type
    let type2: Type
    
    init(type1: Type, type2: Type) {
        self.type1 = type1
        self.type2 = type2
    }
    
    func listTypes() {
        if type2 != .None {
            print("This Pokemon is \(type1) and \(type2).")
        } else {
            print("This Pokemon is \(type1).")
        }
    }
    
    func removeDoubles(type1: [Type], type2: [Type]) -> [Type] {
        let washer: Set<Type>
        let cleanArray: [Type]
        
        if type2 != [.None] {
            washer = Set(type1).union(Set(type2))
        } else {
            washer = Set(type1)
        }
        
        cleanArray = Array(washer)
        
        return cleanArray
    }
    
    func listResists() {
        let resistsAgainst: [Type] = self.removeDoubles(type1: type1.resists(), type2: type2.resists())
        
        guard resistsAgainst != [] else {
            print("This pokemon has no resistances.")
            return
        }
        
        print("This pokemon resists: ", terminator: "" )
        for type in resistsAgainst {
            if resistsAgainst.index(of: type) != resistsAgainst.count - 1 {
                print(type, terminator: ", ")
            } else {
                print("and \(type).")
            }
        }
    }
    
    func listDoubleResistances() {
        let resistsAgainst = type1.resists() + type2.resists()
        let checker = self.removeDoubles(type1: type1.resists(), type2: type2.resists())
        var numberOfTimesItAppears: [Type: Int] = [:]
        var cleanArray: [Type] = []
        
        guard resistsAgainst.count != checker.count else { return }
        
        for index in checker {
            var counter = 0
            for jindex in resistsAgainst {
                if jindex == index {
                    counter += 1
                }
                numberOfTimesItAppears[index] = counter
            }
        }
        
        for (key, value) in numberOfTimesItAppears {
            if value > 1 {
                cleanArray.append(key)
            }
        }
        
        print("This pokemon double-resists ", terminator: "")
        for type in cleanArray {
            if cleanArray.count == 1 {
                print("\(type).")
            } else if cleanArray.index(of: type) != resistsAgainst.count - 1 {
                print(type, terminator: ", ")
            } else {
                print("and \(type).")
            }
        }

    }
    
}


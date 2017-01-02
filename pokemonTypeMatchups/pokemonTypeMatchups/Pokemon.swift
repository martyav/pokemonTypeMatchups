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
    
    // MARK: - Helper Functions for Determining Effectiveness
    
    func removeDoubles(type1Arr: [Type], type2Arr: [Type]) -> [Type] {
        let washer: Set<Type>
        let uniques: [Type]
        
        washer = Set(type1Arr).union(Set(type2Arr))
        uniques = Array(washer)
        
        return uniques
    }
    
    func keepDoubles(type1Arr: [Type], type2Arr: [Type]) -> [Type]? {
        let uniques = removeDoubles(type1Arr: type1Arr, type2Arr: type2Arr)
        let checkMe = type1Arr + type2Arr
        var numberOfTimesItAppears: [Type: Int]
        var doubles: [Type]?
        
        guard uniques.count != checkMe.count else { return nil }
        
        numberOfTimesItAppears = [:]
        doubles = []
        
        for valueWereCheckingAgainst in uniques {
            var counter = 0
            for valueWereChecking in checkMe {
                if valueWereChecking == valueWereCheckingAgainst {
                    counter += 1
                }
                numberOfTimesItAppears[valueWereChecking] = counter
            }
        }
        
        for (key, value) in numberOfTimesItAppears {
            if value > 1 {
                doubles!.append(key)
            }
        }
        
        return doubles
    }
    
    // MARK: - Defense Logic
    
    func weakTo() -> [Type] {
        if type2 == .None {
            return type1.weakTo()
        } else {
            return removeDoubles(type1Arr: type1.weakTo(), type2Arr: type2.weakTo())
        }
    }
    
    func doubleWeakTo() -> [Type]? {
        return keepDoubles(type1Arr: type1.weakTo(), type2Arr: type2.weakTo())
    }
    
    func resists() -> [Type] {
        if type2 == .None {
            return type1.resists()
        } else {
            return removeDoubles(type1Arr: type1.resists(), type2Arr: type2.resists())
        }
    }
    
    func doubleResists() -> [Type]? {
        return keepDoubles(type1Arr: type1.resists(), type2Arr: type2.resists())
    }
    
    func immuneTo() -> [Type]? {
        if type2 == .None {
            return type1.immuneTo()
        } else {
            return type1.immuneTo()! + type2.immuneTo()!
        }
    }
    
    func defensivelyStrongAgainst() {
        listResists()
        if type2 != .None {
            listDoubleResists()
        }
        listImmunities()
    }
    
    func defensivelyWeakAgainst() {
        listWeaknesses()
        if type2 != .None {
            listDoubleWeaknesses()
        }
    }
    
    // MARK: - Offense Logic
    
    func strongAgainst() -> [Type] {
        if type2 == .None {
            return type1.superEffectiveAgainst()
        } else {
            return removeDoubles(type1Arr: type1.superEffectiveAgainst(), type2Arr: type2.superEffectiveAgainst())
        }
    }
    
    func doubleStrongAgainst() -> [Type]? {
        return keepDoubles(type1Arr: type1.superEffectiveAgainst(), type2Arr: type2.superEffectiveAgainst())
    }
    
    func notVeryEffectiveAgainst() -> [Type] {
        if type2 == .None {
            return type1.notVeryEffectiveAgainst()
        } else {
            return removeDoubles(type1Arr: type1.notVeryEffectiveAgainst(), type2Arr: type2.notVeryEffectiveAgainst())
        }
    }
    
    func doubleNotEffectiveAgainst() -> [Type]? {
        return keepDoubles(type1Arr: type1.notVeryEffectiveAgainst(), type2Arr: type2.notVeryEffectiveAgainst())
    }
    
    func uselessAgainst() -> [Type]? {
        return type1.uselessAgainst() + type2.uselessAgainst()
    }
    
    // MARK: - Misc. User Output
    
    func listTypes() {
        if type2 != .None {
            print("This Pokemon is \(type1) and \(type2).")
        } else {
            print("This Pokemon is \(type1).")
        }
    }
    
    // MARK: - User Output for DEFENSE
    
    func listWeaknesses() {
        let weaknesses = weakTo()
        
        print("This pokemon is weak to ", terminator: "" )
        for type in weaknesses {
            if weaknesses.index(of: type) != weaknesses.count - 1 {
                print(type, terminator: ", ")
            } else {
                print("and \(type).")
            }
        }
    }
    
    func listDoubleWeaknesses() {
        let doubleWeaknesses = doubleWeakTo()
        
        print("This pokemon is double-weak to ", terminator: "")
        if let unwrapdoubleWeaknesses = doubleWeaknesses {
            for type in unwrapdoubleWeaknesses {
                if unwrapdoubleWeaknesses.count == 1 {
                    print("\(type).")
                } else if unwrapdoubleWeaknesses.index(of: type) != unwrapdoubleWeaknesses.count - 1 {
                    print(type, terminator: ", ")
                } else {
                    print("and \(type).")
                }
            }
        } else {
            print("This pokemon has no double-weaknesses")
        }
    }
    
    func listResists() {
        let resistsAgainst = resists()
        
        guard resistsAgainst != [] else {
            print("This pokemon has no resistances.")
            return
        }
        
        print("This pokemon resists against ", terminator: "" )
        for type in resistsAgainst {
            if resistsAgainst.index(of: type) != resistsAgainst.count - 1 {
                print(type, terminator: ", ")
            } else {
                print("and \(type).")
            }
        }
    }
    
    func listDoubleResists() {
        let doubleResistsAgainst = doubleResists()
        
        print("This pokemon double-resists ", terminator: "")
        if let unwrapDoubleResistsAgainst = doubleResistsAgainst {
            for type in unwrapDoubleResistsAgainst {
                if unwrapDoubleResistsAgainst.count == 1 {
                    print("\(type).")
                } else if unwrapDoubleResistsAgainst.index(of: type) != unwrapDoubleResistsAgainst.count - 1 {
                    print(type, terminator: ", ")
                } else {
                    print("and \(type).")
                }
            }
        } else {
            print("This pokemon has no double-resistances")
        }
    }
    
    func listImmunities() {
        print("This pokemon is immune to ", terminator: "")
        if let unwrapImmunites = immuneTo() {
            for type in unwrapImmunites {
                if unwrapImmunites.count == 1 {
                    print("\(type).")
                } else if unwrapImmunites.index(of: type) != unwrapImmunites.count - 1 {
                    print(type, terminator: ", ")
                } else {
                    print("and \(type).")
                }
            }
        } else {
            print("This pokemon is not immune to any attacks.")
        }
    }
    
    // MARK: - User Output for OFFENSE
    
    func listStrongAgainst() {
        let superEffectives = strongAgainst()
        
        print("This pokemon is super-effective against ", terminator: "" )
        for type in superEffectives {
            if superEffectives.index(of: type) != superEffectives.count - 1 {
                print(type, terminator: ", ")
            } else {
                print("and \(type).")
            }
        }
    }
    
    func listDoubleStrongAgainst() {
        let doubleSuperEffectives = doubleStrongAgainst()
        
        print("This pokemon is twice as super-effective against ", terminator: "")
        if let unwrapdoubleSuperEffectives = doubleSuperEffectives {
            for type in unwrapdoubleSuperEffectives {
                if unwrapdoubleSuperEffectives.count == 1 {
                    print("\(type).")
                } else if unwrapdoubleSuperEffectives.index(of: type) != unwrapdoubleSuperEffectives.count - 1 {
                    print(type, terminator: ", ")
                } else {
                    print("and \(type).")
                }
            }
        }
    }
    
    func listNotVeryEffectiveAgainst() {
        let ineffectives = notVeryEffectiveAgainst()
        
        print("This pokemon is not very effective against ", terminator: "" )
        for type in ineffectives {
            if ineffectives.index(of: type) != ineffectives.count - 1 {
                print(type, terminator: ", ")
            } else {
                print("and \(type).")
            }
        }
    }
    
    func listDoubleNotEffectiveAgainst() {
        let doubleIneffectives = doubleNotEffectiveAgainst()
        
        print("This pokemon is doubly not very effective against ", terminator: "")
        if let unwrapdoubleIneffectives = doubleIneffectives {
            for type in unwrapdoubleIneffectives {
                if unwrapdoubleIneffectives.count == 1 {
                    print("\(type).")
                } else if unwrapdoubleIneffectives.index(of: type) != unwrapdoubleIneffectives.count - 1 {
                    print(type, terminator: ", ")
                } else {
                    print("and \(type).")
                }
            }
        }
    }
    
    func listUselessAgainst() {
        print("This pokemon is useless against ", terminator: "")
        if let unwrapUseless = uselessAgainst() {
            for type in unwrapUseless {
                if unwrapUseless.count == 1 {
                    print("\(type).")
                } else if unwrapUseless.index(of: type) != unwrapUseless.count - 1 {
                    print(type, terminator: ", ")
                } else {
                    print("and \(type).")
                }
            }
        }
    }
    
}


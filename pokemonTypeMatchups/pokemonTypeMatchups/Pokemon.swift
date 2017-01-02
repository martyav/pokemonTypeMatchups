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
                numberOfTimesItAppears[valueWereCheckingAgainst] = counter
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
        guard type1.immuneTo() != [.None] else {
            return nil
        }
        
        if type2 == .None {
            return type1.immuneTo()
        } else {
            if type2.immuneTo() != [.None] {
                return type1.immuneTo() + type2.immuneTo()
            } else {
                return type1.immuneTo()
            }
        }
    }
    
    func defensivelyStrongAgainst() {
        listResists()
        if type2 != .None {
            listDoubleResists()
        }
        if immuneTo() != nil {
            listImmunities()
        }
    }
    
    func defensivelyWeakAgainst() {
        listWeaknesses()
        if type2 != .None && doubleWeakTo() != nil {
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
        guard type1.uselessAgainst() != [.None] else {
            return nil
        }
        
        if type2 == .None {
            return type1.uselessAgainst()
        } else {
            if type2.uselessAgainst() != [.None] {
                return type1.uselessAgainst() + type2.uselessAgainst()
            } else {
                return type1.uselessAgainst()
            }
        }
    }
    
    func offensivelyStrongAgainst() {
        listStrongAgainst()
        if type2 != .None && doubleStrongAgainst() != nil {
            listDoubleStrongAgainst()
        }
    }
    
    func offensivelyWeakAgainst() {
        listNotVeryEffectiveAgainst()
        if type2 != .None  && doubleNotEffectiveAgainst() != nil {
            listDoubleNotEffectiveAgainst()
        }
        if uselessAgainst() != nil {
            listUselessAgainst()
        }
    }
    
    // Defending Against Moves When Types Differ On Effectiveness...
    
    func ensureNoOverlapBtwnSuperAndIneffectives() -> [Type]? {
        let notEffective = notVeryEffectiveAgainst()
        let superEffective = strongAgainst()
        
        let checkForOverLap = keepDoubles(type1Arr: notEffective, type2Arr: superEffective)
        
        return checkForOverLap
    }
    
    func cleanOfOverlaps() -> [Type] {
        let superEffectives = strongAgainst()
        let checkForOverLap = ensureNoOverlapBtwnSuperAndIneffectives()
        var cleanOfOverLap: [Type]
        
        guard superEffectives != [.None] else { return [] }
        
        if let overlappingEffectiveness = checkForOverLap {
            cleanOfOverLap = []
            
            for type in superEffectives {
                if overlappingEffectiveness.contains(type) {
                    continue
                } else {
                    cleanOfOverLap.append(type)
                }
            }
            return cleanOfOverLap
        }
        return superEffectives
    }
    
    // MARK: - Misc. User Output
    
    func listTypes() {
        if type2 != .None {
            print("This pokemon is \(type1) and \(type2).")
        } else {
            print("This pokemon is \(type1).")
        }
    }
    
    // MARK: - User Output for DEFENSE
    
    func listWeaknesses() {
        let weaknesses = weakTo()
        
        guard weaknesses != [.None] else { return }
        
        print("This pokemon is weak to ", terminator: "" )
        for type in weaknesses {
            if weaknesses.count == 1 {
                print("\(type) moves.")
            } else if weaknesses.index(of: type) != weaknesses.count - 1 {
                print(type, terminator: ", ")
            } else {
                print("and \(type) moves.")
            }
        }
    }
    
    func listDoubleWeaknesses() {
        let doubleWeaknesses = doubleWeakTo()
        
        print("This pokemon is double-weak to ", terminator: "")
        if let unwrapdoubleWeaknesses = doubleWeaknesses {
            for type in unwrapdoubleWeaknesses {
                if unwrapdoubleWeaknesses.count == 1 {
                    print("\(type) moves.")
                } else if unwrapdoubleWeaknesses.index(of: type) != unwrapdoubleWeaknesses.count - 1 {
                    print(type, terminator: ", ")
                } else {
                    print("and \(type) moves.")
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
        
        print("This pokemon resists ", terminator: "" )
        for type in resistsAgainst {
            if resistsAgainst.count == 1 {
                print("\(type) moves.")
            }
            else if resistsAgainst.index(of: type) != resistsAgainst.count - 1 {
                print(type, terminator: ", ")
            } else {
                print("and \(type) moves.")
            }
        }
    }
    
    func listDoubleResists() {
        let doubleResistsAgainst = doubleResists()
        
        if let unwrapDoubleResistsAgainst = doubleResistsAgainst {
            print("This pokemon double-resists ", terminator: "")
            
            for type in unwrapDoubleResistsAgainst {
                if unwrapDoubleResistsAgainst.count == 1 {
                    print("\(type) moves.")
                } else if unwrapDoubleResistsAgainst.index(of: type) != unwrapDoubleResistsAgainst.count - 1 {
                    print(type, terminator: ", ")
                } else {
                    print("and \(type) moves.")
                }
            }
        }
    }
    
    func listImmunities() {
        let immunities = immuneTo()
        
        print("This pokemon is immune to ", terminator: "")
        if let unwrapImmunites = immunities {
            for type in unwrapImmunites {
                if unwrapImmunites.count == 1 {
                    print("\(type) moves.")
                } else if unwrapImmunites.index(of: type) != unwrapImmunites.count - 1 {
                    print(type, terminator: ", ")
                } else {
                    print("and \(type) moves.")
                }
            }
        } else {
            print("This pokemon is not immune to any attacks.")
        }
    }
    
    // MARK: - User Output for OFFENSE
    
    func listStrongAgainst() {
        var superEffectives = strongAgainst()
        
        print("This pokemon's STAB moves are super-effective against ", terminator: "" )
        
        for type in superEffectives {
            if superEffectives.count == 1 {
                print("\(type) types.")
            } else if superEffectives.index(of: type) != superEffectives.count - 1 {
                print(type, terminator: ", ")
            } else {
                print("and \(type) types.")
            }
        }
        
        print("Specifically, its \(type1) moves are super-effective against ", terminator: "")
        
        for type in type1.superEffectiveAgainst() {
            if type1.superEffectiveAgainst().count == 1 {
                print("\(type) types.")
            } else if type1.superEffectiveAgainst().index(of: type) != type1.superEffectiveAgainst().count - 1 {
                print(type, terminator: ", ")
            } else {
                print("and \(type) types.")
            }
        }
        
        if type2 != .None {
            print("Its \(type2) moves are super-effective against ", terminator: "")
            
            for type in type2.superEffectiveAgainst() {
                if type2.superEffectiveAgainst().count == 1 {
                    print("\(type) types.")
                } else if type2.superEffectiveAgainst().index(of: type) != type2.superEffectiveAgainst().count - 1 {
                    print(type, terminator: ", ")
                } else {
                    print("and \(type) types, too.")
                }
            }
        }
    }
    
    func listDoubleStrongAgainst() {
        let doubleSuperEffectives = doubleStrongAgainst()
        
        if let unwrapdoubleSuperEffectives = doubleSuperEffectives {
            print("This pokemon is twice as super-effective against ", terminator: "")
            
            for type in unwrapdoubleSuperEffectives {
                if unwrapdoubleSuperEffectives.count == 1 {
                    print("\(type) types.")
                } else if unwrapdoubleSuperEffectives.index(of: type) != unwrapdoubleSuperEffectives.count - 1 {
                    print(type, terminator: ", ")
                } else {
                    print("and \(type) types.")
                }
            }
        }
    }
    
    func listNotVeryEffectiveAgainst() {
        var ineffectives = notVeryEffectiveAgainst()
        let checkForOverLap = ensureNoOverlapBtwnSuperAndIneffectives()
        var cleanOfOverLap: [Type]
        
        guard ineffectives != [.None] else { return }
        
        if let overlappingEffectiveness = checkForOverLap {
            cleanOfOverLap = []
            
            for type in ineffectives {
                if overlappingEffectiveness.contains(type) {
                    continue
                } else {
                    cleanOfOverLap.append(type)
                }
            }
            ineffectives = cleanOfOverLap
        }
        
        guard ineffectives != [] else { return }
        
        print("This pokemon's STAB moves are not very effective against ", terminator: "" )
        
        for type in ineffectives {
            if ineffectives.count == 1 {
                print("\(type) types.")
            } else if ineffectives.index(of: type) != ineffectives.count - 1 {
                print(type, terminator: ", ")
            } else {
                print("and \(type) types.")
            }
        }
        
        print("Specifically, its \(type1) moves are not very effective against ", terminator: "")
        
        for type in type1.notVeryEffectiveAgainst() {
            if type1.notVeryEffectiveAgainst().count == 1 {
                print("\(type) types.")
            } else if type1.notVeryEffectiveAgainst().index(of: type) != type1.notVeryEffectiveAgainst().count - 1 {
                print(type, terminator: ", ")
            } else {
                print("and \(type) types.")
            }
        }
        
        if type2 != .None {
            print("Its \(type2) moves are not very effective against ", terminator: "")
            
            for type in type2.notVeryEffectiveAgainst() {
                if type2.notVeryEffectiveAgainst().count == 1 {
                    print("\(type) types.")
                } else if type2.notVeryEffectiveAgainst().index(of: type) != type2.notVeryEffectiveAgainst().count - 1 {
                    print(type, terminator: ", ")
                } else {
                    print("and \(type) types, either.")
                }
            }
        }
    }
    
    func listDoubleNotEffectiveAgainst() {
        let doubleIneffectives = doubleNotEffectiveAgainst()
    
        if let unwrapdoubleIneffectives = doubleIneffectives {
            print("This pokemon is doubly not very effective against ", terminator: "")
            
            for type in unwrapdoubleIneffectives {
                if unwrapdoubleIneffectives.count == 1 {
                    print("\(type) types.")
                } else if unwrapdoubleIneffectives.index(of: type) != unwrapdoubleIneffectives.count - 1 {
                    print(type, terminator: ", ")
                } else {
                    print("and \(type) types.")
                }
            }
        }
    }
    
    func listUselessAgainst() {
        let useless = uselessAgainst()
        
        if let unwrapUseless = useless {
            
            for type in unwrapUseless {
                if unwrapUseless.count == 1 {
                    print("\(type)", terminator: " ")
                } else if unwrapUseless.index(of: type) != unwrapUseless.count - 1 {
                    print(type, terminator: ", ")
                } else {
                    print("and \(type)", terminator: " ")
                }
            }
            print(" types are immune to this Pokemon's STAB attacks.")
        }
        
        print("Specifically, its \(type1) moves are useless against ", terminator: "")
        
        for type in type1.immuneTo() {
            if type1.immuneTo().count == 1 {
                print("\(type) types.")
            } else if type1.immuneTo().index(of: type) != type1.immuneTo().count - 1  {
                print("\(type) types ")
            } else {
                print("and \(type) types.")
            }
        }
        
        if type2 != .None {
            print("Its \(type2) moves are also useless against ", terminator: "")
            
            for type in type2.immuneTo() {
                if type2.immuneTo().count == 1 {
                    print("\(type) types.")
                } else if type1.immuneTo().index(of: type) != type1.immuneTo().count - 1  {
                    print("\(type) types ")
                } else {
                    print("and \(type) types.")
                }
            }
        }

    }
    
}


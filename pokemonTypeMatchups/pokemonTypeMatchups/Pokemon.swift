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
    
    init(type1: Type, type2: Type = .None) {
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
    }
    
    func defensivelyWeakAgainst() {
        listWeaknesses()
    }
    
    // MARK: - Offense Logic
    
    func strongAgainst() -> [Type] {
        if type2 == .None {
            return type1.superEffectiveAgainst()
        } else {
            return removeDoubles(type1Arr: type1.superEffectiveAgainst(), type2Arr: type2.superEffectiveAgainst())
        }
    }
    
    //    func doubleStrongAgainst() -> [Type]? {
    //        return keepDoubles(type1Arr: type1.superEffectiveAgainst(), type2Arr: type2.superEffectiveAgainst())
    //    }
    
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
        //        if type2 != .None && doubleStrongAgainst() != nil {
        //            listDoubleStrongAgainst()
        //        }
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
    
    func keepTypeOverlapsThatCancelOut() -> [Type] {
        let weakTo: [Type]
        if let immunities = self.immuneTo() {
            weakTo = self.weakTo() + immunities
        } else {
            weakTo = self.weakTo()
        }
        let resists = self.resists()
        
        var keepers: [Type] = []
        
        for type in weakTo {
            for otherType in resists {
                if type == otherType {
                    keepers.append(type)
                }
            }
        }
        
        return keepers
    }
    
    func removeTypeOverlapsThatCancelOut() -> [Type] {
        let weakTo: [Type]
        if let immunities = self.immuneTo() {
            weakTo = self.weakTo() + immunities
        } else {
            weakTo = self.weakTo()
        }
        let resists = self.resists()
        
        var keepers: [Type] = weakTo
        
        for type in weakTo {
            for otherType in resists {
                if type == otherType {
                    keepers.remove(at: keepers.index(of: type)!)
                }
            }
        }
        
        return keepers
    }
    
    // MARK: - Misc. User Output
    
    func listTypes() -> String {
        let response: String
        
        if type2 != .None {
            response = "This pokemon is \(type1) and \(type2). "
        } else {
            response = "This pokemon is \(type1). "
        }
        
        return response
    }
    
    // MARK: - User Output for DEFENSE
    
    func listWeaknesses() -> String {
        var response: String = ""
        
        let weaknesses = removeTypeOverlapsThatCancelOut()
        
        guard weaknesses != [.None] || weaknesses != [] else {
            response += "This pokemon has no weaknesses. "
            return response
        }
        
        response += "This pokemon is weak to "
        
        if let doubleWeak = doubleWeakTo() {
            for type in weaknesses where type != .None {
                if weaknesses.count == 1 && doubleWeak.contains(type) {
                    response += "\(type) moves (double-weak). "
                } else if weaknesses.count == 1 {
                    response += "\(type) moves."
                } else if weaknesses.index(of: type) != weaknesses.count - 1  && doubleWeak.contains(type) {
                    response += "\(type) (double-weak), "
                } else if weaknesses.index(of: type) != weaknesses.count - 1 {
                    response += "\(type), "
                } else if doubleWeak.contains(type) {
                    response += "and \(type) moves (double-weak). "
                } else {
                    response += "and \(type) moves. "
                }
            }
        } else {
            for type in weaknesses where type != .None {
                if weaknesses.count == 1 {
                    response += "\(type) moves."
                } else if weaknesses.index(of: type) != weaknesses.count - 1 {
                    response += "\(type), "
                } else {
                    response += "and \(type) moves. "
                }
            }
        }
        
        return response
    }
    
    func listDoubleWeaknesses() -> String {
        let doubleWeaknesses = doubleWeakTo()
        
        var response: String = ""
        
        response += "This pokemon is double-weak to "
        
        if let unwrapdoubleWeaknesses = doubleWeaknesses {
            for type in unwrapdoubleWeaknesses where type != .None {
                if unwrapdoubleWeaknesses.count == 1 {
                    response += "\(type) moves. "
                } else if unwrapdoubleWeaknesses.index(of: type) != unwrapdoubleWeaknesses.count - 1 {
                    response += "\(type), "
                } else {
                    response += "and \(type) moves. "
                }
            }
        } else {
            response += "This pokemon has no double-weaknesses. "
        }
        
        return response
    }
    
    func listResists() -> String {
        let resistsAgainst = resists()
        
        var response: String = ""
        
        guard resistsAgainst != [] || resistsAgainst != [.None] else {
            response += "This pokemon has no resistances. "
            
            return response
        }
        
        response += "This pokemon resists "
        
        if let immunities = immuneTo() {
            for type in resistsAgainst where type != .None {
                if resistsAgainst.count == 1 && immunities.contains(type) {
                    response += "\(type) moves (immune). "
                } else if resistsAgainst.count == 1 {
                    response += "\(type) moves. "
                } else if resistsAgainst.index(of: type) != resistsAgainst.count - 1 && immunities.contains(type) {
                    response += "\(type) (immune), "
                } else if resistsAgainst.index(of: type) != resistsAgainst.count - 1 {
                    response += "\(type), "
                } else if immunities.contains(type) {
                    response += "and \(type) moves (immune). "
                } else {
                    response += "and \(type) moves. "
                }
            }
        } else {
            
            for type in resistsAgainst where type != .None {
                if resistsAgainst.count == 1 {
                    response += "\(type) moves. "
                }
                else if resistsAgainst.index(of: type) != resistsAgainst.count - 1 {
                    response += "\(type), "
                } else {
                    response += "and \(type) moves. "
                }
            }
        }
        
        return response
    }
    
    func listDoubleResists() -> String {
        let doubleResistsAgainst = doubleResists()
        
        var response: String = ""
        
        if let unwrapDoubleResistsAgainst = doubleResistsAgainst {
            response += "This pokemon double-resists "
            
            for type in unwrapDoubleResistsAgainst where type != .None {
                if unwrapDoubleResistsAgainst.count == 1 {
                    response += "\(type) moves. "
                } else if unwrapDoubleResistsAgainst.index(of: type) != unwrapDoubleResistsAgainst.count - 1 {
                    response += "\(type), "
                } else {
                    response += "and \(type) moves. "
                }
            }
        }
        
        return response
    }
    
    func listImmunities() -> String {
        let immunities = immuneTo()
        
        var response: String = ""
        
        response += "This pokemon is immune to "
        
        if let unwrapImmunites = immunities {
            for type in unwrapImmunites where type != .None {
                if unwrapImmunites.count == 1 {
                    response += "\(type) moves."
                } else if unwrapImmunites.index(of: type) != unwrapImmunites.count - 1 {
                    response += "(type), "
                } else {
                    response += "and \(type) moves. "
                }
            }
        } else {
            response += "This pokemon is not immune to any attacks. "
        }
        
        return response
    }
    
    // MARK: - User Output for OFFENSE
    
    func listStrongAgainst() -> String {
        let superEffectives = strongAgainst()
        
        var response: String = ""
        
        response += "This pokemon's STAB moves are super-effective against "
        
        for type in superEffectives where type != .None {
            if superEffectives.count == 1 {
                response += "\(type) types. "
            } else if superEffectives.index(of: type) != superEffectives.count - 1 {
                response += "\(type), "
            } else {
                response += "and \(type) types. "
            }
        }
        
        response += "Specifically, its \(type1) moves are super-effective against "
        
        for type in type1.superEffectiveAgainst() where type != .None {
            if type1.superEffectiveAgainst().count == 1 {
                response += "\(type) types. "
            } else if type1.superEffectiveAgainst().index(of: type) != type1.superEffectiveAgainst().count - 1 {
                response += "(type), "
            } else {
                response += "and \(type) types. "
            }
        }
        
        if type2.superEffectiveAgainst() != [.None] {
            response += "Its \(type2) moves are super-effective against "
            
            for type in type2.superEffectiveAgainst() where type != .None {
                if type2.superEffectiveAgainst().count == 1 {
                    response += "\(type) types. "
                } else if type2.superEffectiveAgainst().index(of: type) != type2.superEffectiveAgainst().count - 1 {
                    response += "(type), "
                } else {
                    response += "and \(type) types, too. "
                }
            }
        }
        
        return response
    }
    
    //    func listDoubleStrongAgainst() {
    //        let doubleSuperEffectives = doubleStrongAgainst()
    //
    //        if let unwrapdoubleSuperEffectives = doubleSuperEffectives {
    //            print("This pokemon is twice as super-effective against ", terminator: "")
    //
    //            for type in unwrapdoubleSuperEffectives where type != .None {
    //                if unwrapdoubleSuperEffectives.count == 1 {
    //                    print("\(type) types.")
    //                } else if unwrapdoubleSuperEffectives.index(of: type) != unwrapdoubleSuperEffectives.count - 1 {
    //                    print(type, terminator: ", ")
    //                } else {
    //                    print("and \(type) types.")
    //                }
    //            }
    //        }
    //    }
    
    func listNotVeryEffectiveAgainst() -> String {
        let ineffectives = notVeryEffectiveAgainst()
        
        var response: String = ""
        
        guard ineffectives != [.None] else { return response }
        
        response += "This pokemon's STAB moves are not very effective against "
        
        for type in ineffectives where type != .None {
            if ineffectives.count == 1 {
                response += "\(type) types. "
            } else if ineffectives.index(of: type) != ineffectives.count - 1 {
                response += "\(type), "
            } else {
                response += "and \(type) types. "
            }
        }
        
        response += "Specifically, its \(type1) moves are not very effective against "
        
        for type in type1.notVeryEffectiveAgainst() where type != .None {
            if type1.notVeryEffectiveAgainst().count == 1 {
                response += "\(type) types. "
            } else if type1.notVeryEffectiveAgainst().index(of: type) != type1.notVeryEffectiveAgainst().count - 1 {
                response += "\(type), "
            } else {
                response += "and \(type) types. "
            }
        }
        
        if type2 != .None || type2 != .Normal {
            response += "Its \(type2) moves are not very effective against "
            
            for type in type2.notVeryEffectiveAgainst() where type != .None {
                if type2.notVeryEffectiveAgainst().count == 1 {
                    response += "\(type) types."
                } else if type2.notVeryEffectiveAgainst().index(of: type) != type2.notVeryEffectiveAgainst().count - 1 {
                    response += "\(type), "
                } else {
                    response += "and \(type) types, either. "
                }
            }
        }
        
        return response
    }
    
    func listDoubleNotEffectiveAgainst() -> String {
        let doubleIneffectives = doubleNotEffectiveAgainst()
        
        var response: String = ""
        
        if let unwrapdoubleIneffectives = doubleIneffectives {
            response += "This pokemon is doubly not very effective against "
            
            for type in unwrapdoubleIneffectives where type != .None {
                if unwrapdoubleIneffectives.count == 1 {
                    response += "\(type) types."
                } else if unwrapdoubleIneffectives.index(of: type) != unwrapdoubleIneffectives.count - 1 {
                    response += "\(type), "
                } else {
                    response += "and \(type) types."
                }
            }
        }
        
        return response
    }
    
    func listUselessAgainst() -> String {
        let useless = uselessAgainst()
        
        var response: String = ""
        
        if let unwrapUseless = useless {
            
            for type in unwrapUseless where type != .None {
                if unwrapUseless.count == 1 {
                    response += "\(type) "
                } else if unwrapUseless.index(of: type) != unwrapUseless.count - 1 {
                    response += "\(type), "
                } else {
                    response += "and \(type) "
                }
            }
            response += "types are immune to this Pokemon's STAB attacks. "
        }
        
        response += "Specifically, its \(type1) moves are useless against "
        
        for type in type1.immuneTo() where type != .None {
            if type1.immuneTo().count == 1 {
                response += "\(type) types."
            } else if type1.immuneTo().index(of: type) != type1.immuneTo().count - 1  {
                response += "\(type) types, "
            } else {
                response += "and \(type) types."
            }
        }
        
        if type2 != .None {
            response += "Its \(type2) moves are also useless against "
            
            for type in type2.immuneTo() where type != .None {
                if type2.immuneTo().count == 1 {
                    response += "\(type) types."
                } else if type1.immuneTo().index(of: type) != type1.immuneTo().count - 1  {
                    response += "\(type) types, "
                } else {
                    response += "and \(type) types."
                }
            }
        }
        
        return response
    }
    
}

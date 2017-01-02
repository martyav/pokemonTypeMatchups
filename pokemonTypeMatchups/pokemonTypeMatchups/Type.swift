//
//  Type.swift
//  pokemonTypeMatchups
//
//  Created by Marty Avedon on 1/1/17.
//  Copyright © 2017 Marty Hernandez Avedon. All rights reserved.
//

import Foundation

enum Type {
    case Bug
    case Dark
    case Dragon
    case Electric
    case Fairy
    case Fire
    case Fighting
    case Flying
    case Ghost
    case Grass
    case Ground
    case Ice
    case Normal
    case Poison
    case Psychic
    case Rock
    case Steel
    case Water
    case None
    
    func superEffectiveAgainst() -> [Type] {
        switch self {
        case .Bug:
            return [.Psychic, .Grass, .Dark]
        case .Dark:
            return [.Psychic, .Ghost]
        case .Dragon:
            return [.Dragon]
        case .Electric:
            return [.Water, .Flying]
        case .Fairy:
            return [.Dragon, .Dark, .Fighting]
        case .Fighting:
            return [.Dark, .Steel, .Ice, .Rock, .Normal]
        case .Flying:
            return [.Bug, .Fighting, .Grass]
        case .Ghost:
            return [.Ghost, .Psychic]
        case .Grass:
            return [.Water, .Ground, .Rock]
        case .Ground:
            return [.Fire, .Electric, .Steel, .Poison, .Rock]
        case .Ice:
            return [.Grass, .Ground, .Flying, .Dragon]
        case .Normal:
            return [.None]
        case .Poison:
            return [.Grass, .Fairy]
        case .Psychic:
            return [.Fighting, .Poison]
        case .Rock:
            return [.Flying, .Fire, .Ice, .Bug]
        case .Steel:
            return [.Fairy, .Ice, .Rock]
        case .Water:
            return [.Ground, .Rock, .Fire]
        default:
            return [.None]
        }
    }
    
    func weakTo() -> [Type] {
        switch self {
        case .Bug:
            return [.Fire, .Flying, .Rock]
        case .Dark:
            return [.Fighting, .Bug, .Fairy]
        case .Dragon:
            return [.Dragon, .Fairy, .Ice]
        case .Electric:
            return [.Ground]
        case .Fairy:
            return [.Poison, .Steel]
        case .Fighting:
            return [.Fairy, .Psychic, .Flying]
        case .Flying:
            return [.Electric, .Ice, .Rock]
        case .Ghost:
            return [.Ghost, .Dark]
        case .Grass:
            return [.Fire, .Flying, .Ice, .Poison, .Bug]
        case .Ground:
            return [.Water, .Grass, .Ice]
        case .Ice:
            return [.Fire, .Fighting, .Rock, .Steel]
        case .Normal:
            return [.Fighting]
        case .Poison:
            return [.Ground, .Psychic]
        case .Psychic:
            return [.Dark, .Bug, .Ghost]
        case .Rock:
            return [.Water, .Grass, .Fighting, .Steel, .Ground]
        case .Steel:
            return [.Fire, .Fighting, .Ground]
        case .Water:
            return [.Electric, .Grass]
        default:
            return [.None]
        }
    }
    
    func uselessAgainst() -> [Type] {
        switch self {
        case .Dragon:
            return [.Fairy]
        case .Psychic:
            return [.Dark]
        case .Poison:
            return [.Steel]
        case .Ground:
            return [.Flying]
        case .Electric:
            return [.Ground]
        case .Normal:
           return [.Ghost]
        case .Fighting:
            return [.Ghost]
        case .Ghost:
            return [.Normal]
        default:
            return [.None]
        }
    }
    
    func immuneTo() -> [Type] {
        switch self {
        case .Fairy:
            return [.Dragon]
        case .Dark:
            return [.Psychic]
        case .Steel:
            return [.Poison]
        case .Flying:
            return [.Ground]
        case .Ground:
            return [.Electric]
        case .Ghost:
            return [.Normal, .Fighting]
        case .Normal:
            return [.Ghost]
        default:
            return [.None]
        }
    }
    
    func resists() -> [Type] {
        switch self {
        case .Bug:
            return [.Fighting, .Ground, .Grass]
        case .Dark:
            return [.Ghost, .Psychic, .Dark]
        case .Dragon:
            return [.Fire, .Water, .Grass, .Electric]
        case .Electric:
            return [.Flying, .Steel, .Electric]
        case .Fairy:
            return [.Dragon, .Dark, .Fighting, .Bug]
        case .Fighting:
            return [.Rock, .Bug, .Dark]
        case .Flying:
            return [.Bug, .Fighting, .Grass, .Ground]
        case .Ghost:
            return [.Normal, .Fighting, .Poison, .Bug]
        case .Grass:
            return [.Ground, .Grass, .Water, .Electric]
        case .Ground:
            return [.Poison, .Rock, .Electric]
        case .Ice:
            return [.Ice]
        case .Normal:
            return [.Ghost]
        case .Poison:
            return [.Fighting, .Poison, .Bug, .Grass, .Fairy]
        case .Psychic:
            return [.Psychic, .Fighting]
        case .Rock:
            return [.Normal, .Flying, .Poison, .Fire]
        case .Steel:
            return [.Normal, .Flying, .Poison, .Rock, .Bug, .Steel, .Grass, .Psychic, .Ice, .Dragon, .Fairy]
        case .Water:
            return [.Steel, .Fire, .Water, .Ice]
        default:
            return [.None]
        }
    }
    
    func notVeryEffectiveAgainst() -> [Type] {
        switch self {
        case .Bug:
            return [.Fire, .Flying, .Fighting, .Poison, .Fairy, .Ghost, .Steel]
        case .Dark:
            return [.Fighting, .Dark, .Fairy]
        case .Dragon:
            return [.Steel, .Fairy]
        case .Electric:
            return [.Ground, .Grass, .Electric, .Dragon]
        case .Fairy:
            return [.Poison, .Steel, .Fire]
        case .Fighting:
            return [.Fairy, .Psychic, .Flying, .Poison, .Bug]
        case .Flying:
            return [.Electric, .Steel, .Rock]
        case .Ghost:
            return [.Normal, .Dark]
        case .Grass:
            return [.Fire, .Flying, .Steel, .Poison, .Dragon, .Grass]
        case .Ground:
            return [.Bug, .Grass, .Flying]
        case .Ice:
            return [.Fire, .Water, .Ice, .Steel]
        case .Normal:
            return [.Rock, .Steel, .Ghost]
        case .Poison:
            return [.Ground, .Rock, .Poison, .Steel, .Ghost]
        case .Psychic:
            return [.Dark, .Bug, .Ghost]
        case .Rock:
            return [.Water, .Grass, .Fighting, .Steel, .Ground]
        case .Steel:
            return [.Fire, .Steel, .Water, .Electric]
        case .Water:
            return [.Water, .Grass, .Dragon]
        default:
            return [.None]
        }
    }
}

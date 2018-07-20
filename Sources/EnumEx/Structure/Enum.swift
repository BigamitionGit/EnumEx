//
//  Enum.swift
//  EnumEx
//
//  Created by 細田大志 on 2018/07/14.
//

import Foundation
import SourceKittenFramework

struct Enum {
    
    let name: String
    let cases: [String]
    
    private static func canExComputedProperty(structure: Structure)->Bool {
        switch structure.kind {
        case .some(.varInstance):
            guard let name = structure.name, let typeName = structure.typeName else { return true }
            if name == "name", typeName == "String" {
                return false
            } else if name == "index", typeName == "Int" {
                return false
            } else {
                return true
            }
        case .some(.functionMethodInstance):
            guard let name = structure.name, let typeName = structure.typeName else { return true }
            if name == "name()", typeName == "String" {
                return false
            } else if name == "index()", typeName == "Int" {
                return false
            } else {
                return true
            }
        default:
            return true
        }
    }
    
    private static func isEnumcase(structure: Structure)->Bool {
        guard let kind = structure.kind else { return false }
        return kind == .enumcase
    }
    
    private static func toEnumElement(structures: [Structure])->String? {
        let enumElementStructure = structures.first { s in s.kind == .enumelement }
        return enumElementStructure?.name
    }
    
    init?(typeNaem: String, structures: [Structure]) {
        // if it contains structure to can not generate computed property, initialization failed
        guard !structures.contains(where:  { Enum.canExComputedProperty(structure: $0) == false }) else { return nil }
        let enumCases = structures.filter(Enum.isEnumcase)
        let enumElements = enumCases.compactMap { Enum.toEnumElement(structures: $0.substructures) }
        if enumElements.isEmpty { return nil }
        
        name = typeNaem
        cases = enumElements
    }
}

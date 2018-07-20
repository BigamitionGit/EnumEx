//
//  Type.swift
//  EnumEx
//
//  Created by 細田大志 on 2018/07/14.
//

import Foundation
import SourceKittenFramework

struct Type {
    
    enum Kind {
        case `class`
        case `struct`
        case `enum`(Enum?)
        
        
        init?(typeNaem: String, structure: Structure) {
            
            switch structure.kind {
            case .some(.class):
                self = .class
            case .some(.struct):
                self = .struct
            case .some(.enum):
                let enumType = Enum(typeNaem: typeNaem, structures: structure.substructures)
                self = .enum(enumType)
                
            default:
                return nil
            }
        }
    }
    
    let name: String
    let kind: Kind
    let nestedTypes: [Type]
    
    init?(name: String? = nil, structure: Structure) {
        guard let structureName = structure.name else { return nil }
        let typeName = name.map { $0 + structureName } ?? structureName
        guard let kind = Kind(typeNaem: typeName, structure: structure) else { return nil }
        self.name = typeName
        self.kind = kind
        nestedTypes = structure.substructures.compactMap { Type(name: typeName, structure: $0) }
    }
}

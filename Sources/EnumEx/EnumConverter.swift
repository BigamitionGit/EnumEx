//
//  EnumConverter.swift
//  EnumEx
//
//  Created by 細田大志 on 2018/07/20.
//

struct EnumConverter {
    static func convert(type: Type)->[Enum] {
        if case .enum(let en) = type.kind, let e = en {
            return type.nestedTypes.flatMap(convert) + [e]
        } else {
            return type.nestedTypes.flatMap(convert)
        }
    }
}


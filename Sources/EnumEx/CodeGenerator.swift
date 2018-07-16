//
//  CodeGenerator.swift
//  EnumEx
//
//  Created by 細田大志 on 2018/07/17.
//

import Foundation
import Stencil
import SourceKittenFramework

struct CodeGenerator {
    
    init(path: String) throws {
        let files = toFiles(path: path)
        let types = try files
            .map(Structure.init)
        
        for type in types {
            print("structure dictionary \(type.dictionary)")
        }
    }
    
    func generate() throws -> String {
        let template = Template(templateString: "")
        
        return try template.render()
    }
    
    private func toFiles(path: String)-> [File] {
        let fileManager = FileManager.default
        let url = URL(fileURLWithPath: path)
        
        var files = [File]()
        var isDirectory = false as ObjCBool
        if fileManager.fileExists(atPath: url.path, isDirectory: &isDirectory) {
            if isDirectory.boolValue {
                let enumerator = fileManager.enumerator(atPath: path)
                while let subpath = enumerator?.nextObject() as? String {
                    let url = url.appendingPathComponent(subpath)
                    if url.pathExtension == "swift", let file = File(path: url.path) {
                        files.append(file)
                    }
                }
            } else if let file = File(path: url.path) {
                files.append(file)
            }
        }
        return files
    }
}

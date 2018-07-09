import Foundation
import Stencil
import SourceKittenFramework

struct InvalidArgumentsError: Error {}

enum CommandLineInputType {
    case version
    case generate(path: String)
    
    init(input: [String]) throws {
        switch input.count {
        case 2 where input[1] == "--version":
            self = .version
        case 2:
            self = .generate(path: input[1])
        default:
            throw InvalidArgumentsError()
        }
    }
}

struct CodeGenerator {
    
    init(path: String) {
        
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

private func main(arguments: [String]) {
    
    do {
        let inputType = try CommandLineInputType(input: arguments)
        switch inputType {
        case .version:
            print(Version.current)
            exit(0)
        case .generate(let path):
            let generator = CodeGenerator(path: path)
            print(try generator.generate())
        }
    } catch is InvalidArgumentsError {
        
    } catch {
        
    }
    
}


main(arguments: CommandLine.arguments)

import Foundation
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

private func main(arguments: [String]) {
    
    do {
        let inputType = try CommandLineInputType(input: arguments)
        switch inputType {
        case .version:
            print(Version.current)
            exit(0)
        case .generate(let path):
            let generator = try CodeGenerator(path: path)
            print(try generator.generate())
        }
    } catch is InvalidArgumentsError {
        print("invaliderror")
    } catch {
        print("error")
    }
    
}


main(arguments: CommandLine.arguments)

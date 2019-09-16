//
//  PrettyPrintable.swift
//  PrettyPrintable
//
//  Created by Michael Fourre on 9/15/16.
//

public protocol PrettyPrintable: CustomStringConvertible {
    
}

public extension PrettyPrintable {
    var description: String {
        return self.getPropertiesString()
    }
    
    private func getPropertiesString(depth: Int = 0, nameless: Bool = false) -> String {
        var string: String = depth == 0 ? "\n" : ""
        let mirror = Mirror(reflecting: self)
        string += nameless ? "{\n" : "\(mirror.subjectType): {\n"
        for case (let key?, let value) in mirror.children {
            string += self.getPropertyString(key: key, value: value, depth: depth + 1)
        }
        (0 ..< 1).forEach({ _ in string += "    " })
        string += "}\n"
        return string
    }
    
    private func getPropertyString(key: String, value: Any?, string: String = "", depth: Int = 0) -> String {
        var string = string
        (0 ..< 1).forEach({ _ in string += "    " })
        if let value = value.flattened as? PrettyPrintable {
            string += "\(key): \(value.getPropertiesString(depth: depth, nameless: true))"
            string.insert(",", at: string.index(before: string.endIndex))
        } else if let arr = value as? [Any?] {
            if arr.count > 0 {
                string += "\(key): [\n"
                for element in arr {
                    (0 ... 1).forEach({ _ in string += "    " })
                    if let model = element.flattened as? PrettyPrintable {
                        string += model.getPropertiesString(depth: depth + 1)
                        string.insert(",", at: string.index(before: string.endIndex))
                    } else {
                        string += "\(element.flattened ?? "nil"),\n"
                    }
                }
                (0 ..< 1).forEach({ _ in string += "    " })
                string += "],\n"
            } else {
                string += "\(key): []\n"
            }
        } else {
            string += "\(key): \(value.flattened ?? "nil"),\n"
        }
        return string
    }
}

protocol Flattenable {
    var flattened: Any? { get }
}

extension Optional: Flattenable {
    var flattened: Any? {
        switch self {
            case .some(let x as Flattenable): return x.flattened
            case .some(let x): return x
            case .none: return nil
        }
    }
}

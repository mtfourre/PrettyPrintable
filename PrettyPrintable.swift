//
//  PrettyPrintable.swift
//  PrettyPrintable
//
//  Created by Michael Fourre on 9/15/16.
//

public protocol PrettyPrintable {
    func value(forKey key: String) -> Any?
}

public extension PrettyPrintable {
    public var description: String {
        return self.getPropertiesString(self)
    }
    
    fileprivate var properties: [String] {
        return Mirror(reflecting: self).children.compactMap({ $0.label })
    }
    
    public func getPropertiesString(depth: Int = 0, nameless: Bool = false) -> String {
        var string: String = depth == 0 ? "\n\n" : ""
        string += nameless ? "{\n" : "\(Mirror(reflecting: self).subjectType): {\n"
        self.properties.forEach({ string += self.getPropertyString(property: $0, depth: depth + 1) })
        stride(from: 0, to: depth, by: 1).forEach({ _ in string += "    " })
        string += "}\n"
        return string
    }
    
    fileprivate func getPropertyString(property: String, string s: String = "", depth: Int = 0) -> String {
        var string = s
        stride(from: 0, to: depth, by: 1).forEach({ _ in string += "    " })
        if let newProp = self.value(for: property) as? PrettyPrintable {
            string += "\(property): \(newProp.getPropertiesString(depth: depth, nameless: true))"
            string.insert(",", at: string.index(before: string.endIndex))
        } else if let arr = self.value(for: property) as? [Any] {
            if arr.count > 0 {
                string += "\(property): [\n"
                for element in arr {
                    stride(from: 0, through: depth, by: 1).forEach({ _ in string += "    " })
                    if let model = element as? PrettyPrintable {
                        string += model.getPropertiesString(depth: depth + 1)
                        string.insert(",", at: string.index(before: string.endIndex))
                    } else {
                        string += "\(element),\n"
                    }
                }
                stride(from: 0, to: depth, by: 1).forEach({ _ in string += "    " })
                string += "],\n"
            } else {
                string += "\(property): []\n"
            }
        } else if let value = self.value(for: property) {
            string += "\(property): \(value),\n"
        } else {
            string += "\(property): nil,\n"
        }
        return string
    }
}

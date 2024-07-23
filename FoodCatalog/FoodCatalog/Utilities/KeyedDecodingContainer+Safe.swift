//
//  KeyedDecodingContainer+Safe.swift
//  FoodCatalog
//
//  Created by Nivrutti on 23/07/24.
//

import Foundation

extension KeyedDecodingContainer {
     func decodeSafelyIfPresent<T: Decodable>(_ key: KeyedDecodingContainer.Key) -> T? {
        return decodeSafelyIfPresent(T.self, forKey: key)
    }

    func decodeSafelyIfPresent<T: Decodable>(_: T.Type, forKey key: KeyedDecodingContainer.Key) -> T? {
        let decoded = ((try? decodeIfPresent(SafeProcess<T>.self, forKey: key)) as SafeProcess<T>??)
        return decoded??.value
    }
}

public struct SafeProcess<Base: Decodable>: Decodable {
    public let value: Base?
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.singleValueContainer()
            value = try container.decode(Base.self)
        } catch {
            value = nil
        }
    }
}

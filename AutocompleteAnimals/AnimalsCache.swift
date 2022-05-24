//
//  AnimalsCache.swift
//  AutocompleteAnimals
//
//  Created by Jignesh Rajodiya on 2022-05-24.
//

import Foundation

/// The source of all animals names
protocol AnimalsSource {

    func loadAnimals() -> [String]
}

/// The `AnimalsCache` object manages the list of animals names loaded from an external source.
actor AnimalsCache {

    /// Source to load animals names.
    let source: AnimalsSource

    init(source: AnimalsSource) {
        self.source = source
    }

    /// The list of animals names.
    var animals: [String] {
        if let animals = cachedAnimals {
            return animals
        }

        let animals = source.loadAnimals()
        cachedAnimals = animals

        return animals
    }

    private var cachedAnimals: [String]?
}

extension AnimalsCache {
    func lookup(prefix: String) -> [String] {
        animals.filter { $0.hasCaseAndDiacriticInsensitivePrefix(prefix) }.removingDuplicates()
    }
}

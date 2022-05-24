//
//  AniamalsFile.swift
//  AutocompleteAnimals
//
//  Created by Jignesh Rajodiya on 2022-05-24.
//

import Foundation

struct AniamalsFile: AnimalsSource {

    let location: URL

    init(location: URL) {
        self.location = location
    }

    /// Looks up for `animals` file in the main bundle
    init?() {
        guard let location = Bundle.main.url(forResource: "animals", withExtension: nil) else {
            assertionFailure("animals file is not in the main bundle")
            return nil
        }

        self.init(location: location)
    }

    func loadAnimals() -> [String] {
        do {
            let data = try Data(contentsOf: location)
            let string = String(data: data, encoding: .utf8)
            return string?.components(separatedBy: .newlines) ?? []
        }
        catch {
            return []
        }
    }
}

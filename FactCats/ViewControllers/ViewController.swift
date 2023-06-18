//
//  ViewController.swift
//  FactCats
//
//  Created by Роман on 19.06.2023.
//

import UIKit

final class ViewController: UIViewController {

   private let link: URL = URL(string: "https://catfact.ninja/fact")!
    
// MARK: - IBAction
    @IBAction func getFact() {
        fetchFact()
    }

}

// MARK: - Networking
extension ViewController {
    private func fetchFact() {
        URLSession.shared.dataTask(with: link) {  data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let fact = try decoder.decode(FactCat.self, from: data)
                print(fact)
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
}

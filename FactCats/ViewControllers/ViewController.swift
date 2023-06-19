//
//  ViewController.swift
//  FactCats
//
//  Created by Роман on 19.06.2023.
//

import UIKit

enum Link {
    case factUrl
    case pictureUrl
    var url: URL{
        switch self{
        case .factUrl:
            return URL(string: "https://catfact.ninja/fact")!
        case .pictureUrl:
            return URL(string: "https://cataas.com/cat")!
        }
    }
}

final class ViewController: UIViewController {
    @IBOutlet var imageCat: UIImageView!
    
    
// MARK: - IBAction
    @IBAction func getFact() {
        fetchFact()
        fetchImage()
    }

}

// MARK: - Networking
extension ViewController {
    private func fetchFact() {
        URLSession.shared.dataTask(with: Link.factUrl.url) {  data, _, error in
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
    private func fetchImage() {
        URLSession.shared.dataTask(with: Link.pictureUrl.url) { data, response, error in
            guard let data else {
                print(error?.localizedDescription ?? "No errpr description")
                return
            }
            DispatchQueue.main.async {
                self.imageCat.image = UIImage(data: data)
            }
        }.resume()
    }
}

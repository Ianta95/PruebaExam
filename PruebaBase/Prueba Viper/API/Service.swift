//
//  Service.swift
//  Prueba Viper
//
//  Created by GSSQ6LXMACD01EX on 22/04/22.
//

import Foundation
import UIKit
import FirebaseDatabase

struct Service {
    
    static func fetchServiceOnline() {
        let url = URL(string: SERVICE_URL)
                URLSession.shared.dataTask(with: url!) { data, response, error in
                    if let _ = error {
                        print("Error")
                    }
                    
                    if let data = data,
                       let httpResponse = response as? HTTPURLResponse,
                       httpResponse.statusCode == 200 {
                        let dataModel = try! JSONDecoder().decode([WelcomeElement].self, from: data)
                        print(dataModel)
                        //let pokemonDataModel = try! JSONDecoder().decode(PokemonResponseDataModel.self, from: data)
                        //print("Pokemons \(pokemonDataModel)")
                    }
                }.resume()
    }
    
    static func fetchBackground(completion: @escaping(UIColor) -> ()){
        BACKGROUND.observe(.value) { datasnapshot in
            guard let value = datasnapshot.value as? NSDictionary else { return }
            let red = value[REDVALUE] as? String ?? ""
            let blue = value[BLUEVALUE] as? String ?? ""
            let green = value[GREENVALUE] as? String ?? ""
            print()
         }
    }
    
    
    
}

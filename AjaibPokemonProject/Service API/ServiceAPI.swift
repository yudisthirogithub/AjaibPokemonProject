//
//  ServiceAPI.swift
//  AjaibPokemonProject
//
//  Created by Yudis Huang on 19/10/21.
//

import Foundation

class ServiceAPI {
    static let shared = ServiceAPI()
    
//    func getResults(pokemonName: String, completed: @escaping (Result<ResultsResponse, ErrorMessages>) -> Void){
//
//        let urlString = "https://api.pokemontcg.io/v2/cards?q=name:\(pokemonName)"
//        guard let url = URL(string: urlString) else {return}
//
//        let task = URLSession.shared.dataTask(with: url){(data, response, error) in
//            if let _ = error {
//                completed(.failure(.invalidData))
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { completed(.failure(.invalidResponse))
//                return
//            }
//
//            guard let data = data else {completed(.failure(.invalidData))
//                return
//            }
//
//            do {
//                let deconder = JSONDecoder()
//
//                let results = try deconder.decode(ResultsResponse.self, from: data)
//                completed(.success(results))
//            } catch {
//                completed(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
    
    func getResults(completed: @escaping (Result<ResultsResponse, ErrorMessages>) -> Void){

        let urlString = "https://api.pokemontcg.io/v2/cards?)"
        guard let url = URL(string: urlString) else {return}

        let task = URLSession.shared.dataTask(with: url){(data, response, error) in
            if let _ = error {
                completed(.failure(.invalidData))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {completed(.failure(.invalidData))
                return
            }

            do {
                let deconder = JSONDecoder()

                let results = try deconder.decode(ResultsResponse.self, from: data)
                completed(.success(results))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
}

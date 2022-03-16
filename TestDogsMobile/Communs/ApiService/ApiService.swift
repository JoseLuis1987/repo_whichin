//
//  ApiService.swift
//  TestDogsMobile
//
//  Created by Jose Luis on 16/03/22.
//

import Foundation
class APIService :  NSObject {
    
    func getAllDogs(completion : @escaping ((Result<[Dog], ErrorResult>) -> Void)) {
        guard let url = URL(string: Constants.urlWS) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print ("error: \(error!)")
                DispatchQueue.main.async {
                    completion(.failure(ErrorResult.network(string: Constants.msjGenericoMasTarde)))
                }
                return
            }
            guard let data = data else {
                print("No data")
                DispatchQueue.main.async {
                    completion(.failure(ErrorResult.network(string: Constants.msjGenericoMasTarde)))
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                if let strDatos = String(data: data, encoding: String.Encoding.utf8){
                    let jsonData = strDatos.data(using: .utf8)!
                    let allDogs = try decoder.decode([Dog].self, from: jsonData)
                    print(allDogs)
                    DispatchQueue.main.async {
                        completion(.success(allDogs))
                    }
                }
                
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.custom(string: Constants.msjGenericoMappeoDatos)))
                }
            }
        }
        task.resume()
    }
}

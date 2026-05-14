//import Foundation
//
//protocol GenderServiceProtocol {
//    func fetchGender(name: String, completion: @escaping (Result<Person, Error>) -> Void)
//}
//
//final class GenserService: GenderServiceProtocol {
//    
//    func fetchGender(name: String, completion: @escaping (Result<Person, Error>) -> Void){
//        guard let url = URL(string: "https://api.genderize.io/?name=\(name)") else {return}
//        
//        URLSession.shared.dataTask(with: url) {data, _, error in
//            if let error {
//                completion(.failure(error))
//                return
//            }
//            
//            guard let data else {
//                completion(.failure(NetworkError.nodata))
//                return
//            }
//            
//            do {
//                let person = try JSONDecoder().decode(Person.self, from: data)
//                completion(.success(person))
//            } catch {
//                completion(.failure(error))
//            }
//        }.resume()
//    }
//}


import Foundation

protocol GenderServiceProtocol {
    func fetchGender (name: String, comletion: @escaping (Result <Person,Error>) -> Void)
}

final class GenderService: GenderServiceProtocol {
    func fetchGender(name: String, comletion: @escaping (Result<Person, any Error>) -> Void) {
        guard let url = URL(string: "https://api.genderize.io/?name=\(name)") else { return }
        
        URLSession.shared.dataTask(with: url) {data, _, error in
            if let error {
                comletion(.failure(error))
                return
            }
            guard let data else {
                comletion(.failure(NetworkError.noData))
                return
            }
            do {
                let person = try JSONDecoder().decode(Person.self, from: data)
                comletion(.success(person))
            } catch {
                comletion(.failure(error))
                return
            }
        }.resume()
    }
}

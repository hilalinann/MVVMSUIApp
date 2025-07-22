//
//  Webservice.swift
//  MVVMSUIApp
//
//  Created by Hilal İnan on 21.07.2025.
//

import Foundation
import Combine

protocol HackerNewsProtocol {
    func fetchNews() -> AnyPublisher<[HackerNews], DownloaderError>
}

class HackerNewsService: HackerNewsProtocol {
    
    func fetchNews() -> AnyPublisher<[HackerNews], DownloaderError> {
        
        let url = NetworkingRouter.bestStories.url
        
        return Future<[HackerNews], DownloaderError> { promise in
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                if let _ = error {
                    return promise(.failure(.networkError))
                }
                
                guard let data = data else {
                    return promise(.failure(.noData))
                }
                
                do {
                    let newsList = try JSONDecoder().decode([HackerNews].self, from: data)
                    promise(.success(newsList))
                } catch {
                    promise(.failure(.dataParseError))
                }
                
            }.resume()
        }
        .eraseToAnyPublisher()
    }
}


enum DownloaderError: Error {
    case invalidURL
    case networkError
    case noData
    case dataParseError
}

extension DownloaderError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL oluşturulamadı."
        case .networkError:
            return "Ağ bağlantı hatası oluştu."
        case .noData:
            return "Sunucudan veri alınamadı."
        case .dataParseError:
            return "Veri işlenemedi (JSON decode hatası)."
        }
    }
}

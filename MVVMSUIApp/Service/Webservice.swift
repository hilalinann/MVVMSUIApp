//
//  Webservice.swift
//  MVVMSUIApp
//
//  Created by Hilal İnan on 21.07.2025.
//

import Foundation
import Combine

protocol APIProtocol {
    func fetchNews() -> AnyPublisher<[HackerNews], DownloaderError>
}

class APIService: APIProtocol {
    
    func fetchNews() -> AnyPublisher<[HackerNews], DownloaderError> {
        let url = NetworkingRouter.bestStories.url
        // 1. Önce ID listesini çek
        return URLSession.shared.dataTaskPublisher(for: url)
            .mapError { _ in DownloaderError.invalidURL }
            .tryMap { data, _ in
                try JSONDecoder().decode([Int].self, from: data)
            }
            .mapError { _ in DownloaderError.dataParseError }
            // 2. İlk 20 ID için detayları çek
            .flatMap { ids -> AnyPublisher<[HackerNews], DownloaderError> in
                let first20 = Array(ids.prefix(20))
                let publishers = first20.map { id in
                    URLSession.shared.dataTaskPublisher(for: NetworkingRouter.item(id).url)
                        .mapError { _ in DownloaderError.invalidURL }
                        .tryMap { data, _ in
                            try JSONDecoder().decode(HackerNews.self, from: data)
                        }
                        .mapError { _ in DownloaderError.dataParseError }
                        .eraseToAnyPublisher()
                }
                return Publishers.MergeMany(publishers)
                    .collect()
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}


enum DownloaderError: Error {
    case invalidURL
    case noData
    case dataParseError
}

extension DownloaderError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL oluşturulamadı."
        case .noData:
            return "Sunucudan veri alınamadı."
        case .dataParseError:
            return "Veri işlenemedi (JSON decode hatası)."
        }
    }
}

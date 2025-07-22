//
//  HNViewModel.swift
//  MVVMSUIApp
//
//  Created by Hilal İnan on 22.07.2025.
//

import Foundation
import Combine

class HNListViewModel: ObservableObject {
    @Published var newsList: [HackerNews] = []
    struct ErrorMessage: Identifiable {
        var id: String { message }
        let message: String
    }

    @Published var errorMessage: ErrorMessage?


    private var cancellables = Set<AnyCancellable>()
    
    func fetchBestStories() {
        let url = NetworkingRouter.bestStories.url
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response -> [Int] in
                return try JSONDecoder().decode([Int].self, from: data)
            }
            .flatMap { ids -> AnyPublisher<[HackerNews], Error> in
                let first20 = Array(ids.prefix(20))
                let publishers = first20.map { self.fetchStory(for: $0) }
                return Publishers.MergeMany(publishers)
                    .collect()
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.errorMessage = ErrorMessage(message: "Bir hata oluştu")
                }
            }, receiveValue: { stories in
                self.newsList = stories.sorted(by: { $0.score > $1.score }) // opsiyonel: skora göre sırala
            })
            .store(in: &cancellables)
    }
    
    private func fetchStory(for id: Int) -> AnyPublisher<HackerNews, Error> {
        let itemURL = NetworkingRouter.item(id).url
        
        return URLSession.shared.dataTaskPublisher(for: itemURL)
            .tryMap { data, _ in
                return try JSONDecoder().decode(HackerNews.self, from: data)
            }
            .eraseToAnyPublisher()
    }
}

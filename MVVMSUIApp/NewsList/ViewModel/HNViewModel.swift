//
//  HNViewModel.swift
//  MVVMSUIApp
//
//  Created by Hilal İnan on 22.07.2025.
//

import Foundation
import Combine

class HNViewModel: ObservableObject {
    
    @Published var newsList: [HackerNews] = []
    
    struct ErrorMessage: Identifiable {
        var id: String { message }
        let message: String
    }

    @Published var errorMessage: ErrorMessage?


    private var cancellables = Set<AnyCancellable>()
    private let service: APIProtocol = APIService()
    
    func fetchBestStories() {
        service.fetchNews()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.errorMessage = ErrorMessage(message: error.localizedDescription)
                }
            }, receiveValue: { news in
                self.newsList = news.sorted(by: { $0.score > $1.score })
            })
            .store(in: &cancellables)
    }
}

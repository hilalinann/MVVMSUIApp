//
//  HNViewModel.swift
//  MVVMSUIApp
//
//  Created by Hilal İnan on 22.07.2025.
//

import Foundation
import Combine

class HackerNewsViewModel: ObservableObject {
    
    @Published var newsList: [HackerNews] = []
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()
    private let service: HackerNewsProtocol
    
    init(service: HackerNewsProtocol = HackerNewsService()) {
        self.service = service
    }
    
    func fetchNews() {
        service.fetchNews()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { news in
                self.newsList = news
            }
            .store(in: &cancellables)
    }
}

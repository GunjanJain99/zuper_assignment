

import Foundation
import Combine

class ServiceListViewModel: ObservableObject {
    @Published var allServices: [Service] = []
    @Published var filteredServices: [Service] = []
    @Published var searchText: String = ""

    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchServices()
        setupBindings()
    }

    func fetchServices() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.allServices = SampleData.generateServices(count: 20)
            self.filteredServices = self.allServices
        }
    }

    private func setupBindings() {
        $searchText
            .receive(on: DispatchQueue.main)
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] searchTerm in
                guard let self = self else { return }

                if searchTerm.isEmpty {
                    self.filteredServices = self.allServices
                } else {
                    self.filteredServices = self.allServices.filter {
                        $0.title.localizedCaseInsensitiveContains(searchTerm) ||
                        $0.customerName.localizedCaseInsensitiveContains(searchTerm) ||
                        $0.description.localizedCaseInsensitiveContains(searchTerm)
                    }
                }
            }
            .store(in: &cancellables)
    }
}

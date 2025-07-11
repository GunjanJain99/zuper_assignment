

import SwiftUI

struct ServiceListView: View {
    @StateObject private var viewModel = ServiceListViewModel()
    @State private var selectedService: Service? = nil

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.filteredServices) { service in
                    Button {
                        selectedService = service
                    } label: {
                        ServiceRowView(service: service)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Services")
            .searchable(text: $viewModel.searchText, placement: .automatic)
            .refreshable {
                viewModel.fetchServices()
            }
            
            .navigationDestination(item: $selectedService) { service in
                ServiceDetailView(service: service)
            }
        }
    }
}

#Preview {
    ServiceListView()
}

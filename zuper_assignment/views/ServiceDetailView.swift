

import SwiftUI
import MapKit

struct ServiceDetailView: View {
    let service: Service
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 13.0827, longitude: 80.2707),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                Map(coordinateRegion: $region, annotationItems: [service]) { _ in
                    MapMarker(coordinate: region.center, tint: .black)
                }
                .frame(height: 200)
                .cornerRadius(12)
                
                HStack {
                    Text(service.title)
                        .font(.title3)
                        .bold()
                    Spacer()
                    Text(service.status.rawValue)
                        .font(.caption)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(10)
                }
                
                DetailRow(icon: "person", title: "Customer", value: service.customerName)
                DetailRow(icon: "doc.text", title: "Description", value: service.description)
                DetailRow(icon: "clock", title: "Scheduled Time", value: DateFormatterHelper.formattedDate(from: service.scheduledDate))
                DetailRow(icon: "mappin.and.ellipse", title: "Location", value: service.location)
                DetailRow(icon: "text.bubble", title: "Service Notes", value: service.serviceNotes)
            }
            .padding()
        }
        .navigationTitle("Service Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .padding(.top, 2)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                    .bold()
                Text(value)
                    .font(.callout)
                    .foregroundColor(.primary).opacity(0.7)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ServiceDetailView(service: SampleData.generateSingleService())
    }
}



import SwiftUI

struct ServiceRowView: View {
    let service: Service

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(service.title)
                        .font(.headline)

                    HStack(spacing: 4) {
                        Image(systemName: "person")
                            .foregroundColor(.blue)
                            .padding(.top, 2)
                        Text(service.customerName)
                            .font(.subheadline)
                            .foregroundColor(.primary).opacity(0.7)
                    }

                    HStack(spacing: 4) {
                        Image(systemName: "doc.text")
                            .foregroundColor(.blue)
                            .padding(.top, 2)
                        Text(service.description)
                            .font(.subheadline)
                            .foregroundColor(.primary).opacity(0.7)
                            .lineLimit(2)
                    }
                }

                Spacer()
                
                Circle()
                    .fill(colorForStatus(service.status))
                    .frame(width: 10, height: 10)
            }

            HStack {
                Text(service.status.rawValue)
                    .font(.caption)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(colorForStatus(service.status).opacity(0.2))
                    .foregroundColor(colorForStatus(service.status))
                    .cornerRadius(10)

                Spacer()

                Text(DateFormatterHelper.formattedDate(from: service.scheduledDate))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.gray.opacity(0.3)))
        .padding(.vertical, 4)
    }

    func colorForStatus(_ status: ServiceStatus) -> Color {
        switch status {
        case .active: return .green
        case .scheduled: return .green.opacity(0.8)
        case .completed: return .blue
        case .inProgress: return .orange
        case .urgent: return .red
        }
    }
}
#Preview {
    ServiceRowView(service: SampleData.generateSingleService())
        .previewLayout(.sizeThatFits)
        .padding()
}

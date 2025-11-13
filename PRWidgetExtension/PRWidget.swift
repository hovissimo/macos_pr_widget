import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> PREntry {
        PREntry(date: Date(), pullRequests: [])
    }

    func getSnapshot(in context: Context, completion: @escaping (PREntry) -> ()) {
        let entry = PREntry(date: Date(), pullRequests: [])
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            do {
                let prs = try await GitHubAPIService.shared.fetchPullRequests()
                let entry = PREntry(date: Date(), pullRequests: prs)
                let nextUpdate = Calendar.current.date(byAdding: .minute, value: 5, to: Date())!
                let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
                completion(timeline)
            } catch {
                print("Error fetching PRs: \(error)")
                let entry = PREntry(date: Date(), pullRequests: [])
                let nextUpdate = Calendar.current.date(byAdding: .minute, value: 5, to: Date())!
                let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
                completion(timeline)
            }
        }
    }
}

struct PREntry: TimelineEntry {
    let date: Date
    let pullRequests: [PullRequest]
}

struct PRWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("GitHub PRs")
                .font(.headline)
                .foregroundColor(.primary)
            
            if entry.pullRequests.isEmpty {
                Text("No open PRs")
                    .font(.caption)
                    .foregroundColor(.secondary)
            } else {
                ForEach(entry.pullRequests.prefix(3)) { pr in
                    PRRowView(pr: pr)
                }
            }
        }
        .padding()
    }
}

struct PRRowView: View {
    let pr: PullRequest
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("#\(pr.number)")
                    .font(.caption)
                    .fontWeight(.bold)
                
                Text(pr.title)
                    .font(.caption)
                    .lineLimit(1)
                
                Spacer()
                
                // Overall status indicator
                Circle()
                    .fill(pr.overallStatusColor)
                    .frame(width: 8, height: 8)
            }
            
            // Reviewers
            if !pr.reviewers.isEmpty {
                HStack(spacing: 4) {
                    Image(systemName: "person.2")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    
                    ForEach(pr.reviewers) { reviewer in
                        HStack(spacing: 2) {
                            Text(reviewer.username)
                                .font(.caption2)
                            Circle()
                                .fill(reviewer.statusColor)
                                .frame(width: 6, height: 6)
                        }
                    }
                }
            }
            
            // CI/CD Checks
            if !pr.checks.isEmpty {
                HStack(spacing: 4) {
                    Image(systemName: "checkmark.circle")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    
                    Text("\(pr.passedChecksCount)/\(pr.checks.count)")
                        .font(.caption2)
                        .foregroundColor(pr.allChecksPassed ? .green : .red)
                    
                    if !pr.allChecksPassed {
                        Text("(\(pr.failedCheckNames))")
                            .font(.caption2)
                            .foregroundColor(.red)
                            .lineLimit(1)
                    }
                }
            }
            
            // Branch status
            if pr.isOutOfDate {
                HStack(spacing: 4) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.caption2)
                        .foregroundColor(.orange)
                    Text("Out of date")
                        .font(.caption2)
                        .foregroundColor(.orange)
                }
            }
        }
        .padding(.vertical, 4)
    }
}

@main
struct PRWidget: Widget {
    let kind: String = "PRWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            PRWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("GitHub PR Status")
        .description("Track your open GitHub pull requests")
        .supportedFamilies([.systemMedium, .systemLarge])
    }
}

#Preview(as: .systemMedium) {
    PRWidget()
} timeline: {
    PREntry(date: .now, pullRequests: [
        PullRequest(
            number: 123,
            title: "Add new feature",
            reviewers: [
                Reviewer(username: "alice", status: .approved),
                Reviewer(username: "bob", status: .changesRequested)
            ],
            checks: [
                Check(name: "Build", status: .passed),
                Check(name: "Tests", status: .failed),
                Check(name: "Lint", status: .passed)
            ],
            isOutOfDate: true
        )
    ])
}

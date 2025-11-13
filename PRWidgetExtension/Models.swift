import SwiftUI

struct PullRequest: Identifiable, Codable {
    let id: String
    let number: Int
    let title: String
    let reviewers: [Reviewer]
    let checks: [Check]
    let isOutOfDate: Bool
    
    var allChecksPassed: Bool {
        checks.allSatisfy { $0.status == .passed }
    }
    
    var passedChecksCount: Int {
        checks.filter { $0.status == .passed }.count
    }
    
    var failedCheckNames: String {
        checks.filter { $0.status == .failed }
            .map { $0.name }
            .joined(separator: ", ")
    }
    
    var overallStatusColor: Color {
        if !allChecksPassed {
            return .red
        } else if reviewers.contains(where: { $0.status == .changesRequested }) {
            return .orange
        } else if reviewers.allSatisfy({ $0.status == .approved }) && !isOutOfDate {
            return .green
        } else {
            return .yellow
        }
    }
    
    init(number: Int, title: String, reviewers: [Reviewer], checks: [Check], isOutOfDate: Bool) {
        self.id = "\(number)"
        self.number = number
        self.title = title
        self.reviewers = reviewers
        self.checks = checks
        self.isOutOfDate = isOutOfDate
    }
}

struct Reviewer: Identifiable, Codable {
    let id: String
    let username: String
    let status: ReviewStatus
    
    var statusColor: Color {
        switch status {
        case .approved:
            return .green
        case .changesRequested:
            return .red
        case .pending:
            return .yellow
        case .commented:
            return .blue
        }
    }
    
    init(username: String, status: ReviewStatus) {
        self.id = username
        self.username = username
        self.status = status
    }
}

enum ReviewStatus: String, Codable {
    case approved = "APPROVED"
    case changesRequested = "CHANGES_REQUESTED"
    case pending = "PENDING"
    case commented = "COMMENTED"
}

struct Check: Identifiable, Codable {
    let id: String
    let name: String
    let status: CheckStatus
    
    init(name: String, status: CheckStatus) {
        self.id = name
        self.name = name
        self.status = status
    }
}

enum CheckStatus: String, Codable {
    case passed = "SUCCESS"
    case failed = "FAILURE"
    case pending = "PENDING"
    case skipped = "SKIPPED"
}

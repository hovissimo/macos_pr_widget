import Foundation

class GitHubAPIService {
    static let shared = GitHubAPIService()
    
    private let baseURL = "https://api.github.com"
    private var token: String {
        // Read from UserDefaults or environment
        UserDefaults.standard.string(forKey: "GitHubToken") ?? ""
    }
    
    private var owner: String {
        UserDefaults.standard.string(forKey: "GitHubOwner") ?? ""
    }
    
    private var repo: String {
        UserDefaults.standard.string(forKey: "GitHubRepo") ?? ""
    }
    
    private init() {}
    
    func fetchPullRequests() async throws -> [PullRequest] {
        guard !token.isEmpty, !owner.isEmpty, !repo.isEmpty else {
            print("GitHub credentials not configured")
            return []
        }
        
        let url = URL(string: "\(baseURL)/repos/\(owner)/\(repo)/pulls?state=open")!
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        let pulls = try JSONDecoder().decode([GitHubPullRequest].self, from: data)
        
        var result: [PullRequest] = []
        
        for pull in pulls {
            // Fetch reviews
            let reviews = try await fetchReviews(prNumber: pull.number)
            
            // Fetch checks
            let checks = try await fetchChecks(ref: pull.head.sha)
            
            // Check if branch is out of date
            let isOutOfDate = try await checkIfOutOfDate(prNumber: pull.number)
            
            let pr = PullRequest(
                number: pull.number,
                title: pull.title,
                reviewers: reviews,
                checks: checks,
                isOutOfDate: isOutOfDate
            )
            result.append(pr)
        }
        
        return result
    }
    
    private func fetchReviews(prNumber: Int) async throws -> [Reviewer] {
        let url = URL(string: "\(baseURL)/repos/\(owner)/\(repo)/pulls/\(prNumber)/reviews")!
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            return []
        }
        
        let reviews = try JSONDecoder().decode([GitHubReview].self, from: data)
        
        // Group by user and take the latest review per user
        var reviewerDict: [String: Reviewer] = [:]
        for review in reviews {
            if let status = ReviewStatus(rawValue: review.state) {
                reviewerDict[review.user.login] = Reviewer(username: review.user.login, status: status)
            }
        }
        
        return Array(reviewerDict.values)
    }
    
    private func fetchChecks(ref: String) async throws -> [Check] {
        let url = URL(string: "\(baseURL)/repos/\(owner)/\(repo)/commits/\(ref)/check-runs")!
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            return []
        }
        
        let checkRuns = try JSONDecoder().decode(GitHubCheckRuns.self, from: data)
        
        return checkRuns.check_runs.map { checkRun in
            let status: CheckStatus
            if checkRun.conclusion == "success" {
                status = .passed
            } else if checkRun.conclusion == "failure" {
                status = .failed
            } else if checkRun.conclusion == "skipped" {
                status = .skipped
            } else {
                status = .pending
            }
            
            return Check(name: checkRun.name, status: status)
        }
    }
    
    private func checkIfOutOfDate(prNumber: Int) async throws -> Bool {
        let url = URL(string: "\(baseURL)/repos/\(owner)/\(repo)/pulls/\(prNumber)")!
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            return false
        }
        
        let pr = try JSONDecoder().decode(GitHubPullRequest.self, from: data)
        
        // Fetch the base branch to compare commits
        let baseURL = URL(string: "\(baseURL)/repos/\(owner)/\(repo)/compare/\(pr.head.sha)...\(pr.base.ref)")!
        var compareRequest = URLRequest(url: baseURL)
        compareRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        compareRequest.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        
        let (compareData, compareResponse) = try await URLSession.shared.data(for: compareRequest)
        
        guard let compareHttpResponse = compareResponse as? HTTPURLResponse,
              compareHttpResponse.statusCode == 200 else {
            return false
        }
        
        let comparison = try JSONDecoder().decode(GitHubComparison.self, from: compareData)
        
        // If ahead_by > 0, the base branch has commits that the head doesn't have
        return comparison.behind_by > 0
    }
}

enum APIError: Error {
    case invalidResponse
    case invalidData
}

// GitHub API Response Models
struct GitHubPullRequest: Codable {
    let number: Int
    let title: String
    let head: GitHubRef
    let base: GitHubRef
}

struct GitHubRef: Codable {
    let ref: String
    let sha: String
}

struct GitHubReview: Codable {
    let user: GitHubUser
    let state: String
}

struct GitHubUser: Codable {
    let login: String
}

struct GitHubCheckRuns: Codable {
    let check_runs: [GitHubCheckRun]
}

struct GitHubCheckRun: Codable {
    let name: String
    let conclusion: String?
    let status: String
}

struct GitHubComparison: Codable {
    let ahead_by: Int
    let behind_by: Int
}

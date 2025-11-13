import SwiftUI

@main
struct PRWidgetApp: App {
    var body: some Scene {
        WindowGroup {
            ConfigurationView()
        }
    }
}

struct ConfigurationView: View {
    @State private var githubToken: String = UserDefaults.standard.string(forKey: "GitHubToken") ?? ""
    @State private var owner: String = UserDefaults.standard.string(forKey: "GitHubOwner") ?? ""
    @State private var repo: String = UserDefaults.standard.string(forKey: "GitHubRepo") ?? ""
    @State private var showingSaved = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("GitHub PR Widget Configuration")
                .font(.title)
                .padding()
            
            Form {
                Section(header: Text("GitHub Settings")) {
                    TextField("GitHub Token", text: $githubToken)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .help("Personal Access Token with repo scope")
                    
                    TextField("Repository Owner", text: $owner)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .help("GitHub username or organization")
                    
                    TextField("Repository Name", text: $repo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .help("Name of the repository")
                }
                
                Section {
                    Text("To get a GitHub Personal Access Token:")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("1. Go to GitHub Settings > Developer settings > Personal access tokens > Tokens (classic)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("2. Generate new token with 'repo' scope")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("3. Copy the token and paste it above")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            
            Button("Save Configuration") {
                saveConfiguration()
            }
            .buttonStyle(.borderedProminent)
            
            if showingSaved {
                Text("Configuration saved! ✓")
                    .foregroundColor(.green)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showingSaved = false
                        }
                    }
            }
            
            Spacer()
            
            Text("After saving, add the widget to your desktop from the Widget Center")
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
        }
        .frame(minWidth: 500, minHeight: 400)
    }
    
    private func saveConfiguration() {
        UserDefaults.standard.set(githubToken, forKey: "GitHubToken")
        UserDefaults.standard.set(owner, forKey: "GitHubOwner")
        UserDefaults.standard.set(repo, forKey: "GitHubRepo")
        showingSaved = true
    }
}

#Preview {
    ConfigurationView()
}

# macOS PR Widget

A macOS desktop widget that tracks the status of your open GitHub pull requests.

## Features

- **Reviewer Status**: Shows all reviewers and their review status (Approved ✓, Changes Requested ✗, Pending ⏳, Commented 💬)
- **CI/CD Checks**: Displays whether all GitHub Actions checks are passing
- **Failed Checks**: Shows which specific checks have failed
- **Branch Status**: Indicates if the PR branch is out of date with the base branch
- **Visual Indicators**: Color-coded status indicators for quick scanning
- **Auto-refresh**: Updates every 5 minutes automatically

## Requirements

- macOS 14.0 or later
- Xcode 15.0 or later (for building)
- GitHub Personal Access Token with `repo` scope

## Installation

### Building from Source

**New to Xcode?** Don't worry! Follow these beginner-friendly instructions:

#### Step 1: Install Xcode (if you don't have it)

1. Open the **App Store** on your Mac
2. Search for **"Xcode"**
3. Click **Get** or **Install** (it's free, but it's a large download ~10GB)
4. Wait for installation to complete (this may take 15-30 minutes)
5. Open **Xcode** once to accept the license agreement

#### Step 2: Download the Widget Code

You have two options:

**Option A: Download ZIP (Easiest for beginners)**
1. Go to https://github.com/hovissimo/macos_pr_widget
2. Click the green **Code** button
3. Click **Download ZIP**
4. Find the downloaded file in your Downloads folder and double-click to unzip it
5. Move the `macos_pr_widget-main` folder to a location you'll remember (like your Desktop or Documents)

**Option B: Using Terminal (if you're comfortable with command line)**
1. Open **Terminal** (find it in Applications > Utilities)
2. Type or paste these commands:
   ```bash
   git clone https://github.com/hovissimo/macos_pr_widget.git
   cd macos_pr_widget
   ```

#### Step 3: Open the Project in Xcode

1. Navigate to the folder where you downloaded/cloned the code
2. Look for a file named **PRWidget.xcodeproj** (it has a blue Xcode icon)
3. **Double-click** on `PRWidget.xcodeproj` to open it in Xcode

   *Alternative: You can also drag the file onto the Xcode icon in your Dock*

#### Step 4: Build and Run the App

**First-time Xcode users:** Here's what you'll see and do:

1. **Wait for indexing**: Xcode will analyze the project (you'll see "Indexing..." at the top). Wait for this to complete.

2. **Select the correct scheme** (VERY IMPORTANT!):
   - Look at the top-left of the Xcode window
   - You'll see a dropdown that might say "PRWidget" or another name
   - **Make sure it says "PRWidget"** (NOT "PRWidgetExtension")
   - Click it if you need to change it and select **"PRWidget"**
   - Next to it, select **"My Mac"** as the destination

3. **Trust the developer** (you!):
   - Xcode might show a warning about code signing
   - Click on the **PRWidget** project name in the left sidebar (the blue icon at the very top)
   - Click on **"Signing & Capabilities"** tab in the main area
   - Check the box for **"Automatically manage signing"**
   - Select your Apple ID team from the dropdown (or add your Apple ID if prompted)

4. **Build and run**:
   - Click the **Play button (▶️)** in the top-left corner, OR
   - Press **⌘R** on your keyboard (Command + R)
   - Xcode will compile the code (this may take a minute the first time)
   - **The configuration app window will appear** titled "GitHub PR Widget Configuration"

**⚠️ If you see "Choose an app to run your widget" instead of the configuration window:**

You accidentally selected the wrong scheme! This is the #1 most common issue:

1. Click the **Stop button (■)** at the top-left
2. Change the dropdown from "PRWidgetExtension" to **"PRWidget"**  
3. Click **Play (▶️)** again
4. Now you should see the configuration window!

**Why this matters:**
- **PRWidget** scheme = Runs the configuration app (start here!)
- **PRWidgetExtension** scheme = For debugging the widget itself (advanced, use later)

**If you see other errors:**
- Make sure you selected "PRWidget" as the scheme (not PRWidgetExtension)
- Make sure "My Mac" is selected as the destination
- Try clicking **Product** menu > **Clean Build Folder**, then build again

## Configuration

1. **Get a GitHub Personal Access Token**:
   
   GitHub supports two types of tokens. **Fine-grained tokens are recommended** as they offer better security:
   
   **Option A: Fine-grained Personal Access Token (Recommended)**
   - Go to [GitHub Settings > Personal access tokens > Fine-grained tokens](https://github.com/settings/tokens?type=beta)
   - Click "Generate new token"
   - Give it a descriptive name (e.g., "PR Widget")
   - Set repository access and select your repository
   - Grant these permissions:
     - Pull requests: Read-only
     - Metadata: Read-only
     - Checks: Read-only
     - Commit statuses: Read-only
   - Click "Generate token"
   - **Copy the token immediately** (you won't be able to see it again)
   
   **Option B: Classic Personal Access Token**
   - Go to [GitHub Settings > Developer settings > Personal access tokens > Tokens (classic)](https://github.com/settings/tokens)
   - Click "Generate new token (classic)"
   - Give it a descriptive name (e.g., "PR Widget")
   - Select the `repo` scope (full control of private repositories)
   - Click "Generate token"
   - **Copy the token immediately** (you won't be able to see it again)

2. **Configure the Widget**:
   - Run the PRWidget app
   - Enter your GitHub Personal Access Token
   - Enter the repository owner (username or organization)
   - Enter the repository name
   - Click "Save Configuration"

3. **Add the Widget to Your Desktop**:
   - Right-click on your desktop or notification center
   - Select "Edit Widgets"
   - Search for "GitHub PR Status"
   - Drag the widget to your desired location
   - Choose your preferred size (Medium or Large)

## Usage

Once configured, the widget will:
- Automatically fetch your open pull requests every 5 minutes
- Display up to 3 PRs in medium size (more in large size)
- Show color-coded status indicators:
  - 🟢 Green: All checks passed, all reviews approved, branch up to date
  - 🟡 Yellow: Pending reviews or checks
  - 🟠 Orange: Changes requested or branch out of date
  - 🔴 Red: Failed checks

## Widget Information Display

For each PR, the widget shows:

1. **PR Number and Title**: `#123 Add new feature`
2. **Reviewers**: Username with status indicator
   - 🟢 Approved
   - 🔴 Changes Requested
   - 🟡 Pending
   - 🔵 Commented
3. **Checks**: Pass/Fail count and failed check names
   - `✓ 2/3 (Tests)` means 2 of 3 checks passed, Tests failed
4. **Branch Status**: Warning if branch is out of date
   - `⚠️ Out of date` means the base branch has new commits

## Privacy & Security

- Your GitHub token is stored locally in macOS UserDefaults
- All API calls are made directly to GitHub's API
- No data is sent to third-party services
- The widget uses macOS App Sandbox for security

## Troubleshooting

### Widget shows "No open PRs"
- Verify your repository owner and name are correct
- Check that you have open pull requests in the repository
- Ensure your GitHub token has the correct permissions

### Widget not updating
- Check your internet connection
- Verify your GitHub token is still valid
- Try force-quitting and restarting the widget

### Configuration not saving
- Make sure the app has permission to write to UserDefaults
- Check Console.app for any error messages

## Development

### Project Structure

```
PRWidget/
├── PRWidget/                    # Main configuration app
│   ├── PRWidgetApp.swift       # App entry point and configuration UI
│   └── PRWidget.entitlements   # App permissions
├── PRWidgetExtension/          # Widget extension
│   ├── PRWidget.swift          # Widget entry point and UI
│   ├── Models.swift            # Data models
│   ├── GitHubAPIService.swift  # GitHub API integration
│   └── Info.plist              # Extension configuration
└── PRWidget.xcodeproj/         # Xcode project
```

### API Endpoints Used

The widget uses the following GitHub API endpoints:
- `GET /repos/{owner}/{repo}/pulls` - List open pull requests
- `GET /repos/{owner}/{repo}/pulls/{number}/reviews` - Get PR reviews
- `GET /repos/{owner}/{repo}/commits/{ref}/check-runs` - Get check runs
- `GET /repos/{owner}/{repo}/compare/{base}...{head}` - Compare branches

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open source and available under the MIT License.

## Acknowledgments

Built with SwiftUI and WidgetKit for macOS.
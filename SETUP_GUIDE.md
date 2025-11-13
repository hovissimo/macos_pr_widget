# Quick Setup Guide

This guide will help you get the GitHub PR Status Widget running on your Mac in just a few minutes.

## Prerequisites

- macOS 14.0 (Sonoma) or later
- Xcode 15.0 or later
- A GitHub account with access to the repository you want to monitor

## Step 1: Clone and Build

```bash
# Clone the repository
git clone https://github.com/hovissimo/macos_pr_widget.git
cd macos_pr_widget

# Open in Xcode
open PRWidget.xcodeproj
```

In Xcode:
1. Select the **PRWidget** scheme from the dropdown at the top
2. Click the **Run** button (▶️) or press `⌘R`
3. The configuration app will launch

## Step 2: Get Your GitHub Token

GitHub supports two types of Personal Access Tokens. **Fine-grained tokens** (recommended) are the newer format:

### Option A: Fine-grained Personal Access Token (Recommended)

1. Go to https://github.com/settings/tokens?type=beta
2. Click **"Generate new token"**
3. Give it a name like "PR Widget Access"
4. Set expiration (recommended: 90 days or less)
5. Under **"Repository access"**, select:
   - **"Only select repositories"** and choose your repository, OR
   - **"All repositories"** if you want flexibility
6. Under **"Permissions"**, expand **"Repository permissions"** and set:
   - **Pull requests**: Read-only access
   - **Metadata**: Read-only access (automatically selected)
   - **Checks**: Read-only access
   - **Commit statuses**: Read-only access
7. Click **"Generate token"**
8. **IMPORTANT**: Copy the token immediately - you won't be able to see it again!

### Option B: Classic Personal Access Token

1. Go to https://github.com/settings/tokens
2. Click **"Tokens (classic)"** in the left sidebar
3. Click **"Generate new token"** → **"Generate new token (classic)"**
4. Give it a name like "PR Widget Access"
5. Set expiration (or choose "No expiration" if you prefer)
6. Check the **`repo`** scope checkbox (this gives full repository access)
7. Scroll down and click **"Generate token"**
8. **IMPORTANT**: Copy the token immediately - you won't be able to see it again!

## Step 3: Configure the Widget

In the PRWidget configuration app that opened:

1. **GitHub Token**: Paste the token you just copied
2. **Repository Owner**: Enter the GitHub username or organization
   - Example: For `https://github.com/microsoft/vscode`, enter `microsoft`
3. **Repository Name**: Enter the repository name
   - Example: For `https://github.com/microsoft/vscode`, enter `vscode`
4. Click **"Save Configuration"**
5. You should see a green checkmark saying "Configuration saved! ✓"

## Step 4: Add Widget to Desktop

### Option A: Notification Center (macOS Sonoma)
1. Click the date/time in the menu bar (top right)
2. Scroll to the bottom of Notification Center
3. Click **"Edit Widgets"**
4. Search for **"GitHub PR Status"** or **"PR Widget"**
5. Click the **+** button next to it
6. Drag it to your desired position
7. Click **"Done"**

### Option B: Desktop Widget (macOS Sonoma+)
1. Right-click on your desktop
2. Select **"Edit Widgets"**
3. Search for **"GitHub PR Status"**
4. Drag the widget to your desktop
5. Choose size (Medium or Large)
6. Click **"Done"**

## Step 5: Verify It's Working

The widget should now display your open pull requests! 

- If you see "No open PRs", that's correct if you have no open PRs
- If you see an error, check the Console app for debug messages
- The widget updates automatically every 5 minutes

## Troubleshooting

### "No open PRs" but I know I have PRs

**Check your configuration**:
1. Re-open the PRWidget app
2. Verify the owner and repo name are correct (case-sensitive!)
3. Make sure there are no extra spaces

**Check your token permissions**:
1. Go to https://github.com/settings/tokens
2. Find your token
3. Make sure `repo` scope is enabled

### Widget not updating

**Force a refresh**:
1. Remove the widget
2. Re-add it from the Widget Center
3. Wait up to 5 minutes for the first update

**Check token validity**:
- Your token may have expired
- Generate a new token and update the configuration

### "Could not load widget"

**Rebuild the app**:
1. In Xcode, select **Product** → **Clean Build Folder** (`⌘⇧K`)
2. Build and run again (`⌘R`)

### Can't find the widget in Widget Center

**Make sure you built the widget extension**:
1. In Xcode, select the **PRWidgetExtension** scheme
2. Build it (`⌘B`)
3. Then switch back to **PRWidget** and run (`⌘R`)

## Advanced Configuration

### Monitoring Multiple Repositories

Currently, the widget supports one repository at a time. To monitor multiple repositories:
1. Open the PRWidget app
2. Change the owner/repo to your desired repository
3. Click "Save Configuration"
4. The widget will update on its next refresh cycle (within 5 minutes)

### Changing Update Frequency

By default, the widget updates every 5 minutes. To change this:
1. Open `PRWidgetExtension/PRWidget.swift`
2. Find the line: `.date(byAdding: .minute, value: 5, to: Date())`
3. Change `5` to your desired minutes
4. Rebuild and reinstall the widget

### Token Security

Your GitHub token is stored in macOS `UserDefaults`, which is:
- Specific to your user account
- Not accessible by other apps (sandboxed)
- Stored in `~/Library/Preferences/`

To remove your token:
1. Run this command in Terminal:
```bash
defaults delete com.prwidget.app GitHubToken
defaults delete com.prwidget.app GitHubOwner
defaults delete com.prwidget.app GitHubRepo
```

## Next Steps

- Check out [WIDGET_DESIGN.md](WIDGET_DESIGN.md) to understand the widget layout
- Read the full [README.md](README.md) for detailed information
- Star the repo if you find it useful! ⭐

## Getting Help

If you encounter issues:
1. Check the Console app for error messages (filter by "PRWidget")
2. Open an issue on GitHub with:
   - macOS version
   - Error messages from Console
   - Steps to reproduce
   - Screenshots (without exposing your token!)

## Privacy Note

This widget:
- ✅ Only communicates with GitHub's API
- ✅ Stores credentials locally on your Mac
- ✅ Does not send data to any third-party services
- ✅ Is completely open source - review the code!

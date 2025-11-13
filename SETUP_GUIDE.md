# Quick Setup Guide

This guide will help you get the GitHub PR Status Widget running on your Mac, **even if you've never used Xcode before**!

## What You'll Need

- A Mac computer running macOS 14.0 (Sonoma) or later
- About 30-45 minutes for your first setup
- A GitHub account with access to the repository you want to monitor
- About 10-15 GB of free disk space (for Xcode)

## Complete Step-by-Step Instructions

### Step 1: Install Xcode (First-Time Setup)

**What is Xcode?** It's Apple's free development tool that we need to build the widget.

**Already have Xcode?** Skip to Step 2.

1. **Open the App Store**:
   - Click the Apple menu (🍎) in the top-left corner
   - Click **App Store**
   
2. **Search for Xcode**:
   - Type "Xcode" in the search box
   - Click on the **Xcode** app (it has a blue icon with a hammer)
   
3. **Install Xcode**:
   - Click the **Get** button (or the cloud download icon if you've installed it before)
   - Enter your Apple ID password if prompted
   - Click **Install**
   - ⏱️ **This will take a while** (15-30 minutes) - it's a 10GB+ download
   - You can continue using your Mac while it downloads
   
4. **First-time setup**:
   - Once installed, **open Xcode** from Applications or Launchpad
   - Click **Agree** to accept the license agreement
   - Enter your Mac password if prompted
   - Wait for "Installing components..." to complete
   - You can now close Xcode

### Step 2: Download the Widget Code

**Choose the method that's most comfortable for you:**

#### Method A: Download as ZIP (Recommended for beginners)

1. **Go to the GitHub page**:
   - Open Safari (or your web browser)
   - Go to: `https://github.com/hovissimo/macos_pr_widget`

2. **Download the code**:
   - Look for the green **Code** button (near the top-right of the file list)
   - Click the **Code** button
   - Click **Download ZIP** at the bottom of the menu

3. **Unzip the downloaded file**:
   - Open your **Downloads** folder (press ⌘+Option+L or check your Dock)
   - Find `macos_pr_widget-main.zip` (or similar name)
   - Double-click the ZIP file to unzip it
   - You'll see a new folder called `macos_pr_widget-main`

4. **Move it somewhere permanent**:
   - Drag the `macos_pr_widget-main` folder to your **Documents** folder (or Desktop)
   - You'll need to keep this folder - don't delete it after installation!

#### Method B: Using Terminal (If you're comfortable with command line)

1. Open **Terminal** (Applications > Utilities > Terminal)
2. Navigate to where you want to store the project:
   ```bash
   cd ~/Documents
   ```
3. Download the code:
   ```bash
   git clone https://github.com/hovissimo/macos_pr_widget.git
   cd macos_pr_widget
   ```

### Step 3: Open the Project in Xcode

1. **Navigate to your downloaded folder**:
   - Open **Finder**
   - Go to where you saved the `macos_pr_widget` folder (Documents, Desktop, etc.)
   - Open the folder

2. **Find the Xcode project file**:
   - Look for a file named **PRWidget.xcodeproj**
   - It has a **blue Xcode icon** (looks like a hammer and blueprint)
   - **Don't** open the folder called `PRWidget.xcodeproj` - that's just its internal files

3. **Open it**:
   - **Double-click** on `PRWidget.xcodeproj`
   - Xcode will open with the project loaded
   - You'll see code files in the left sidebar

### Step 4: Build the App (First-Time Xcode Users)

**Don't worry if this looks complex!** Just follow these steps carefully:

1. **Wait for Xcode to finish preparing**:
   - Look at the top of the Xcode window
   - You might see "Indexing..." or "Processing files..."
   - ⏱️ Wait for this to complete (usually 30-60 seconds)

2. **Select what to build** (called the "scheme"):
   - Look at the **top-left** of the Xcode window
   - You'll see a dropdown button that shows a name (might say "PRWidget" or something else)
   - **Click** that dropdown
   - Select **"PRWidget"** from the list (NOT "PRWidgetExtension")
   - Right next to it, you should see **"My Mac"** - if not, click that dropdown and select "My Mac"

3. **Set up code signing** (so macOS trusts the app you're building):
   
   a. In the **left sidebar**, click the very top item - the blue **PRWidget** icon with "xcodeproj"
   
   b. In the main area, you'll see the project settings. Look for these tabs near the top:
      - Click the **"Signing & Capabilities"** tab
   
   c. You might see a warning about code signing. Here's how to fix it:
      - Look for a checkbox that says **"Automatically manage signing"**
      - **Check** that box
      - A dropdown will appear asking for your "Team"
      - Click the dropdown and select your name (your Apple ID)
      - If you don't see your name, click **"Add an Account..."** and sign in with your Apple ID
   
   d. The warnings should disappear

4. **Build and run the app**:
   - Click the big **Play button (▶️)** at the top-left of Xcode, OR
   - Press **⌘R** on your keyboard (hold Command and press R)
   - You'll see progress messages at the top: "Building..." then "Running..."
   - ⏱️ The first build takes 1-2 minutes
   - **Success!** A window will pop up titled "GitHub PR Widget Configuration"

**⚠️ IMPORTANT: If you see "Choose an app to run your widget" instead:**

This means you accidentally selected the wrong scheme! Here's how to fix it:

1. **Stop the current run**:
   - Click the **Stop button (■)** at the top-left (next to the Play button)

2. **Change the scheme**:
   - Look at the **top-left** corner of Xcode
   - You'll see a dropdown that might say "PRWidgetExtension" 
   - **Click** that dropdown
   - Select **"PRWidget"** (NOT "PRWidgetExtension")
   - Make sure "My Mac" appears next to it

3. **Run again**:
   - Click the **Play button (▶️)** again
   - Now you should see the configuration window!

**What's the difference?**
- **PRWidget** = The configuration app (this is what you want first!)
- **PRWidgetExtension** = The actual widget (you'll use this later for debugging)

**Troubleshooting Common Issues:**

❌ **"Choose an app to run your widget" dialog appears**:
   - **You selected the wrong scheme!** 
   - Stop the run (click the Stop button ■)
   - At the top-left, change the dropdown from "PRWidgetExtension" to **"PRWidget"**
   - Run again (▶️)
   - The configuration window should now appear

❌ **"Build Failed" error**:
   - Check that you selected "PRWidget" (not "PRWidgetExtension") at the top-left
   - Check that you see "My Mac" next to it
   - Try: Click **Product** menu → **Clean Build Folder**, then press ⌘R again

❌ **"Failed to load widget" error** or **WidgetKit error**:
   - This usually happens after a build. Don't worry - it's fixed!
   - The widget files were updated to fix configuration issues
   - Try these steps:
     1. Click **Product** menu → **Clean Build Folder** (⌘⇧K)
     2. Close Xcode completely
     3. Reopen the project
     4. Build and run again
   - If the error persists, restart your Mac (sometimes WidgetKit caches need a full restart)

❌ **"Code signing" error**:
   - Make sure "Automatically manage signing" is checked
   - Make sure you've signed in with your Apple ID
   - You might need to create a free Apple Developer account (it's automatic when you sign in)

❌ **"Indexing failed" error**:
   - Close Xcode
   - Delete the folder: `~/Library/Developer/Xcode/DerivedData`
   - Open the project again

❌ **Xcode seems frozen**:
   - Look at the very top-center of the window - it might still be processing
   - Wait a bit longer; the first time can take a few minutes

### Visual Guide: Where to Look in Xcode

When you open the project, here's what to look for:

**Top-Left Corner (Most Important!):**
```
[PRWidget ▼] [My Mac ▼] [▶️ Stop button]
   ^              ^         ^
   |              |         |
Scheme name   Destination  Run/Stop buttons
```

- **Scheme dropdown**: This MUST say "PRWidget" (not PRWidgetExtension!)
- **Destination dropdown**: This should say "My Mac" 
- **Play button**: Click this to build and run

**What you should see after clicking Play (▶️):**
- A new window appears with title "GitHub PR Widget Configuration"
- Text fields for "GitHub Token", "Repository Owner", and "Repository Name"
- A "Save Configuration" button

**What you should NOT see:**
- ❌ A dialog saying "Choose an app to run your widget"
- ❌ A list of apps like Mail, Calendar, Reminders, etc.
- If you see this, you selected the wrong scheme! See troubleshooting above.


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

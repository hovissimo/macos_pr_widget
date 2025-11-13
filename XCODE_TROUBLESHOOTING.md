# Xcode Project Corruption Troubleshooting

If you see an error like "The project is damaged and cannot be opened" or "PBXSourcesBuildPhase group unrecognized selector", try these steps:

## Solution 1: Clean Xcode Derived Data

1. **Close Xcode completely**
2. **Delete Derived Data folder**:
   ```bash
   rm -rf ~/Library/Developer/Xcode/DerivedData/*
   ```
3. **Delete project's local user data**:
   ```bash
   cd /path/to/macos_pr_widget
   rm -rf PRWidget.xcodeproj/xcuserdata
   rm -rf PRWidget.xcodeproj/project.xcworkspace/xcuserdata
   ```
4. **Reopen the project in Xcode**

## Solution 2: Reset Git to Known Good State

If the project file seems corrupted:

```bash
cd /path/to/macos_pr_widget
git fetch origin
git checkout origin/copilot/add-github-pr-status-widget -- PRWidget.xcodeproj/project.pbxproj
```

## Solution 3: Clone Fresh

Sometimes the easiest solution is to start fresh:

```bash
# Remove the old directory
cd ~
rm -rf macos_pr_widget

# Clone fresh
git clone https://github.com/hovissimo/macos_pr_widget.git
cd macos_pr_widget
git checkout copilot/add-github-pr-status-widget

# Open in Xcode
open PRWidget.xcodeproj
```

## Solution 4: Xcode Cache Issues

1. **Quit Xcode**
2. **Clear all Xcode caches**:
   ```bash
   # Clear module cache
   rm -rf ~/Library/Developer/Xcode/DerivedData/ModuleCache.noindex
   
   # Clear shared data
   rm -rf ~/Library/Caches/com.apple.dt.Xcode/*
   ```
3. **Restart your Mac** (yes, sometimes Xcode needs this)
4. **Open project again**

## Why This Happens

Xcode caches project structure in multiple places. When you:
- Pull new changes that modify the project file
- Switch branches
- Have the project open while git operations occur

...Xcode's cache can become out of sync with the actual project file, causing these errors even though the file itself is valid.

## Prevention

- **Always close Xcode** before pulling changes or switching branches
- **Clean build folder** (⌘⇧K) after pulling project file changes
- **Restart Xcode** after major project structure changes

## Still Having Issues?

If none of these work:

1. Check that you're on the latest commit:
   ```bash
   git log -1 --oneline
   ```

2. Verify the project file is valid:
   ```bash
   python3 -c "
   content = open('PRWidget.xcodeproj/project.pbxproj').read()
   print(f'Braces: {content.count(\"{\")} open, {content.count(\"}\")} close')
   print(f'Match: {content.count(\"{\")} == content.count(\"}\")}')
   "
   ```

3. Try opening with `xed` command line tool:
   ```bash
   xed PRWidget.xcodeproj
   ```

4. Check Xcode console for detailed error messages:
   - Open Console.app
   - Filter for "Xcode"
   - Look for errors when trying to open the project

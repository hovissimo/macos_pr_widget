# Widget Visual Design and Layout

## Widget Appearance

The GitHub PR Status Widget displays in a clean, macOS-native style using system colors and SF Symbols.

### Medium Size Widget (Recommended)
```
┌─────────────────────────────────────────┐
│  GitHub PRs                             │
│                                         │
│  #123 Add new feature               🟢  │
│    👥 alice🟢 bob🔴                      │
│    ✓ 2/3 (Tests)                        │
│    ⚠️ Out of date                        │
│                                         │
│  #124 Fix bug                       🟡  │
│    👥 charlie🟡                          │
│    ✓ 3/3                                │
│                                         │
│  #125 Update docs                   🟢  │
│    👥 dana🟢 eric🟢                      │
│    ✓ 4/4                                │
│                                         │
└─────────────────────────────────────────┘
```

### Large Size Widget
Shows more PRs and additional details with the same layout pattern.

## Color Legend

### Overall PR Status (right side circle)
- 🟢 **Green**: All checks passed, all reviews approved, branch up to date
- 🟡 **Yellow**: Pending reviews or checks in progress
- 🟠 **Orange**: Changes requested OR branch out of date
- 🔴 **Red**: Failed checks

### Reviewer Status (small circles next to usernames)
- 🟢 **Green**: Approved the PR
- 🔴 **Red**: Requested changes
- 🟡 **Yellow**: Review pending
- 🔵 **Blue**: Commented (no formal review)

### Icons Used
- `#123` - PR number (bold, small font)
- `👥` - Person.2 system icon (reviewers section)
- `✓` - Checkmark.circle system icon (CI/CD checks)
- `⚠️` - Exclamationmark.triangle system icon (out of date warning)

## Information Hierarchy

Each PR row displays information in this order:
1. **Header Line**: PR number, title (truncated if too long), status indicator
2. **Reviewers Line** (if any): Icon + reviewer usernames with status dots
3. **Checks Line** (if any): Icon + pass/fail count + failed check names (if applicable)
4. **Branch Status Line** (if out of date): Warning icon + message

## Widget States

### No Open PRs
```
┌─────────────────────────────────────────┐
│  GitHub PRs                             │
│                                         │
│  No open PRs                            │
│                                         │
└─────────────────────────────────────────┘
```

### Loading/Configuration Needed
If GitHub credentials are not configured, the widget shows:
```
┌─────────────────────────────────────────┐
│  GitHub PRs                             │
│                                         │
│  No open PRs                            │
│  (Check configuration)                  │
│                                         │
└─────────────────────────────────────────┘
```

## Interaction

- The widget is **read-only** - it displays information but is not interactive
- Updates automatically every **5 minutes**
- Configuration is done through the separate **PRWidget.app**

## Typography

- Title: `.headline` (GitHub PRs)
- PR Number: `.caption` with `.bold`
- PR Title: `.caption` with single line truncation
- Details: `.caption2` for reviewers, checks, and status messages
- "No open PRs": `.caption` in secondary color

## Spacing

- Main container: 8pt vertical spacing between PRs
- Each PR row: 4pt internal vertical spacing
- Horizontal elements: 4pt spacing between items
- Container padding: Standard SwiftUI `.padding()`

## Accessibility

- Color-coded indicators are supplemented with icons
- All text uses system fonts that respect user's accessibility settings
- Status is conveyed through multiple visual cues (color, icon, text)

## Example Real Data

```
┌─────────────────────────────────────────┐
│  GitHub PRs                             │
│                                         │
│  #847 Implement dark mode           🔴  │
│    👥 sarah_dev🟢 mike_pm🔴              │
│    ✓ 1/3 (Lint, Tests)                  │
│    ⚠️ Out of date                        │
│                                         │
│  #846 Add login feature             🟡  │
│    👥 alex_backend🟡                     │
│    ✓ 2/2                                │
│                                         │
│  #848 Update README                 🟢  │
│    👥 doc_writer🟢                       │
│    ✓ 1/1                                │
│                                         │
└─────────────────────────────────────────┘
```

This shows:
- PR #847: Has failed checks (Lint and Tests), one approval but one change request, and is out of date
- PR #846: All checks passed, waiting for review
- PR #848: All checks passed, approved, up to date - ready to merge!

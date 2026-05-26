# SwiftUI Toggle — Property Highlights

A beginner-friendly breakdown of `Toggle`, state binding, toggle styles, SF Symbols integration, and dynamic icon switching in SwiftUI.

---

## 📄 Code Overview

```swift
import SwiftUI

struct SwiftUIViewToggle: View {
    @State private var isOn: Bool = false

    var body: some View {
        VStack() {

            Toggle("Notification", isOn: $isOn)

            Text("\(isOn)")
                .font(.title)

            Toggle("Mic", isOn: $isOn)
                .font(.largeTitle)
                .tint(Color.red.opacity(0.8))
                .foregroundStyle(.green)

            Toggle("Mic", isOn: $isOn)
                .font(.largeTitle)
                .tint(Color.red.opacity(0.8))
                .foregroundStyle(.green)
                .toggleStyle(.button)

            Toggle("Mic", isOn: $isOn)
                .font(.largeTitle)
                .tint(Color.red.opacity(0.8))
                .foregroundStyle(.green)
                .toggleStyle(.automatic)

            Toggle("Mic",
                   systemImage: "mic.fill",
                   isOn: $isOn)
                .font(.largeTitle)
                .foregroundStyle(.green)
                .toggleStyle(.button)
                .labelStyle(.titleAndIcon)

            Toggle("Mic",
                   systemImage: isOn ? "mic.fill" : "mic.slash.fill",
                   isOn: $isOn)
                .font(.largeTitle)
                .foregroundStyle(.green)
                .toggleStyle(.button)
                .labelStyle(.iconOnly)
                .contentTransition(.symbolEffect)

        }
        .padding()
    }
}
```

---

# 🔘 What is Toggle?

`Toggle` is SwiftUI’s built-in control for representing a **Boolean state** (`true` / `false`).

```swift
Toggle("Notification", isOn: $isOn)
```

It behaves like:

- UISwitch in UIKit
- Checkbox / switch controls in other UI frameworks

---

## 🔑 Toggle + Binding Relationship

```swift
@State private var isOn: Bool = false
```

`@State` stores local mutable UI state.

```swift
Toggle("Notification", isOn: $isOn)
```

The `$` creates a `Binding<Bool>`.

### State Flow Visualization

```text
User taps Toggle
       ↓
Toggle changes Binding
       ↓
@State variable updates
       ↓
SwiftUI redraws the View
       ↓
UI reflects new state
```

---

## 🧠 Why `$isOn` Instead of `isOn`?

```swift
isOn     // actual Bool value
$isOn    // Binding<Bool>
```

`Toggle` needs permission to both:

- READ the value
- WRITE the value

So it requires a binding.

---

## 📱 Default Toggle Style

```swift
Toggle("Notification", isOn: $isOn)
```

Default appearance on iOS:

```text
Notification               [◉────]
```

Platform appearance changes automatically:

| Platform | Default Style |
|---|---|
| iOS | UISwitch |
| macOS | Checkbox / switch |
| watchOS | Compact switch |

> 💡 SwiftUI controls are adaptive — same code, different native appearance.

---

## 📝 Reflecting State in UI

```swift
Text("\(isOn)")
```

Displays:

```text
true
false
```

automatically whenever the toggle changes.

### Why It Updates Automatically

SwiftUI tracks `@State`.

When `isOn` changes:

```text
State changed
    ↓
View invalidated
    ↓
body recalculated
    ↓
Text updates automatically
```

---

# 🎨 Styling the Toggle

```swift
Toggle("Mic", isOn: $isOn)
    .font(.largeTitle)
    .tint(Color.red.opacity(0.8))
    .foregroundStyle(.green)
```

---

## 🔴 .tint()

```swift
.tint(Color.red.opacity(0.8))
```

Controls the accent color of the toggle switch.

### On iOS

```text
OFF → gray
ON  → red
```

---

## 🟢 .foregroundStyle()

```swift
.foregroundStyle(.green)
```

Changes the label color:

```text
Mic
```

NOT the switch itself.

---

## ⚠️ Important Difference

```swift
.tint(...)              // affects control accent color
.foregroundStyle(...)   // affects text/icons
```

---

# 🔘 .toggleStyle(.button)

```swift
.toggleStyle(.button)
```

Transforms the toggle from a switch into a tappable button-style control.

### Default Toggle

```text
Mic               [ON/OFF SWITCH]
```

### Button Style

```text
[ Mic ]
```

Tapping the button toggles the Boolean state internally.

---

## 🧠 Why Use Button Toggle Style?

Useful for:

- mute buttons
- favorite toggles
- reaction buttons
- like/bookmark states
- compact controls

---

# ⚙️ .toggleStyle(.automatic)

```swift
.toggleStyle(.automatic)
```

Lets SwiftUI choose the best style automatically for the current platform.

```text
iOS     → switch
macOS   → checkbox
watchOS → compact style
```

> 💡 `.automatic` is the default behavior already.

---

# 🎤 Toggle with SF Symbols

```swift
Toggle("Mic",
       systemImage: "mic.fill",
       isOn: $isOn)
```

SwiftUI provides a Toggle initializer with SF Symbols support.

---

## 📦 Equivalent Layout

This:

```swift
Toggle("Mic",
       systemImage: "mic.fill",
       isOn: $isOn)
```

roughly behaves like:

```swift
HStack {
    Image(systemName: "mic.fill")
    Text("Mic")
}
```

---

# 🏷️ .labelStyle(.titleAndIcon)

```swift
.labelStyle(.titleAndIcon)
```

Shows BOTH:

- icon
- text

```text
🎤 Mic
```

---

# 👁️ .labelStyle(.iconOnly)

```swift
.labelStyle(.iconOnly)
```

Hides the text label and keeps only the SF Symbol.

```text
🎤
```

Useful for:

- toolbars
- compact controls
- floating buttons
- media controls

---

# 🔄 Dynamic SF Symbol Switching

```swift
systemImage: isOn ? "mic.fill" : "mic.slash.fill"
```

The icon changes based on state.

### When ON

```text
mic.fill
```

### When OFF

```text
mic.slash.fill
```

---

## 🧠 Reactive UI Concept

This is declarative UI:

```swift
UI = function(state)
```

Instead of manually updating icons:

```swift
if isOn {
    imageView.image = ...
}
```

SwiftUI recomputes the UI automatically from state.

---

# ✨ .contentTransition(.symbolEffect)

```swift
.contentTransition(.symbolEffect)
```

Animates SF Symbol changes smoothly.

Example:

```text
mic.fill
    ↓
mic.slash.fill
```

becomes animated instead of instantly changing.

---

## ⚠️ iOS Availability

```swift
.contentTransition(.symbolEffect)
```

Requires:

| API | Minimum iOS |
|---|---|
| `.contentTransition()` | iOS 16+ |
| `.symbolEffect` | iOS 17+ |

If your deployment target is lower, Xcode shows:

```text
'contentTransition' is only available in iOS 16.0 or newer
'symbolEffect' is only available in iOS 17.0 or newer
```

### Compatibility Fix

```swift
if #available(iOS 17.0, *) {
    // use symbolEffect transition
}
```

or simply remove the modifier.

---

# 📦 VStack Layout

```swift
VStack() {
    ...
}
.padding()
```

Arranges all toggles vertically.

### .padding()

Adds spacing around the container:

```text
┌─────────────────────┐
│     padded area     │
│   toggle content    │
│     padded area     │
└─────────────────────┘
```

---

# 🆚 Toggle Styles Comparison

| Style | Appearance | Best Use |
|---|---|---|
| `.automatic` | Platform default | General settings |
| `.switch` | Native switch | Settings screens |
| `.button` | Tap button | Action toggles |

---

# ✅ Modifier Summary

| Modifier | Purpose |
|---|---|
| `Toggle(_:isOn:)` | Boolean control |
| `$isOn` | Binding to mutable state |
| `.tint()` | Changes toggle accent color |
| `.foregroundStyle()` | Styles text/icon color |
| `.toggleStyle(.button)` | Converts toggle into button behavior |
| `.toggleStyle(.automatic)` | Uses platform-native appearance |
| `systemImage:` | Adds SF Symbol to label |
| `.labelStyle(.titleAndIcon)` | Shows icon + text |
| `.labelStyle(.iconOnly)` | Shows icon only |
| `.contentTransition(.symbolEffect)` | Animates SF Symbol changes |
| `.padding()` | Adds outer spacing |

---

# 💡 Real-World Patterns

## 🔇 Mute Toggle Button

```swift
Toggle("Mute",
       systemImage: isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill",
       isOn: $isMuted)
    .toggleStyle(.button)
    .labelStyle(.iconOnly)
```

---

## 🌙 Dark Mode Toggle

```swift
Toggle("Dark Mode", isOn: $isDarkMode)
    .tint(.purple)
```

---

## ❤️ Favorite Button Toggle

```swift
Toggle("Favorite",
       systemImage: isFavorite ? "heart.fill" : "heart",
       isOn: $isFavorite)
    .toggleStyle(.button)
    .foregroundStyle(.red)
```

---

## 📶 Connectivity Toggle Panel

```swift
VStack(alignment: .leading, spacing: 16) {

    Toggle("Wi-Fi", isOn: $wifiEnabled)

    Toggle("Bluetooth", isOn: $bluetoothEnabled)

    Toggle("Airplane Mode", isOn: $airplaneMode)
}
.padding()
```

---

# 🧠 Key Learning Concepts

| Concept | Learned From |
|---|---|
| State-driven UI | `@State` + Toggle |
| Two-way binding | `$isOn` |
| Declarative rendering | Dynamic SF Symbol switching |
| Platform adaptation | `.automatic` style |
| Control customization | `.tint()` + `.toggleStyle()` |
| SF Symbols integration | `systemImage:` |
| Compact controls | `.iconOnly` |
| Reactive animation | `.contentTransition(.symbolEffect)` |

# SwiftUI View Extraction — Property Highlights

A beginner-friendly breakdown of extracting views into reusable structs, component design, and `.ignoresSafeArea()` in SwiftUI.

---

## 📄 Code Overview

```swift
import SwiftUI

// Root view — composes extracted components
struct SwiftUIExtractsView: View {
    @State private var counter = 0

    var body: some View {
        ZStack {
            BackgroundGradient()
            VStack {
                AppTitle(label: "Counter")
                FinalResult(result: counter)
                HStack {
                    AppButton(symbol: "-", color: .red)  { counter -= 1 }
                    AppButton(symbol: "+", color: .green) { counter += 1 }
                }
            }
        }
        .ignoresSafeArea()
    }
}

// Extracted components
struct BackgroundGradient: View { ... }
struct AppTitle: View { ... }
struct FinalResult: View { ... }
struct AppButton: View { ... }
```

---

## 🔑 Key Concept — View Extraction

This file refactors the previous counter into **extracted view structs**.

### Before — everything inline
```swift
var body: some View {
    ZStack {
        LinearGradient(colors: [.blue, .purple],
            startPoint: .topLeading, endPoint: .bottomTrailing)
        VStack {
            Text("Counter")
                .font(.largeTitle).bold().foregroundStyle(.white)
            Text(String(counter))
                .font(.system(size: 72, weight: .bold, design: .rounded))
                .foregroundStyle(.white).padding()
                .background { Circle().fill(.red) }
            HStack {
                // button code × 2...
            }
        }
    }
    .ignoresSafeArea()
}
```

### After — extracted structs ← current
```swift
var body: some View {
    ZStack {
        BackgroundGradient()           // ← 1 line replaces 3
        VStack {
            AppTitle(label: "Counter") // ← 1 line replaces 4
            FinalResult(result: counter)
            HStack {
                AppButton(symbol: "-", color: .red)  { counter -= 1 }
                AppButton(symbol: "+", color: .green) { counter += 1 }
            }
        }
    }
    .ignoresSafeArea()
}
```

### Why Extract?

| Benefit | Description |
|---|---|
| **Readability** | `body` reads like a component tree, not implementation |
| **Reusability** | `AppButton` used twice with different params |
| **Previewability** | Each struct gets its own `#Preview` |
| **Testability** | Smaller views are easier to isolate and test |
| **Xcode performance** | Smaller `body` = faster type-checking |

---

## 🏗️ Each Extracted Component

### BackgroundGradient
```swift
struct BackgroundGradient: View {
    var body: some View {
        LinearGradient(
            colors: [.blue, .purple],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
```
- No parameters — self-contained, always the same
- Replaces the commented-out computed property approach (shown below)

### Computed Property vs Extracted Struct

```swift
// Approach 1 — computed property (commented out in code)
var backgroundGradient: some View {
    LinearGradient(colors: [.blue, .purple], ...)
}
// Usage: backgroundGradient (no parens)

// Approach 2 — extracted struct ← current
struct BackgroundGradient: View { ... }
// Usage: BackgroundGradient() (with parens, like any View)
```

| Approach | Previews | Parameters | Reuse Across Files |
|---|---|---|---|
| Computed property | ❌ No | ❌ No | ❌ Same struct only |
| Extracted struct | ✅ Yes | ✅ Yes | ✅ Any file |

> 💡 Always prefer extracted structs for anything beyond trivial one-liners.

---

### AppTitle
```swift
struct AppTitle: View {
    let label: String           // ← parameterized, not hardcoded

    var body: some View {
        Text(label)
            .font(.largeTitle)
            .bold()
            .foregroundStyle(.white)
    }
}
```
- `label: String` makes it reusable for any title text
- Usage: `AppTitle(label: "Counter")` or `AppTitle(label: "Score")`

---

### FinalResult
```swift
struct FinalResult: View {
    let result: Int             // ← receives current counter value

    var body: some View {
        Text(String(result))
            .font(.system(size: 72, weight: .bold, design: .rounded))
            .foregroundStyle(.white)
            .padding()
            .background { Circle().fill(.red) }
    }
}
```

- `result: Int` is passed down from the parent's `@State counter`
- `String(result)` converts Int → String for `Text`
- The `Circle` background auto-sizes around the padded Text

> 💡 `FinalResult` does **not** own `@State` — it only **displays** a value.
> The parent owns the state and passes it down as a plain `let`.
> This is the correct SwiftUI data flow pattern.

---

### AppButton
```swift
struct AppButton: View {
    let symbol: String           // "+" or "-"
    let color: Color             // .green or .red
    let action: () -> Void       // what happens on tap

    var body: some View {
        Button(action: action) {
            Circle()
                .fill(.white)
                .frame(width: 60, height: 60)
                .shadow(radius: 2)
                .overlay {
                    Text(symbol)
                        .foregroundStyle(color)
                        .font(.system(size: 62, weight: .bold, design: .rounded))
                }
        }
    }
}
```

- Three parameters make it fully configurable
- `action: () -> Void` does **not** need `@escaping` here — stored as a `let` property, not a function parameter
- Used twice with different arguments — this is reusability in action

### Why No @escaping Here?

```swift
// Function parameter → @escaping needed (closure outlives the call)
private func counterButton(action: @escaping () -> Void) -> some View { }

// Stored property → no @escaping needed (stored directly as let)
struct AppButton: View {
    let action: () -> Void   // ← no @escaping required
}
```

---

## 🌐 .ignoresSafeArea()

```swift
ZStack {
    BackgroundGradient()
    VStack { ... }
}
.ignoresSafeArea()
```

- Allows the view to extend **behind the status bar and home indicator**
- Applied to the `ZStack` — affects the entire composition
- The gradient fills edge-to-edge; the content stays centered naturally

### Safe Area Variants

```swift
.ignoresSafeArea()                          // all edges, all regions ← current
.ignoresSafeArea(.all)                      // same as above
.ignoresSafeArea(.container, edges: .top)   // top only
.ignoresSafeArea(.container, edges: .bottom)// bottom only
.ignoresSafeArea(.keyboard)                 // keyboard avoidance only
```

> 💡 Only apply `.ignoresSafeArea()` to **background layers**.
> Interactive content (buttons, text) should stay within safe area bounds.

---

## 🔗 Data Flow — Parent → Child

```
SwiftUIExtractsView
│
│  @State private var counter = 0   ← owned here
│
├── BackgroundGradient()             ← no data needed
├── AppTitle(label: "Counter")       ← constant passed in
├── FinalResult(result: counter)     ← state VALUE passed as Int
└── HStack
    ├── AppButton("+", .green) { counter += 1 }  ← closure mutates parent state
    └── AppButton("-", .red)  { counter -= 1 }   ← closure mutates parent state
```

> 💡 This is the **unidirectional data flow** pattern:
> - State flows **down** as values (`result: counter`)
> - Events flow **up** as closures (`{ counter += 1 }`)
> - Child views never own or mutate state directly

---

## ✅ Component Design Summary

| Component | Parameters | Owns State | Purpose |
|---|---|---|---|
| `BackgroundGradient` | None | ❌ | Full-screen gradient layer |
| `AppTitle` | `label: String` | ❌ | Configurable title display |
| `FinalResult` | `result: Int` | ❌ | Displays current counter value |
| `AppButton` | `symbol`, `color`, `action` | ❌ | Reusable action button |
| `SwiftUIExtractsView` | — | ✅ `@State counter` | Root — owns all state |

---

## 💡 Real-World Extraction Pattern

```
Feature/
├── FeatureView.swift          ← root, owns @State / @StateObject
├── Components/
│   ├── FeatureHeader.swift    ← display only, receives data
│   ├── FeatureCard.swift      ← display only, receives data
│   └── FeatureButton.swift    ← action only, receives closure
└── ViewModel/
    └── FeatureViewModel.swift ← business logic (next step after @State)
```

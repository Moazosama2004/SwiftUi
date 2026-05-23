# SwiftUI @State Property Wrapper — Property Highlights

A beginner-friendly breakdown of `@State`, view re-rendering, and reusable view functions in SwiftUI.

---

## 📄 Code Overview

```swift
import SwiftUI

struct SwiftUIViewStatePropertyWrapper: View {
    @State private var counter = 0          // ← source of truth

    var body: some View {
        VStack(spacing: 20) {
            Text("Counter : \(counter)")    // ← reads state
            HStack(spacing: 40) {
                counterButton(label: "-") { counter -= 1 }  // ← writes state
                counterButton(label: "+") { counter += 1 }  // ← writes state
            }
        }
    }
}

private func counterButton(label: String, action: @escaping () -> Void) -> some View {
    Button(action: action) {
        Circle()
            .fill(.white)
            .frame(width: 50, height: 50)
            .shadow(radius: 1)
            .overlay {
                Text(label).foregroundStyle(.blue)
            }
    }
}
```

---

## 🔑 @State — The Core Concept

```swift
@State private var counter = 0
```

`@State` is a **property wrapper** that tells SwiftUI:
> "This value can change — and when it does, redraw any view that reads it."

### Without @State — broken

```swift
// ❌ Plain variable — SwiftUI never redraws when it changes
var counter = 0

Button("+") { counter += 1 }  // counter changes but UI stays frozen
```

### With @State — works

```swift
// ✅ @State variable — SwiftUI redraws automatically on change
@State private var counter = 0

Button("+") { counter += 1 }  // counter changes → UI updates instantly
```

---

## 🔄 How @State Works — The Render Cycle

```
User taps "+"
      │
      ▼
counter += 1          ← @State value changes
      │
      ▼
SwiftUI detects change
      │
      ▼
body is re-evaluated  ← Text("Counter: \(counter)") recomputes
      │
      ▼
UI updates on screen  ← new value visible instantly
```

> 💡 SwiftUI views are **structs** — they are value types.
> `@State` stores the value **outside** the struct in SwiftUI's managed memory,
> so it survives across re-renders of the struct.

---

## 🔒 Why private?

```swift
@State private var counter = 0
```

| Keyword | Reason |
|---|---|
| `@State` | Marks the variable as SwiftUI-managed, triggers redraws |
| `private` | Prevents other views from modifying this view's internal state |

> 💡 `@State` is meant for **local, view-owned state**.
> If another view needs to read or write it → use `@Binding` instead.
> Always make `@State` variables `private` as a rule.

---

## 📦 @State vs Other Property Wrappers

| Wrapper | Owns Data | Scope | Use When |
|---|---|---|---|
| `@State` | ✅ Yes | Single view | Simple local values — counter, toggle, text input |
| `@Binding` | ❌ No (reference) | Parent → Child | Child needs to read/write parent's state |
| `@StateObject` | ✅ Yes | Single view | Owning a class-based observable model |
| `@ObservedObject` | ❌ No (reference) | Any view | Reading a shared class-based model |
| `@EnvironmentObject` | ❌ No (reference) | Entire app tree | App-wide shared state |

---

## ♻️ Reusable View Function

```swift
private func counterButton(label: String, action: @escaping () -> Void) -> some View {
    Button(action: action) {
        Circle()
            .fill(.white)
            .frame(width: 50, height: 50)
            .shadow(radius: 1)
            .overlay {
                Text(label).foregroundStyle(.blue)
            }
    }
}
```

### Anatomy

| Part | Description |
|---|---|
| `private func` | Only accessible within this file |
| `label: String` | The text shown inside the circle (`"+"` or `"-"`) |
| `action: @escaping () -> Void` | A closure called when the button is tapped |
| `-> some View` | Returns an opaque SwiftUI view |

### @escaping — Why It's Needed

```swift
action: @escaping () -> Void
```

- The closure is **stored and called later** (when the button is tapped)
- `@escaping` tells Swift: "this closure will outlive the function call"
- Without `@escaping` → compiler error for closures stored or used asynchronously

```swift
// Non-escaping — closure runs immediately, doesn't need @escaping
func doNow(work: () -> Void) { work() }

// Escaping — closure stored, runs later → @escaping required
func doLater(work: @escaping () -> Void) {
    Button(action: work) { ... }  // stored inside Button
}
```

---

## 🔑 Key Concept — View Function vs View Struct

This file uses a **function** to create a reusable view. There are two approaches:

### Approach 1 — Private Function ← current
```swift
private func counterButton(label: String, action: @escaping () -> Void) -> some View {
    Button(action: action) { ... }
}

// Usage
counterButton(label: "+") { counter += 1 }
```

### Approach 2 — Child View Struct with @Binding
```swift
struct CounterButton: View {
    let label: String
    let action: () -> Void

    var body: some View {
        Button(action: action) { ... }
    }
}

// Usage
CounterButton(label: "+") { counter += 1 }
```

| Approach | Previews | Reuse Across Files | State Access |
|---|---|---|---|
| Private function | ❌ No | ❌ Same file only | Direct — reads parent scope |
| Child View struct | ✅ Yes | ✅ Any file | Via parameters / `@Binding` |

> 💡 For simple helpers used in one view → function is fine.
> For anything reused across multiple views → make it a `View` struct.

---

## 🧮 String Interpolation with @State

```swift
Text("Counter : \(counter)")
```

- `\(counter)` embeds the current value of `counter` into the string
- Every time `counter` changes → SwiftUI re-evaluates `body` → Text shows new value
- Works with any type that conforms to `CustomStringConvertible`

```swift
// Other common @State + interpolation patterns
Text("Score: \(score)")
Text("Name: \(username)")
Text("\(progress, specifier: "%.1f")%")  // formatted decimal
```

---

## ✅ Modifier Summary

| Element | Purpose |
|---|---|
| `@State private var counter = 0` | Declares SwiftUI-managed local state |
| `counter += 1` / `counter -= 1` | Mutates state → triggers redraw |
| `\(counter)` | Reads state value into Text |
| `@escaping () -> Void` | Closure stored and called later |
| `-> some View` | Opaque return type for view-building functions |
| `private func` | Scopes helper to current file only |

---

## 💡 Real-World Pattern — Toggle with @State

```swift
struct LikeButton: View {
    @State private var isLiked = false

    var body: some View {
        Button {
            isLiked.toggle()             // ← flips Bool, triggers redraw
        } label: {
            Image(systemName: isLiked ? "heart.fill" : "heart")
                .foregroundStyle(isLiked ? .red : .gray)
                .font(.title)
                .scaleEffect(isLiked ? 1.2 : 1.0)
                .animation(.spring(response: 0.3), value: isLiked)
        }
    }
}
```

> 💡 `.toggle()` is the cleanest way to flip a `Bool` @State variable.
> Pair it with `animation(value:)` for instant polish.

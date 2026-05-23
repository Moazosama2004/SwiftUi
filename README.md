# SwiftUI @Binding — Property Highlights

A beginner-friendly breakdown of `@Binding`, the `$` prefix, and two-way data flow between parent and child views.

---

## 📄 Code Overview

```swift
import SwiftUI

// Parent — owns the state
struct SwiftUIViewBinding: View {
    @State private var counter = 0

    var body: some View {
        ZStack {
            backgroundLinearGradient
            AppCounterFunctionality(counter: $counter)  // ← passes binding
        }
        .ignoresSafeArea()
    }
}

// Child — receives and mutates the binding
struct AppCounterFunctionality: View {
    @Binding var counter: Int                           // ← receives binding

    var body: some View {
        VStack {
            Text(String(counter))
                ...
            Button { counter += 1 } label: { ... }     // ← mutates parent state
        }
    }
}
```

---

## 🔑 Key Concept — @State vs @Binding

| Wrapper | Owns Data | Who Uses It | Direction |
|---|---|---|---|
| `@State` | ✅ Yes | Parent view | Creates the source of truth |
| `@Binding` | ❌ No | Child view | References parent's source of truth |

```
SwiftUIViewBinding          AppCounterFunctionality
┌─────────────────┐         ┌──────────────────────┐
│ @State counter  │────────►│ @Binding counter      │
│     = 0         │◄────────│  counter += 1         │
└─────────────────┘         └──────────────────────┘
   owns the data               reads AND writes it
```

> 💡 Think of `@Binding` as a **remote control** — the TV (state) lives
> in the parent, but the child holds a controller that can change it directly.

---

## $ — The Binding Operator

```swift
// Passing a binding — use $ prefix
AppCounterFunctionality(counter: $counter)
//                               ↑
//                        $ = "give a reference, not a copy"

// Declaring a binding — use @Binding
@Binding var counter: Int

// Reading value — no prefix needed
Text(String(counter))

// Writing value — no prefix needed
counter += 1
```

### $ Summary

| Syntax | What It Means |
|---|---|
| `counter` | The current **value** (Int) |
| `$counter` | A **Binding\<Int\>** — a reference to the state |
| `_counter` | The underlying **State\<Int\>** wrapper itself (advanced) |

---

## 🔄 Two-Way Data Flow

`@Binding` creates a **two-way connection**:

```swift
// Child reads → parent's Text also updates
Text(String(counter))   // shows parent's value

// Child writes → parent's @State updates → entire tree re-renders
Button { counter += 1 }
```

### Step by Step

```
1. User taps "+" in AppCounterFunctionality
         │
         ▼
2. counter += 1 runs on the @Binding
         │
         ▼
3. Parent's @State counter updates (same memory)
         │
         ▼
4. SwiftUI re-renders SwiftUIViewBinding
         │
         ▼
5. AppCounterFunctionality re-renders with new counter value
         │
         ▼
6. Text shows updated number ✅
```

---

## 🆚 @Binding vs Closure for Child Actions

The previous file used a **closure** to send actions up.
This file uses **@Binding** to share state directly.

```swift
// Approach 1 — Closure (previous file)
struct AppButton: View {
    let action: () -> Void     // child calls this to notify parent

    var body: some View {
        Button(action: action) { ... }
    }
}
// Parent decides what happens: AppButton { counter += 1 }

// Approach 2 — @Binding (this file)
struct AppCounterFunctionality: View {
    @Binding var counter: Int  // child directly mutates parent's value

    var body: some View {
        Button { counter += 1 } ...  // child handles its own logic
    }
}
// Parent just passes the reference: AppCounterFunctionality(counter: $counter)
```

| Approach | Child Knows About Logic | Flexibility | Use When |
|---|---|---|---|
| Closure | ❌ No — parent decides | ✅ More flexible | Simple actions, button taps |
| `@Binding` | ✅ Yes — child acts directly | ⚠️ Tighter coupling | Child needs to read AND write |

> 💡 **Rule of thumb:**
> - Use **closure** when child only triggers an event
> - Use **@Binding** when child needs to both read and modify the value

---

## 🎨 Computed Property — backgroundLinearGradient

```swift
var backgroundLinearGradient: some View {
    LinearGradient(
        colors: [.blue, .purple],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
```

- A **computed property** returning `some View`
- Used inline in `body` like any view: `backgroundLinearGradient`
- No parentheses — accessed like a variable, not called like a function
- Contrast with the previous file's extracted `BackgroundGradient()` struct

| Approach | Syntax | Previews | Reuse |
|---|---|---|---|
| Computed property | `backgroundLinearGradient` | ❌ | Same struct only |
| Extracted struct | `BackgroundGradient()` | ✅ | Any file |

---

## 🌈 Gradient on Circle Background

```swift
.background {
    Circle()
        .fill(
            .linearGradient(
                colors: [.red, .yellow],
                startPoint: .leading,
                endPoint: .trailing
            )
        )
}
```

- Uses the **ShapeStyle shorthand** `.linearGradient(...)` inside `.fill()`
- `.leading` → `.trailing` = horizontal gradient (red left, yellow right)
- The `Circle` auto-sizes to the padded `Text` — no `.frame()` needed

---

## 🔖 @Binding in Previews

When previewing a child view that requires `@Binding`, use `.constant()`:

```swift
struct AppCounterFunctionality_Previews: PreviewProvider {
    static var previews: some View {
        AppCounterFunctionality(counter: .constant(5))
        //                               ↑
        //                   fixed value, won't update — for preview only
    }
}
```

| Preview Binding | Description |
|---|---|
| `.constant(0)` | Fixed at 0 — no interaction |
| `.constant(99)` | Fixed at 99 — test large values |

---

## ✅ Full Data Flow Summary

```
SwiftUIViewBinding
│
│  @State private var counter = 0   ← source of truth lives here
│
└── AppCounterFunctionality(counter: $counter)
    │
    │  @Binding var counter: Int    ← reference to parent's counter
    │
    ├── Text(String(counter))       ← reads value
    └── Button { counter += 1 }    ← writes value → parent updates → UI re-renders
```

---

## 💡 Real-World @Binding Patterns

```swift
// Toggle switch
struct SettingsRow: View {
    let title: String
    @Binding var isOn: Bool

    var body: some View {
        Toggle(title, isOn: $isOn)  // Toggle also uses @Binding internally
    }
}

// Text field input
struct SearchBar: View {
    @Binding var searchText: String

    var body: some View {
        TextField("Search...", text: $searchText)  // $searchText = Binding<String>
    }
}

// Sheet presentation
struct ParentView: View {
    @State private var isSheetPresented = false

    var body: some View {
        Button("Open") { isSheetPresented = true }
            .sheet(isPresented: $isSheetPresented) {  // sheet takes Binding<Bool>
                Text("Sheet content")
            }
    }
}
```

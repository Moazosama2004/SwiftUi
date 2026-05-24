# SwiftUI .onAppear & Animation — Property Highlights

A beginner-friendly breakdown of `.onAppear`, `DispatchQueue`, `.offset()`, and `.animation()` in SwiftUI.

---

## 📄 Code Overview

```swift
import SwiftUI

struct SwiftUIViewOnAppear: View {
    @State private var isLoggedin = false
    @State private var username   = ""

    var body: some View {
        VStack(spacing: 40) {

            // 1. Text that updates after a delay
            Text(username)
                .clipShape(Capsule())
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        username = "Moaz Osama welcome back again."
                    }
                }

            // 2. Icon that slides back and forth forever
            Image(systemName: "photo.fill")
                .offset(x: isLoggedin ? 100 : -100, y: 0)
                .animation(.easeInOut(duration: 1.5).repeatForever(), value: isLoggedin)
                .onAppear {
                    isLoggedin = true
                }
        }
    }
}
```

---

## 👁️ .onAppear { }

```swift
.onAppear {
    // runs once when this view appears on screen
}
```

- Called **once** the first time the view becomes visible
- Attached to any view — runs when **that specific view** appears
- The SwiftUI equivalent of `viewDidAppear` in UIKit

### .onAppear vs .onDisappear

| Modifier | When It Runs |
|---|---|
| `.onAppear {}` | View becomes visible on screen |
| `.onDisappear {}` | View is removed from the screen |
| `.task {}` | View appears — async/await version (iOS 15+) |

```swift
.onAppear    { print("view appeared") }
.onDisappear { print("view disappeared") }

// Modern async alternative
.task {
    await loadData()   // automatically cancelled on disappear
}
```

> 💡 In this file, `.onAppear` is attached to **two different views**
> (the `Text` and the `Image`) — each runs its own block independently
> when that specific view appears.

---

## ⏱️ DispatchQueue.main.asyncAfter

```swift
.onAppear {
    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
        username = "Moaz Osama welcome back again."
    }
}
```

### Anatomy

| Part | Description |
|---|---|
| `DispatchQueue.main` | Run on the **main thread** — required for UI updates |
| `.asyncAfter(deadline:)` | Execute the closure after a delay |
| `.now() + 5` | 5 seconds from right now |
| `username = ...` | Updates `@State` → triggers redraw |

### Why main thread?

```swift
// ❌ Wrong — background thread cannot update UI
DispatchQueue.global().async {
    username = "Moaz"   // crash or undefined behavior
}

// ✅ Correct — UI updates must be on main thread
DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    username = "Moaz"
}
```

### Modern Alternative — Task + sleep

```swift
// iOS 15+ — cleaner async/await version
.task {
    try? await Task.sleep(for: .seconds(5))
    username = "Moaz Osama welcome back again."
}
```

| Approach | API Style | Cancellable |
|---|---|---|
| `DispatchQueue.main.asyncAfter` | GCD (older) | ❌ Hard to cancel |
| `Task.sleep` + `.task {}` | async/await (modern) | ✅ Auto-cancelled on disappear |

---

## 📐 .offset()

```swift
.offset(x: isLoggedin ? 100 : -100, y: 0)
```

- Moves the view **visually** without affecting layout
- Other views don't shift — only this view's render position changes
- Takes signed points: positive x = right, negative x = left

### .offset() vs .padding() vs .position()

| Modifier | Affects Layout | Use For |
|---|---|---|
| `.padding()` | ✅ Yes — pushes neighbors | Internal spacing |
| `.offset(x:y:)` | ❌ No — visual shift only | Animations, decorative positioning |
| `.position(x:y:)` | ❌ No — absolute in parent | Precise coordinate placement |

```swift
// offset — neighbors unaffected, view shifts visually
Image("icon")
    .offset(x: 50, y: 0)   // moves right 50pt, layout hole stays

// Before animation: x = -100 (left side)
// After animation:  x =  100 (right side)
// SwiftUI interpolates between the two → sliding motion
```

---

## 🎬 .animation()

```swift
.animation(
    .easeInOut(duration: 1.5).repeatForever(),
    value: isLoggedin
)
```

### Anatomy

| Part | Description |
|---|---|
| `.easeInOut(duration: 1.5)` | Curve type + duration in seconds |
| `.repeatForever()` | Loops the animation indefinitely |
| `value: isLoggedin` | Watches this value — animates when it changes |

### Animation Curves

| Curve | Motion Feel |
|---|---|
| `.linear` | Constant speed — robotic |
| `.easeIn` | Starts slow, ends fast |
| `.easeOut` | Starts fast, ends slow |
| `.easeInOut` | Starts and ends slow, fast in middle ← current |
| `.spring()` | Bouncy, physical feel |
| `.bouncy` | Shorthand spring (iOS 17+) |

### Repeat Options

```swift
.repeatForever()                      // loops forever ← current
.repeatForever(autoreverses: true)    // A→B→A→B (default)
.repeatForever(autoreverses: false)   // A→B, A→B (jumps back)
.repeatCount(3)                       // runs exactly 3 times
.repeatCount(3, autoreverses: true)   // A→B→A, 3 times
```

> 💡 Default `autoreverses: true` means the sliding icon goes
> left → right → left → right automatically — no extra code needed.

---

## 🔑 Key Concept — How This Animation Works

```swift
// Step 1 — initial state, no animation yet
@State private var isLoggedin = false
// offset = x: -100 (left side)

// Step 2 — view appears, trigger fires
.onAppear {
    isLoggedin = true   // state changes to true
}

// Step 3 — SwiftUI sees isLoggedin changed
// animation modifier intercepts the change
.animation(.easeInOut(duration: 1.5).repeatForever(), value: isLoggedin)

// Step 4 — SwiftUI animates from old offset to new offset
// x: -100 → x: 100, over 1.5 seconds, easeInOut, forever
.offset(x: isLoggedin ? 100 : -100, y: 0)
```

### The Ternary Pattern for Animation

```swift
// General pattern
.someModifier(value: condition ? valueWhenTrue : valueWhenFalse)
.animation(.someAnimation, value: condition)

// Common examples
.offset(x: isVisible ? 0 : -300)          // slide in from left
.opacity(isVisible ? 1.0 : 0.0)           // fade in/out
.scaleEffect(isPressed ? 0.9 : 1.0)       // shrink on press
.rotationEffect(.degrees(isSpinning ? 360 : 0))  // rotate
```

---

## ✅ Modifier Summary

| Modifier | Purpose |
|---|---|
| `.onAppear {}` | Runs code when view first appears on screen |
| `DispatchQueue.main.asyncAfter(deadline: .now() + 5)` | Delays a UI update by 5 seconds |
| `.offset(x:y:)` | Visually shifts the view without affecting layout |
| `.animation(.easeInOut(duration:), value:)` | Animates changes to a watched value |
| `.repeatForever()` | Loops the animation indefinitely |
| `.easeInOut` | Smooth start and end to the motion |

---

## 💡 Real-World Patterns

### Skeleton Loading Shimmer
```swift
@State private var shimmer = false

RoundedRectangle(cornerRadius: 8)
    .fill(.gray.opacity(0.3))
    .frame(height: 20)
    .overlay(
        RoundedRectangle(cornerRadius: 8)
            .fill(.white.opacity(0.6))
            .offset(x: shimmer ? 300 : -300)
    )
    .clipped()
    .onAppear {
        withAnimation(.linear(duration: 1.2).repeatForever(autoreverses: false)) {
            shimmer = true
        }
    }
```

### Delayed Welcome Message
```swift
@State private var message = "Loading..."

Text(message)
    .onAppear {
        Task {
            try? await Task.sleep(for: .seconds(2))
            message = "Welcome back, Moaz! 👋"
        }
    }
```

### Entrance Animation
```swift
@State private var appeared = false

VStack { ... }
    .opacity(appeared ? 1 : 0)
    .offset(y: appeared ? 0 : 30)
    .animation(.easeOut(duration: 0.5), value: appeared)
    .onAppear { appeared = true }
```

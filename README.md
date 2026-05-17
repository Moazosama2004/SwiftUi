# SwiftUI Circle View — Property Highlights

A beginner-friendly breakdown of `Circle` shape modifiers in SwiftUI, including trimming, stroking, and layering with background views.

---

## 📄 Code Overview

```swift
import SwiftUI

struct SwiftUICircle: View {
    var body: some View {
        Circle()
            .trim(from: 0, to: 0.75)
            .stroke(.blue, style: StrokeStyle(lineWidth: 12, lineCap: .round, dash: [50]))
            .background {
                Text("Loading")
                    .font(.title)
                    .fontWeight(.bold)
            }
            .foregroundColor(.red)
            .frame(width: 300, height: 300, alignment: .center)
    }
}
```

---

## ⭕ Shape Modifiers

| Modifier | Description |
|---|---|
| `Circle()` | Draws a perfect circle that fills its available space |
| `.trim(from:to:)` | Draws only a portion of the shape. `0` = start, `1` = full circle |
| `.fill(.blue)` | Fills the circle with a solid color *(commented out)* |
| `.foregroundColor(.red)` | Sets the default color for the shape and its children |

---

## ✏️ Stroke & StrokeStyle

```swift
.stroke(.blue, style: StrokeStyle(
    lineWidth: 12,       // Thickness of the stroke line
    lineCap: .round,     // Rounded ends at the trim start/end points
    dash: [50]           // Dashed line: 50pt dash, 50pt gap (repeating)
))
```

| Property | Value | Description |
|---|---|---|
| `lineWidth` | `12` | Thickness of the circle's outline |
| `lineCap` | `.round` | Shape of the line ends — `.butt`, `.round`, `.square` |
| `dash` | `[50]` | Dash pattern in points. `[50]` = 50pt on, 50pt off |

> 💡 `.stroke()` replaces the fill — it draws only the outline.  
> You cannot use `.fill()` and `.stroke()` together directly; use `.strokeBorder()` or `ZStack` instead.

---

## 🎬 .trim() — The Progress Effect

```swift
.trim(from: 0, to: 0.75)  // Draws 75% of the circle
```

| Value | Result |
|---|---|
| `to: 0.25` | Quarter circle |
| `to: 0.5` | Half circle |
| `to: 0.75` | Three-quarter circle *(current)* |
| `to: 1.0` | Full circle |

> ⚠️ `.trim()` must come **before** `.stroke()` — order matters!

---

## 🖼️ .background { } — Layering Views

```swift
.background {
    Text("Loading")
        .font(.title)
        .fontWeight(.bold)
}
```

- Places a view **behind** the current view
- The background is centered within the shape's bounds
- Does **not** affect the shape's layout or size
- Perfect for adding labels, icons, or colors behind a shape

> 💡 This is different from `ZStack` — `.background {}` is relative and auto-centered, while `ZStack` gives you full control over positioning.

---

## 📐 Layout

| Modifier | Description |
|---|---|
| `.frame(width: 300, height: 300, alignment: .center)` | Fixes the view at 300×300 points, centered |

---

## ✅ Active vs Commented-Out Modifiers

**Active:**
- `.trim(from: 0, to: 0.75)`
- `.stroke(.blue, style: StrokeStyle(...))`
- `.background { Text("Loading") }`
- `.foregroundColor(.red)`
- `.frame(width: 300, height: 300)`

**Commented out:**
- `.fill(.blue)` — would fill the full shape; conflicts with `.stroke()`

---

## 💡 Real-World Use Case

This pattern is the foundation of a **circular loading/progress indicator**:

```swift
Circle()
    .trim(from: 0, to: progress)   // animate this value from 0 → 1
    .stroke(.blue, style: StrokeStyle(lineWidth: 12, lineCap: .round))
    .rotationEffect(.degrees(-90)) // start from top instead of right
    .frame(width: 300, height: 300)
```

> Pair `.trim(to:)` with `@State` + `withAnimation {}` and you have a live progress ring! 🎯

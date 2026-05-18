# SwiftUI Capsule View — Property Highlights

A beginner-friendly breakdown of `Capsule` and two approaches to layering text over shapes in SwiftUI.

---

## 📄 Code Overview

```swift
import SwiftUI

struct SwiftUIViewCapsule: View {
    var body: some View {
        VStack(spacing: 100) {

            // Approach 1 — Standalone Capsule (no text)
            Capsule(style: .circular)
                .fill(.blue)
                .frame(width: 300, height: 100)

            // Approach 2 — Text with Capsule as background
            Text("Next")
                .foregroundColor(.white)
                .font(.system(size: 32, weight: .regular, design: .default))
                .background {
                    Capsule(style: .circular)
                        .fill(.blue)
                        .frame(width: 300, height: 100)
                }
        }
    }
}
```

---

## 💊 Capsule

```swift
Capsule(style: .circular)
```

- A rectangle where the **shorter sides are fully rounded** into semicircles
- Corner radius is always **exactly half the shorter dimension** — automatic, no manual value needed
- Accepts the same `style` parameter as `RoundedRectangle`

### Capsule vs RoundedRectangle vs Circle

| Shape | Corner Behavior | Best For |
|---|---|---|
| `Circle()` | Always perfectly round | Icons, avatars, badges |
| `Capsule()` | Auto max-radius on short sides | Buttons, tags, pills |
| `RoundedRectangle(cornerRadius:)` | Manual radius control | Cards, modals, inputs |

---

## 🎨 .fill() vs .foregroundColor()

Both set the shape's color — but they are different:

| Modifier | API | Works On |
|---|---|---|
| `.foregroundColor(.blue)` | Older (still valid) | Shapes, Text, Images |
| `.fill(.blue)` | Shape-specific, modern | Shapes only |
| `.foregroundStyle(.blue)` | Modern (iOS 15+) | Shapes, Text, supports gradients |

```swift
// These produce the same visual result on a Capsule:
Capsule().foregroundColor(.blue)
Capsule().fill(.blue)            // ← preferred for shapes
Capsule().foregroundStyle(.blue) // ← most modern, supports gradients
```

> 💡 Prefer `.fill()` when working with shapes — it clearly communicates intent.

---

## 🔑 Key Concept — Two Ways to Put Text on a Shape

This file shows **both approaches** side by side. Understanding the difference is important:

### Approach 1 — Standalone Shape (no text)
```swift
Capsule()
    .fill(.blue)
    .frame(width: 300, height: 100)
```
Just a plain shape. To add text you'd need a `ZStack`.

---

### Approach 2 — Text + .background { Shape }
```swift
Text("Next")
    .foregroundColor(.white)
    .background {
        Capsule()
            .fill(.blue)
            .frame(width: 300, height: 100)
    }
```
The `Text` is the **main view**. The `Capsule` is placed **behind it** via `.background {}`.

---

### Approach 3 — ZStack (the recommended pattern for buttons)
```swift
ZStack {
    Capsule()
        .fill(.blue)
        .frame(width: 300, height: 100)
    Text("Next")
        .foregroundColor(.white)
        .font(.system(size: 32))
}
```

### All Three Compared

| Approach | Layout Control | Centering | Use Case |
|---|---|---|---|
| Shape only | ✅ Full | — | Decorative shapes |
| Text + `.background {}` | ⚠️ Text drives size | Auto-centered | Quick labels |
| `ZStack` | ✅ Full | ✅ Explicit | Buttons, cards *(recommended)* |

> ⚠️ **The `.background {}` approach has a subtle issue here:**  
> The `Text("Next")` is tiny — only 32pt tall. The `.frame(300×100)` on the Capsule  
> makes the background large, but the tap area and layout are still driven by the `Text` size.  
> Use `ZStack` for production buttons to keep layout predictable.

---

## ✅ Active vs Commented-Out Modifiers

**Active:**
- `.fill(.blue)` — solid blue fill on the Capsule
- `.frame(width: 300, height: 100)` — fixed size

**Commented out:**
- `.foregroundColor(.blue)` — older alternative to `.fill()`
- `.stroke(.green, style: StrokeStyle(...))` — outlined dashed variant

---

## 💡 Real-World Button Pattern

Combining everything from the last few views — here's a production-ready SwiftUI button:

```swift
Button(action: { }) {
    Text("Next")
        .foregroundColor(.white)
        .font(.system(size: 20, weight: .semibold, design: .rounded))
        .frame(width: 300, height: 60)
        .background(
            Capsule(style: .continuous)
                .fill(.blue)
        )
}
```

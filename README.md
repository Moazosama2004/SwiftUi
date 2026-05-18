# SwiftUI Rectangle View — Property Highlights

A beginner-friendly breakdown of `Rectangle`, `RoundedRectangle`, and `VStack` in SwiftUI.

---

## 📄 Code Overview

```swift
import SwiftUI

struct SwiftUIViewRectangle: View {
    var body: some View {
        VStack(spacing: 20) {
            Rectangle()
                .frame(width: 300, height: 200)
                .foregroundColor(.blue)

            RoundedRectangle(cornerRadius: 30)
                .frame(width: 300, height: 200)
                .foregroundColor(.blue)

            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .frame(width: 300, height: 200)
                .foregroundColor(.blue)
        }
    }
}
```

---

## 📦 VStack — Vertical Stack

```swift
VStack(spacing: 20) {
    // views stacked top → bottom
}
```

| Parameter | Value | Description |
|---|---|---|
| `spacing` | `20` | Gap in points between each child view |
| *(default alignment)* | `.center` | Children are horizontally centered |

### Stack Types Comparison

| Stack | Direction | Use Case |
|---|---|---|
| `VStack` | Top → Bottom *(current)* | Vertical layouts, lists, forms |
| `HStack` | Left → Right | Horizontal layouts, toolbars |
| `ZStack` | Back → Front | Overlapping/layered views |

---

## 🟦 Rectangle

```swift
Rectangle()
    .frame(width: 300, height: 200)
    .foregroundColor(.blue)
```

- The most basic shape — a plain rectangle with **sharp 90° corners**
- Fills its frame completely
- No customization on corners

---

## 🔲 RoundedRectangle

```swift
// Style 1 — default circular rounding
RoundedRectangle(cornerRadius: 30)

// Style 2 — continuous (squircle) rounding
RoundedRectangle(cornerRadius: 30, style: .continuous)
```

### cornerRadius

| Value | Result |
|---|---|
| `0` | Same as a plain `Rectangle` |
| `10` | Subtle rounding |
| `30` | Noticeable rounded corners *(current)* |
| `100`+ | Pill / capsule shape |

---

## 🔑 Key Difference — RoundedCornerStyle

This is the most important concept in this file:

| Style | Curve Type | Look |
|---|---|---|
| `.circular` *(default)* | Standard quarter-circle arc | Classic rounded rectangle |
| `.continuous` | Smooth bezier curve (squircle) | Apple-style, softer feel |

```swift
RoundedRectangle(cornerRadius: 30)              // .circular — abrupt curve join
RoundedRectangle(cornerRadius: 30, style: .continuous)  // .continuous — flows smoothly
```

> 💡 `.continuous` is the style Apple uses on **app icons, cards, and UI elements** across iOS.
> If you want your UI to feel native and modern, prefer `.continuous`.

### Visual Comparison

```
.circular                    .continuous
┌──────────────┐             ╭──────────────╮
│              │             │              │
│              │    vs       │              │
│              │             │              │
└──────────────┘             ╰──────────────╯
 Abrupt corner join           Smooth flow into corner
```

---

## 🎨 .foregroundColor

```swift
.foregroundColor(.blue)
```

- Sets the **fill color** of the shape
- Applied after `.frame()` — order doesn't matter here since it's not a layout modifier
- Can be replaced with the modern `.foregroundStyle(.blue)` (iOS 15+)

---

## ✅ Shape Comparison — All Three

| Shape | Corners | Style |
|---|---|---|
| `Rectangle()` | Sharp (0 radius) | — |
| `RoundedRectangle(cornerRadius: 30)` | Rounded | `.circular` (default) |
| `RoundedRectangle(cornerRadius: 30, style: .continuous)` | Rounded | `.continuous` (squircle) |

---

## 💡 Capsule — Bonus Shape

If you push `cornerRadius` to the max, you get a pill shape.  
SwiftUI has a dedicated shape for this:

```swift
Capsule()
    .frame(width: 300, height: 200)
    .foregroundColor(.blue)
// Automatically applies maximum corner rounding
```

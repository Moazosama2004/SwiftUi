# SwiftUI Ellipse View — Property Highlights

A beginner-friendly breakdown of the `Ellipse` shape and its modifiers in SwiftUI.

---

## 📄 Code Overview

```swift
import SwiftUI

struct SwiftUIViewEllipse: View {
    var body: some View {
        Ellipse()
            .stroke(.blue, style: StrokeStyle(lineWidth: 20, lineCap: .butt, dash: [20]))
            .background {
                Text("Loading...")
                    .font(.system(size: 32, design: .rounded))
            }
            .frame(width: 300, height: 400, alignment: .center)
    }
}
```

---

## 🥚 Ellipse vs Circle

| Shape | Description |
|---|---|
| `Circle()` | Always a perfect circle — width and height are equal |
| `Ellipse()` | Stretches to fill its frame — width and height can differ |

```swift
.frame(width: 300, height: 400)  // Ellipse stretches to fill → oval shape
.frame(width: 300, height: 300)  // Ellipse in equal frame → looks like a circle
```

> 💡 `Ellipse` is essentially a flexible `Circle` — its shape is defined entirely by the `.frame()` you give it.

---

## ✏️ Stroke & StrokeStyle

```swift
.stroke(.blue, style: StrokeStyle(
    lineWidth: 20,    // Thicker outline than the Circle example
    lineCap: .butt,   // Flat, sharp ends (no rounding)
    dash: [20]        // 20pt dash, 20pt gap (repeating)
))
```

### lineCap Comparison

| Value | Appearance | Use Case |
|---|---|---|
| `.butt` | Flat cut at the exact end point *(current)* | Sharp, technical look |
| `.round` | Rounded cap extending beyond end | Soft, modern look |
| `.square` | Flat cap extending beyond end | Precise with extra length |

### dash Pattern

| Pattern | Result |
|---|---|
| `dash: [20]` | 20pt on, 20pt off *(current)* |
| `dash: [20, 5]` | 20pt dash, 5pt gap |
| `dash: [5]` | Dotted look with small dashes |
| `dash: []` / no dash | Solid continuous line |

---

## 🔤 .font(.system) — Design Parameter

```swift
.font(.system(size: 32, design: .rounded))
```

| Parameter | Value | Description |
|---|---|---|
| `size` | `32` | Font size in points |
| `weight` | *(omitted)* | Defaults to `.regular` |
| `design` | `.rounded` | Applies rounded letterforms to the system font |

### Font Design Options

| Design | Look |
|---|---|
| `.default` | Standard San Francisco font |
| `.rounded` | Softer, rounded letterforms *(current)* |
| `.monospaced` | Fixed-width characters |
| `.serif` | Traditional serif style |

---

## 🖼️ .background { } — Recap

```swift
.background {
    Text("Loading...")
        .font(.system(size: 32, design: .rounded))
}
```

- Renders the `Text` **centered behind** the Ellipse stroke
- Inherits the frame of the parent (`300 × 400`)
- Does not interfere with the shape's layout

---

## ✅ Active vs Commented-Out Modifiers

**Active:**
- `.stroke(.blue, style: StrokeStyle(lineWidth: 20, lineCap: .butt, dash: [20]))`
- `.background { Text("Loading...") }`
- `.frame(width: 300, height: 400, alignment: .center)`

**Commented out:**
- `.trim(from: 0.25, to: 0.99)` — would draw ~75% of the ellipse outline
- `.fill(.red)` — solid red fill; conflicts with `.stroke()`
- `.foregroundStyle(.blue)` — modern alternative to `.foregroundColor()`

---

## ⚡ .foregroundColor vs .foregroundStyle

| Modifier | Notes |
|---|---|
| `.foregroundColor(.blue)` | Older API, still works |
| `.foregroundStyle(.blue)` | Modern API (iOS 15+), supports gradients too |

```swift
// Modern usage — supports gradients
.foregroundStyle(
    LinearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom)
)
```

---

## 💡 Circle vs Ellipse — Side by Side

```swift
// Circle — always square frame
Circle()
    .stroke(.blue, lineWidth: 4)
    .frame(width: 300, height: 300)

// Ellipse — rectangular frame → oval
Ellipse()
    .stroke(.blue, lineWidth: 4)
    .frame(width: 300, height: 400)  // taller than wide → portrait oval
```

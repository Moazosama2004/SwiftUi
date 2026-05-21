# SwiftUI Gradients — Property Highlights

A beginner-friendly breakdown of every gradient type available in SwiftUI.

---

## 📄 Code Overview

```swift
import SwiftUI

struct SwiftUIViewGradient: View {
    var body: some View {
        VStack(spacing: 20) {

            // 1. Linear Gradient
            Circle()
                .fill(LinearGradient(colors: [.red, .green],
                    startPoint: .top, endPoint: .bottom))
                .frame(width: 100, height: 100)

            // 2. Radial Gradient
            Circle()
                .fill(RadialGradient(colors: [.red, .blue],
                    center: .center, startRadius: 20, endRadius: 50))
                .frame(width: 100, height: 100)

            // 3. Angular Gradient
            Circle()
                .fill(AngularGradient(colors: [.yellow, .blue],
                    center: .center, angle: .degrees(0)))
                .frame(width: 100, height: 100)

            // 4. ShapeStyle shorthand (.linearGradient)
            Circle()
                .fill(.linearGradient(colors: [.purple, .white],
                    startPoint: .bottom, endPoint: .bottomTrailing))
                .frame(width: 100, height: 100)
        }
    }
}
```

---

## 🌈 Gradient Types — Overview

| Type | Direction | Visual Effect |
|---|---|---|
| `LinearGradient` | Straight line A → B | Smooth directional blend |
| `RadialGradient` | Center → outward circle | Glow / spotlight effect |
| `AngularGradient` | Sweeps around a center point | Conic / color wheel effect |

---

## 1️⃣ LinearGradient

```swift
LinearGradient(
    colors: [.red, .green],
    startPoint: .top,
    endPoint: .bottom
)
```

Blends colors along a **straight line** from `startPoint` to `endPoint`.

### UnitPoint Values

| Value | Position |
|---|---|
| `.top` | Top center |
| `.bottom` | Bottom center |
| `.leading` | Left center |
| `.trailing` | Right center |
| `.topLeading` | Top-left corner |
| `.topTrailing` | Top-right corner |
| `.bottomLeading` | Bottom-left corner |
| `.bottomTrailing` | Bottom-right corner |
| `.center` | Dead center |

```swift
// Common combinations
startPoint: .top,         endPoint: .bottom         // vertical
startPoint: .leading,     endPoint: .trailing       // horizontal
startPoint: .topLeading,  endPoint: .bottomTrailing // diagonal
```

---

## 2️⃣ RadialGradient

```swift
RadialGradient(
    colors: [.red, .blue],
    center: .center,
    startRadius: 20,
    endRadius: 50
)
```

Blends colors **outward from a center point** in expanding circles.

| Parameter | Value | Description |
|---|---|---|
| `center` | `.center` | Origin point of the gradient |
| `startRadius` | `20` | Where the first color begins (in points) |
| `endRadius` | `50` | Where the last color ends (in points) |

> 💡 Colors beyond `endRadius` stay at the last color.  
> Colors before `startRadius` stay at the first color.

```swift
// Tight glow                     // Wide soft fade
startRadius: 0, endRadius: 20     startRadius: 0, endRadius: 200
```

---

## 3️⃣ AngularGradient

```swift
AngularGradient(
    colors: [.yellow, .blue],
    center: .center,
    angle: .degrees(0)
)
```

Blends colors by **rotating around a center point** — like a color wheel or conic gradient.

| Parameter | Value | Description |
|---|---|---|
| `center` | `.center` | Pivot point of the sweep |
| `angle` | `.degrees(0)` | Starting angle of the gradient sweep |

### Angle Reference

| Degrees | Direction |
|---|---|
| `0°` | Right (3 o'clock) |
| `90°` | Bottom (6 o'clock) |
| `180°` | Left (9 o'clock) |
| `270°` | Top (12 o'clock) |

```swift
// Start sweep from top (12 o'clock)
AngularGradient(colors: [.yellow, .blue, .yellow],
    center: .center, angle: .degrees(270))
```

> 💡 Repeating the first color at the end creates a **seamless color wheel**:
> ```swift
> colors: [.red, .yellow, .green, .blue, .red]
> ```

---

## 4️⃣ ShapeStyle Shorthand

```swift
// Long form — explicit type
.fill(LinearGradient(colors: [.purple, .white],
    startPoint: .bottom, endPoint: .bottomTrailing))

// Short form — ShapeStyle dot syntax
.fill(.linearGradient(colors: [.purple, .white],
    startPoint: .bottom, endPoint: .bottomTrailing))
```

| Shorthand | Full Type |
|---|---|
| `.linearGradient(...)` | `LinearGradient(...)` |
| `.radialGradient(...)` | `RadialGradient(...)` |
| `.angularGradient(...)` | `AngularGradient(...)` |
| `.ellipticalGradient(...)` | `EllipticalGradient(...)` |

> 💡 Both produce identical results. The shorthand is cleaner and preferred in modern SwiftUI.

---

## 🎨 Multi-Stop Gradients

All gradient types support **more than 2 colors**:

```swift
// 2 stops — simple blend
colors: [.red, .blue]

// 3 stops — middle transition
colors: [.red, .yellow, .blue]

// Many stops — rich gradient
colors: [.red, .orange, .yellow, .green, .blue, .purple]
```

### Using `stops:` for Precise Control

```swift
LinearGradient(
    stops: [
        .init(color: .red,    location: 0.0),  // starts at 0%
        .init(color: .yellow, location: 0.3),  // yellow at 30%
        .init(color: .blue,   location: 1.0)   // ends at 100%
    ],
    startPoint: .top,
    endPoint: .bottom
)
```

> 💡 `stops:` gives you exact control over **where** each color appears.  
> `colors:` distributes them evenly automatically.

---

## ✅ All Gradient Types — Summary

| Gradient | Key Parameters | Visual |
|---|---|---|
| `LinearGradient` | `startPoint`, `endPoint` | Directional blend → |
| `RadialGradient` | `center`, `startRadius`, `endRadius` | Glow from center ◎ |
| `AngularGradient` | `center`, `angle` | Rotating sweep ↻ |
| `EllipticalGradient` | `center`, `startFraction`, `endFraction` | Oval glow ⬭ |

---

## 💡 Real-World Usage

```swift
// Sunset button
RoundedRectangle(cornerRadius: 16, style: .continuous)
    .fill(LinearGradient(
        colors: [.orange, .pink, .purple],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    ))
    .frame(width: 280, height: 60)

// Radar / loading ring
Circle()
    .fill(AngularGradient(
        colors: [.blue, .blue.opacity(0), .blue],
        center: .center,
        angle: .degrees(270)
    ))
```

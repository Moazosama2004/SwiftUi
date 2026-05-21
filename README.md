# SwiftUI VStack & Layout — Property Highlights

A beginner-friendly breakdown of `VStack`, `HStack`, `Spacer`, and padding in SwiftUI.

---

## 📄 Code Overview

```swift
import SwiftUI

struct SwiftUIViewVStack: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {

            RoundedRectangle(cornerRadius: 10)
                .fill(.blue)
                .frame(width: 300, height: 100)

            Spacer()

            RoundedRectangle(cornerRadius: 10)
                .fill(.green)
                .frame(width: 200, height: 100)

            HStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.yellow)
                    .frame(width: 100, height: 100)

                Spacer()

                RoundedRectangle(cornerRadius: 10)
                    .fill(.yellow)
                    .frame(width: 100, height: 100)
            }

        }
        .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
    }
}
```

---

## 📦 VStack Parameters

```swift
VStack(
    alignment: .leading,
    spacing: 10
) { ... }
```

| Parameter | Value | Description |
|---|---|---|
| `alignment` | `.leading` | Children align to the **left edge** |
| `spacing` | `10` | Fixed gap between each child view |

### VStack Alignment Options

| Value | Children Align To |
|---|---|
| `.leading` | Left edge ← current |
| `.trailing` | Right edge |
| `.center` | Center (default) |

> 💡 Alignment in `VStack` controls **horizontal** position of children.  
> Alignment in `HStack` controls **vertical** position of children.

---

## ↔️ HStack

```swift
HStack {
    RoundedRectangle(cornerRadius: 10).fill(.yellow).frame(width: 100, height: 100)
    Spacer()
    RoundedRectangle(cornerRadius: 10).fill(.yellow).frame(width: 100, height: 100)
}
```

- Stacks children **left → right**
- Default spacing is system-defined (~8pt) unless specified
- The `Spacer()` between the two rectangles pushes them to **opposite edges**

### Stack Types — Quick Recap

| Stack | Direction | Alignment Parameter Controls |
|---|---|---|
| `VStack` | Top → Bottom | Horizontal (leading/center/trailing) |
| `HStack` | Left → Right | Vertical (top/center/bottom) |
| `ZStack` | Back → Front | Both axes |

---

## 🔲 Spacer

```swift
// Inside VStack — pushes views apart vertically
VStack {
    BlueRect()
    Spacer()   // ← expands to fill remaining vertical space
    GreenRect()
}

// Inside HStack — pushes views apart horizontally
HStack {
    YellowRect()
    Spacer()   // ← expands to fill remaining horizontal space
    YellowRect()
}
```

- `Spacer()` expands to **consume all available space** in the stack's direction
- Creates **maximum distance** between neighboring views
- Multiple spacers split the available space equally

### Spacer vs spacing

| Tool | Controls | Use When |
|---|---|---|
| `spacing: 10` on Stack | Fixed gap between ALL children | Uniform gaps |
| `Spacer()` between views | Flexible gap between TWO views | Push views to edges |
| `.padding()` on a view | Space around ONE view | Inset a single view |

```swift
// Fixed spacing — all gaps equal
VStack(spacing: 20) { A; B; C }       // A──20──B──20──C

// Spacer — flexible gap
VStack { A; Spacer(); B; C }          // A────────────B──C
```

---

## 🔑 Key Concept — VStack alignment vs frame alignment

These two `.leading` values do **different things**:

```swift
// VStack alignment — aligns children relative to each other
VStack(alignment: .leading) {
    Wide300View()   // 300pt wide
    Narrow200View() // 200pt wide — left-aligned under the 300pt view
}

// frame alignment — aligns content WITHIN a fixed frame
.frame(width: 300, height: 100, alignment: .center)
// The shape fills the frame anyway — alignment only matters when content is smaller
```

> 💡 The `alignment: .center` inside each `.frame()` here has **no visual effect**
> because `RoundedRectangle` always fills its frame completely.
> It would matter for a `Text` or `Image` inside a larger frame.

---

## 🔲 Padding

```swift
.padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
```

### EdgeInsets — Explicit Control

| Side | Value | Maps To |
|---|---|---|
| `top` | `16` | Space above content |
| `leading` | `16` | Space on the left |
| `bottom` | `16` | Space below content |
| `trailing` | `16` | Space on the right |

### Padding Shorthand Options

```swift
// All sides equal ← same result as EdgeInsets(16,16,16,16)
.padding(16)
.padding(.all, 16)

// Specific sides
.padding(.horizontal, 16)          // leading + trailing
.padding(.vertical, 16)            // top + bottom
.padding(.top, 16)                 // top only

// System default (~16pt, adapts to device)
.padding()

// Explicit EdgeInsets — full control ← current
.padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
```

> 💡 Use `leading`/`trailing` instead of `left`/`right` —  
> they **flip automatically** for Right-to-Left languages like Arabic.

---

## ✅ Layout Summary — This View

```
VStack (alignment: .leading, spacing: 10)
│
├── RoundedRectangle (blue,  300×100)   ← widest, sets left edge reference
│
├── Spacer()                            ← pushes green block down
│
├── RoundedRectangle (green, 200×100)   ← left-aligned under the blue block
│
└── HStack
    ├── RoundedRectangle (yellow, 100×100)  ← left edge
    ├── Spacer()                            ← fills middle
    └── RoundedRectangle (yellow, 100×100)  ← right edge
│
.padding(16 all sides)                  ← wraps entire VStack
```

---

## 💡 Real-World Pattern — Card Layout

```swift
VStack(alignment: .leading, spacing: 8) {
    Text("Title")
        .font(.headline)

    Text("Subtitle goes here")
        .font(.subheadline)
        .foregroundStyle(.secondary)

    Spacer()

    HStack {
        Text("Left label")
        Spacer()
        Text("Right value")
            .foregroundStyle(.blue)
    }
}
.padding(16)
.background(
    RoundedRectangle(cornerRadius: 16, style: .continuous)
        .fill(.white)
        .shadow(radius: 4)
)
```

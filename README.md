# SwiftUI HStack & ForEach — Property Highlights

A beginner-friendly breakdown of `HStack`, nested `VStack`, `ForEach`, and how `Circle` behaves inside constrained frames.

---

## 📄 Code Overview

```swift
import SwiftUI

struct SwiftUIViewHStack: View {
    var body: some View {
        HStack(alignment: .center, spacing: 10) {

            // Column of 3 circles via ForEach
            VStack(spacing: 50) {
                ForEach(1...3, id: \.self) { _ in
                    Circle()
                        .fill(.blue)
                        .frame(width: 50, height: 25)
                }
            }

            // Large circle
            Circle()
                .fill(.blue)
                .frame(width: 200, height: 200)

            Spacer()

            // Medium squished circle
            Circle()
                .fill(.blue)
                .frame(width: 100, height: 50)

            // Small squished circle
            Circle()
                .fill(.blue)
                .frame(width: 50, height: 25)
        }
    }
}
```

---

## 📦 HStack Parameters

```swift
HStack(
    alignment: .center,
    spacing: 10
) { ... }
```

| Parameter | Value | Description |
|---|---|---|
| `alignment` | `.center` | Children align to the **vertical center** |
| `spacing` | `10` | Fixed gap between each direct child |

### HStack Alignment Options

| Value | Children Align To |
|---|---|
| `.top` | Top edge of the tallest child |
| `.center` | Vertical center ← current |
| `.bottom` | Bottom edge of the tallest child |
| `.firstTextBaseline` | First text baseline across children |
| `.lastTextBaseline` | Last text baseline across children |

---

## 🔁 ForEach

```swift
ForEach(1...3, id: \.self) { _ in
    Circle()
        .fill(.blue)
        .frame(width: 50, height: 25)
}
```

### Anatomy

| Part | Value | Description |
|---|---|---|
| `1...3` | Range | Generates 3 iterations (1, 2, 3) |
| `id: \.self` | Key path | Uses the value itself as the unique identifier |
| `{ _ in }` | Closure | `_` discards the index — value not needed |

### id: \.self — When to Use It

```swift
// \.self — value IS the identifier (safe for simple ranges & strings)
ForEach(1...3, id: \.self) { _ in ... }
ForEach(["A","B","C"], id: \.self) { item in ... }

// \.id — preferred for custom model types
ForEach(items, id: \.id) { item in ... }

// Identifiable — cleanest for data models
ForEach(items) { item in ... }  // item conforms to Identifiable
```

> 💡 `id: \.self` works fine for primitive ranges and strings.  
> For real data models, conform to `Identifiable` instead.

### ForEach vs Loop

```swift
// ❌ Regular Swift loop — does NOT work in SwiftUI body
for i in 1...3 {
    Circle()  // compiler error
}

// ✅ ForEach — SwiftUI's view-builder compatible loop
ForEach(1...3, id: \.self) { _ in
    Circle()
}
```

---

## ⭕ Key Concept — Circle in a Non-Square Frame

This file demonstrates something subtle and important:

```swift
// Perfect circle — equal width and height
Circle().frame(width: 200, height: 200)  // ← draws a circle

// Squished circle — unequal frame
Circle().frame(width: 50, height: 25)    // ← draws an ELLIPSE shape
Circle().frame(width: 100, height: 50)   // ← draws an ELLIPSE shape
```

> ⚠️ `Circle()` always draws a **perfect circle** that fits inside its frame.  
> In a non-square frame, it fits the **smaller dimension** — leaving empty space on the longer side.  
> The result looks like an ellipse but is technically a circle constrained by its frame.

```
frame(width: 50, height: 25)

┌──────────────────────────┐  height: 25
│        ╭──────╮          │
│        │  ●   │          │  ← circle fits height (25pt diameter)
│        ╰──────╯          │    empty space left & right
└──────────────────────────┘  width: 50

If you want a true oval → use Ellipse() instead of Circle()
```

---

## 🔗 Nested Stacks — VStack inside HStack

```swift
HStack {                          // horizontal container
    VStack(spacing: 50) {         // vertical column inside HStack
        ForEach(1...3, ...) {
            Circle()...           // 3 circles stacked vertically
        }
    }
    Circle()...                   // sits next to the VStack
    Spacer()
    Circle()...
    Circle()...
}
```

### Layout Tree

```
HStack
├── VStack
│   ├── Circle (50×25)
│   ├── Circle (50×25)
│   └── Circle (50×25)
├── Circle (200×200)   ← tallest — sets HStack height
├── Spacer()           ← pushes right group to trailing edge
├── Circle (100×50)
└── Circle (50×25)
```

> 💡 The **tallest child** determines the HStack's height.  
> Here the `200×200` circle sets the height — all other children center within it.

---

## 🔲 Spacer Inside HStack

```swift
HStack {
    LeftGroup()
    Spacer()        // ← pushes everything after it to the right
    RightGroup()
}
```

- Expands horizontally to fill remaining space
- Creates a **left-right split** layout — a very common real-world pattern

---

## ✅ Modifier Summary

| Modifier | Applied To | Purpose |
|---|---|---|
| `alignment: .center` | HStack | Vertically centers all children |
| `spacing: 10` | HStack | 10pt gap between direct children |
| `spacing: 50` | VStack | 50pt gap between ForEach circles |
| `ForEach(1...3, id: \.self)` | VStack | Repeats a view 3 times |
| `{ _ in }` | ForEach | Discards unused index value |
| `.fill(.blue)` | Circle | Solid blue fill |
| `.frame(width:height:)` | Circle | Constrains size — non-square = oval appearance |
| `Spacer()` | HStack | Pushes trailing views to the right edge |

---

## 💡 Real-World Pattern — Profile Row

```swift
HStack(alignment: .center, spacing: 12) {

    // Avatar
    Circle()
        .fill(.gray.opacity(0.3))
        .frame(width: 48, height: 48)
        .overlay(
            Text("M")
                .font(.headline)
                .foregroundStyle(.white)
        )

    // Name + subtitle
    VStack(alignment: .leading, spacing: 4) {
        Text("Moaz")
            .font(.headline)
        Text("iOS Developer")
            .font(.subheadline)
            .foregroundStyle(.secondary)
    }

    Spacer()

    // Action button
    Image(systemName: "chevron.right")
        .foregroundStyle(.secondary)
}
.padding(16)
```

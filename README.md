# SwiftUI LazyHGrid — Property Highlights

A beginner-friendly breakdown of `LazyHGrid`, horizontal grid layout, and mixed `GridItem` sizing.

---

## 📄 Code Overview

```swift
import SwiftUI

struct SwiftUIViewLazyHGrid: View {
    let rows = [
        GridItem(.fixed(80)),
        GridItem(.fixed(80)),
        GridItem(.fixed(80)),
        GridItem(.flexible(minimum: 80, maximum: 160)),  // ← mixed sizing
    ]

    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows) {
                ForEach(0..<100) { index in
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.linearGradient(
                            colors: [.blue, .purple],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .frame(width: 100)
                }
            }
        }
        .padding(.leading)
    }
}
```

---

## 🔲 LazyHGrid vs LazyVGrid

```swift
// Vertical grid — scrolls top → bottom, defines COLUMNS
LazyVGrid(columns: [GridItem, GridItem, GridItem]) { }

// Horizontal grid — scrolls left → right, defines ROWS ← current
LazyHGrid(rows: [GridItem, GridItem, GridItem]) { }
```

| Property | `LazyVGrid` | `LazyHGrid` |
|---|---|---|
| Scroll direction | Vertical ↕ | Horizontal ↔ |
| Array defines | Columns | Rows |
| Stack companion | `VStack` | `HStack` |
| ScrollView axis | `.vertical` | `.horizontal` ← current |
| Item sizing | Fixed **height** on items | Fixed **width** on items |

> 💡 The mental model flip:
> - `LazyVGrid` → you define **columns**, rows grow downward automatically
> - `LazyHGrid` → you define **rows**, columns grow rightward automatically

---

## 📐 Row Definition — Mixed Sizing

```swift
let rows = [
    GridItem(.fixed(80)),                              // row 1 — always 80pt tall
    GridItem(.fixed(80)),                              // row 2 — always 80pt tall
    GridItem(.fixed(80)),                              // row 3 — always 80pt tall
    GridItem(.flexible(minimum: 80, maximum: 160)),    // row 4 — flexible height
]
```

4 items in the array = **4 rows** in the grid.

### Row Heights Visualized

```
┌─────────────────────────────────────────────► scroll
│ ┌──────┬──────┬──────┬──────┐
│ │  80  │  80  │  80  │  80  │  ← row 1 (fixed 80pt)
│ ├──────┼──────┼──────┼──────┤
│ │  80  │  80  │  80  │  80  │  ← row 2 (fixed 80pt)
│ ├──────┼──────┼──────┼──────┤
│ │  80  │  80  │  80  │  80  │  ← row 3 (fixed 80pt)
│ ├──────┼──────┼──────┼──────┤
│ │ flex │ flex │ flex │ flex │  ← row 4 (flexible 80–160pt)
│ └──────┴──────┴──────┴──────┘
```

---

## 🔑 Key Concept — Mixed GridItem Sizes

This file is the first to combine **both** `.fixed` and `.flexible` in the same grid:

```swift
// Rows 1–3 — fixed
GridItem(.fixed(80))
// Always exactly 80pt tall — never changes regardless of available space

// Row 4 — flexible
GridItem(.flexible(minimum: 80, maximum: 160))
// At least 80pt, at most 160pt — fills remaining space between those bounds
```

### Why Mix Them?

```
Total available height = 390pt (example)
3 × fixed(80) = 240pt used
Remaining = 390 - 240 = 150pt → flexible row gets 150pt (within 80–160 range ✅)

If remaining = 60pt → flexible row gets 80pt (minimum enforced)
If remaining = 200pt → flexible row gets 160pt (maximum enforced)
```

> 💡 Mixing fixed and flexible rows is useful when you want most rows
> to be a consistent size but the last row to **absorb remaining space**
> — common in dashboard and card strip layouts.

---

## 📦 Item Sizing in LazyHGrid

```swift
RoundedRectangle(cornerRadius: 16)
    .frame(width: 100)    // ← only WIDTH set, no height
```

- In `LazyHGrid`, **height is controlled by the row definition**
- Width is set on the item itself — determines how far each column extends
- Each item fills the row's height automatically

```
GridItem(.fixed(80))  +  .frame(width: 100)
        ↑                       ↑
   controls height          controls width
   (set by row)             (set by item)
```

> ⚠️ In `LazyVGrid` it's the opposite:
> width = controlled by column definition, height = set on the item.

---

## 🌈 .linearGradient Shorthand on Fill

```swift
.fill(.linearGradient(
    colors: [.blue, .purple],
    startPoint: .topLeading,
    endPoint: .bottomTrailing
))
```

- Uses the **ShapeStyle dot syntax** shorthand
- `topLeading → bottomTrailing` = **diagonal gradient**
- Applied to every cell — creates a consistent visual theme across the grid

---

## ↔️ ScrollView(.horizontal) + LazyHGrid

```swift
ScrollView(.horizontal) {
    LazyHGrid(rows: rows) {
        ForEach(0..<100) { index in ... }
    }
}
.padding(.leading)
```

- `ScrollView(.horizontal)` scrolls **left → right**
- `LazyHGrid` expands **horizontally** as columns are added
- `.padding(.leading)` adds space at the left edge only — content starts inset

### padding(.leading) vs .padding()

```swift
.padding(.leading)   // left side only — leading gap before first column
.padding()           // all sides — gaps on all 4 edges
.padding(.horizontal) // left + right only
```

---

## 🆚 LazyVGrid vs LazyHGrid — Full Comparison

| | `LazyVGrid` | `LazyHGrid` |
|---|---|---|
| Defines | Columns | Rows |
| Grows toward | Bottom ↓ | Right → |
| ScrollView | `.vertical` | `.horizontal` |
| Item: set | Height | Width |
| GridItem: controls | Width | Height |
| Use case | Feed, photo grid, calendar | Carousel, tag strips, filters |

---

## ✅ Modifier Summary

| Element | Purpose |
|---|---|
| `LazyHGrid(rows:)` | Horizontal grid — rows scroll right |
| `GridItem(.fixed(80))` | Row always exactly 80pt tall |
| `GridItem(.flexible(minimum:maximum:))` | Row fills remaining space within bounds |
| `ScrollView(.horizontal)` | Enables left-right scrolling |
| `.frame(width: 100)` | Sets each cell's width (height comes from row) |
| `.padding(.leading)` | Insets content from the left edge only |
| `.fill(.linearGradient(...))` | Diagonal gradient fill on each cell |

---

## 💡 Real-World Patterns

### Horizontal Tag / Filter Strip
```swift
let rows = [GridItem(.fixed(44))]  // single row strip

ScrollView(.horizontal, showsIndicators: false) {
    LazyHGrid(rows: rows, spacing: 8) {
        ForEach(filters) { filter in
            Text(filter.name)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    Capsule().fill(filter.isSelected ? .blue : .gray.opacity(0.2))
                )
                .foregroundStyle(filter.isSelected ? .white : .primary)
                .onTapGesture { filter.toggle() }
        }
    }
    .padding(.horizontal)
}
```

### App Store — Multi-Row Horizontal Card Grid
```swift
let rows = [
    GridItem(.fixed(120)),
    GridItem(.fixed(120)),
    GridItem(.fixed(120)),
]

ScrollView(.horizontal, showsIndicators: false) {
    LazyHGrid(rows: rows, spacing: 16) {
        ForEach(apps) { app in
            AppRowCard(app: app)
                .frame(width: 280)
        }
    }
    .padding(.horizontal)
}
```

### Mixed Row Dashboard
```swift
let rows = [
    GridItem(.fixed(60)),                           // compact row
    GridItem(.fixed(60)),                           // compact row
    GridItem(.flexible(minimum: 60, maximum: 120)), // expanding row
]

ScrollView(.horizontal) {
    LazyHGrid(rows: rows, spacing: 12) {
        ForEach(metrics) { metric in
            MetricCard(metric: metric)
                .frame(width: 140)
        }
    }
    .padding()
}
```

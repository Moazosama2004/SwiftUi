# SwiftUI LazyVGrid — Property Highlights

A beginner-friendly breakdown of `LazyVGrid`, `GridItem`, `Section`, and pinned headers in SwiftUI.

---

## 📄 Code Overview

```swift
import SwiftUI

struct SwiftUIViewLazyHStack: View {
    let columns: [GridItem] = [
        GridItem(.fixed(100)),
        GridItem(.fixed(100)),
        GridItem(.fixed(100)),
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, pinnedViews: .sectionHeaders) {

                Section {
                    ForEach(1..<32) { index in
                        RoundedRectangle(cornerRadius: 25)
                            .fill(.blue)
                            .frame(height: 100)
                            .overlay {
                                Text("\(index)").foregroundStyle(.white).font(.title)
                            }
                    }
                } header: {
                    Text("Jan")
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity)
                        .background(.red)
                }

                Section {
                    ForEach(1..<32) { index in ... }
                } header: {
                    Text("Feb").font(.largeTitle).frame(height: 100)
                }
            }
        }
        .padding()
    }
}
```

---

## 🔲 LazyVGrid

```swift
LazyVGrid(
    columns: columns,
    pinnedViews: .sectionHeaders
) { ... }
```

- Arranges children in a **vertical grid** — rows flow top to bottom
- Column count and sizing defined by the `columns` array
- **Lazy** — only renders visible cells, same as `LazyVStack`
- Must be inside a `ScrollView` to scroll

| Parameter | Value | Description |
|---|---|---|
| `columns` | `[GridItem]` | Defines column count and sizing |
| `alignment` | `.center` (default) | Horizontal alignment within each cell |
| `spacing` | system default | Vertical gap between rows |
| `pinnedViews` | `.sectionHeaders` | Pins section headers while scrolling |

---

## 🧱 GridItem — Column Definition

```swift
let columns: [GridItem] = [
    GridItem(.fixed(100)),
    GridItem(.fixed(100)),
    GridItem(.fixed(100)),
]
```

Each `GridItem` in the array = **one column**.  
3 items in the array = 3 columns in the grid.

### GridItem Parameters

```swift
GridItem(
    _ size: GridItem.Size,   // how wide the column is
    spacing: CGFloat?,       // gap between this column and the next
    alignment: Alignment?    // content alignment within the column
)
```

---

## 📏 GridItem.Size — Three Types

### 1. .fixed() ← current
```swift
GridItem(.fixed(100))
```
- Column is always exactly **100pt wide** — never grows or shrinks
- Predictable, pixel-precise layout
- Use for: calendars, icon grids, fixed-size tiles

```
Screen: 390pt wide
3 × fixed(100) = 300pt columns + remaining space unused
┌────────┬────────┬────────┐
│ 100pt  │ 100pt  │ 100pt  │
│        │        │        │
└────────┴────────┴────────┘
```

---

### 2. .flexible() ← commented out
```swift
GridItem(.flexible())
GridItem(.flexible())
GridItem(.flexible())
```
- Each column takes an **equal share** of available width
- Automatically adapts to any screen size
- Use for: responsive grids, equal-width layouts

```
Screen: 390pt wide, 3 flexible columns
390 ÷ 3 = 130pt each (minus spacing)
┌──────────┬──────────┬──────────┐
│  ~130pt  │  ~130pt  │  ~130pt  │
│          │          │          │
└──────────┴──────────┴──────────┘
```

---

### 3. .adaptive() ← commented out
```swift
GridItem(.adaptive(minimum: 50, maximum: 100))
```
- SwiftUI **automatically decides** how many columns fit
- Fits as many columns as possible within the `minimum`–`maximum` range
- Use for: dynamic grids where column count depends on available space

```
Screen: 390pt wide
adaptive(min: 50, max: 100) → fits ~5 columns at ~78pt each
┌──────┬──────┬──────┬──────┬──────┐
│ ~78  │ ~78  │ ~78  │ ~78  │ ~78  │
└──────┴──────┴──────┴──────┴──────┘
```

---

### All Three Compared

| Size | Column Count | Width | Use When |
|---|---|---|---|
| `.fixed(100)` | You define (array length) | Always exact | Calendars, icon grids ← current |
| `.flexible()` | You define (array length) | Fills available space | Responsive equal grids |
| `.adaptive(min:max:)` | SwiftUI decides | Fits as many as possible | Dynamic, device-adaptive |

---

## ♻️ Array(repeating:count:) — Shorthand

```swift
// Verbose — current approach
let columns: [GridItem] = [
    GridItem(.fixed(100)),
    GridItem(.fixed(100)),
    GridItem(.fixed(100)),
]

// Compact — identical result, commented out
let columns = Array(repeating: GridItem(.fixed(100)), count: 3)
```

> 💡 Use `Array(repeating:count:)` when all columns are identical —
> much cleaner when you have 4, 5, or 6 identical columns.

---

## 📂 Section

```swift
Section {
    ForEach(1..<32) { index in
        // grid cells
    }
} header: {
    Text("Jan")
        .frame(maxWidth: .infinity)
        .background(.red)
}
```

- Groups grid cells under a **named header**
- `header:` view spans the **full grid width** — not one cell
- Works identically to `Section` in `List`

### Jan vs Feb Header — Spot the Difference

```swift
// Jan — pinned, full-width background
header: {
    Text("Jan")
        .frame(maxWidth: .infinity)   // ← stretches across all columns
        .background(.red)              // ← visible background for pinning
        .padding()
}

// Feb — not pinned-friendly, no background
header: {
    Text("Feb")
        .frame(height: 100)           // ← fixed height only, no maxWidth
                                       // ← no background — transparent when pinned
}
```

> ⚠️ For `pinnedViews: .sectionHeaders` to look correct, headers need
> `.frame(maxWidth: .infinity)` and a solid `.background()` —
> otherwise content scrolls **behind the transparent header**.

---

## 📌 pinnedViews: .sectionHeaders

```swift
LazyVGrid(columns: columns, pinnedViews: .sectionHeaders) { ... }
```

- Section headers **stick to the top** as you scroll past them
- Works the same as sticky headers in `UICollectionView` or contacts app
- Requires headers to have a **solid background** to cover content beneath

| Value | Behavior |
|---|---|
| `[]` | Nothing pinned (default) |
| `.sectionHeaders` | Headers stick to top while scrolling ← current |
| `.sectionFooters` | Footers stick to bottom while scrolling |
| `[.sectionHeaders, .sectionFooters]` | Both pinned |

---

## 🗓️ Calendar Grid — Why This Pattern

This file is a classic **calendar layout**:

```
┌─────────────────────────┐
│ Jan          (pinned)   │  ← Section header, sticks to top
├───────┬───────┬─────────┤
│   1   │   2   │    3    │
│   4   │   5   │    6    │
│  ...  │  ...  │   ...   │
│  31   │       │         │
├─────────────────────────┤
│ Feb          (pinned)   │  ← Next section header takes over
├───────┬───────┬─────────┤
│   1   │   2   │    3    │
│  ...  │  ...  │   ...   │
└───────┴───────┴─────────┘
```

3 columns of fixed(100) → 3-column day grid per row.  
`Section` per month → header shows month name.  
`pinnedViews: .sectionHeaders` → month name sticks as you scroll days.

---

## ✅ Modifier Summary

| Element | Purpose |
|---|---|
| `LazyVGrid(columns:)` | Vertical lazy grid with defined columns |
| `GridItem(.fixed(100))` | Column exactly 100pt wide |
| `GridItem(.flexible())` | Column shares available width equally |
| `GridItem(.adaptive(min:max:))` | SwiftUI decides column count |
| `Array(repeating:count:)` | Shorthand for identical column arrays |
| `Section { } header: { }` | Groups cells under a named header |
| `pinnedViews: .sectionHeaders` | Sticks section headers while scrolling |
| `.frame(maxWidth: .infinity)` | Stretches header across all columns |
| `.background(.red)` | Covers content scrolling behind header |

---

## 💡 Real-World Patterns

### Photo Grid (Instagram style)
```swift
let columns = Array(
    repeating: GridItem(.flexible(), spacing: 2),
    count: 3
)

ScrollView {
    LazyVGrid(columns: columns, spacing: 2) {
        ForEach(photos) { photo in
            AsyncImage(url: photo.url) { phase in
                switch phase {
                case .success(let image):
                    image.resizable().scaledToFill()
                default:
                    Rectangle().fill(.gray.opacity(0.2))
                }
            }
            .frame(height: UIScreen.main.bounds.width / 3)
            .clipped()
        }
    }
}
```

### Adaptive Icon Grid
```swift
let columns = [
    GridItem(.adaptive(minimum: 80, maximum: 120))
]

ScrollView {
    LazyVGrid(columns: columns, spacing: 16) {
        ForEach(apps) { app in
            AppIconView(app: app)
                .frame(height: 100)
        }
    }
    .padding()
}
```

### Full Calendar
```swift
let columns = Array(repeating: GridItem(.flexible()), count: 7)

LazyVGrid(columns: columns, pinnedViews: .sectionHeaders) {
    ForEach(months) { month in
        Section {
            ForEach(month.days) { day in
                DayCell(day: day)
            }
        } header: {
            Text(month.name)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .background(.white)
        }
    }
}
```

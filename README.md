# SwiftUI LazyVStack — Property Highlights

A beginner-friendly breakdown of `LazyVStack`, on-demand rendering, and how to prove lazy loading works.

---

## 📄 Code Overview

```swift
import SwiftUI

struct SwiftUIViewLazyStacks: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack {
                ForEach(0..<1000) { index in
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.blue)
                        .frame(height: 250)
                        .shadow(radius: 5)
                        .overlay {
                            Text("index: \(index)")
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .bold()
                        }
                        .onAppear {
                            print("Index: \(index)")  // ← proves lazy loading
                        }
                }
            }
            .padding()
        }
    }
}
```

---

## 🔑 Key Concept — Lazy vs Eager Rendering

This is the entire point of this file — understanding **when** views are created:

```swift
// Eager — ALL 1000 views created immediately on launch
ScrollView {
    VStack {
        ForEach(0..<1000) { index in
            HeavyView(index: index)   // ← all 1000 built at once
        }
    }
}

// Lazy — only VISIBLE views created, rest built on demand
ScrollView {
    LazyVStack {
        ForEach(0..<1000) { index in
            HeavyView(index: index)   // ← only ~5 built at launch
        }
    }
}
```

### What "Lazy" Means Visually

```
Screen shows items 0–4 (visible)
Items 5–999 don't exist in memory yet

User scrolls down ↓
    Item 5 enters screen → created now
    Item 0 exits screen  → may be destroyed

User scrolls further ↓
    Item 6, 7, 8... created as they appear
```

---

## 🧪 .onAppear as a Lazy Loading Proof

```swift
.onAppear {
    print("Index: \(index)")
}
```

This is the **smartest part of this file** — using `.onAppear` to prove lazy loading:

```
// VStack behavior — console output on launch:
Index: 0
Index: 1
Index: 2
... (all 1000 printed immediately)

// LazyVStack behavior — console output on launch:
Index: 0
Index: 1
Index: 2
Index: 3
Index: 4   ← only visible items

// As user scrolls:
Index: 5
Index: 6   ← printed only when that card appears on screen
```

> 💡 If you see all 1000 printed at launch → you're using `VStack` (eager).
> If you see only ~5 printed → you're using `LazyVStack` (lazy). ✅

---

## 📊 Performance Comparison — 1000 Items

| | `VStack` | `LazyVStack` |
|---|---|---|
| Views created at launch | 1000 | ~5 |
| Memory usage | High | Low |
| Launch time | Slow | Fast |
| Scroll performance | May lag | Smooth |
| `.onAppear` fires | All at once | As each appears |
| `.onDisappear` fires | None (all kept) | As each leaves |

---

## 🗂️ All Lazy Layout Types

```swift
// Vertical list ← this file
LazyVStack { }

// Horizontal list
LazyHStack { }

// Vertical grid
LazyVGrid(columns: [...]) { }

// Horizontal grid
LazyHGrid(rows: [...]) { }
```

| Type | Direction | Use For |
|---|---|---|
| `LazyVStack` | Top → Bottom | Long vertical lists |
| `LazyHStack` | Left → Right | Long horizontal carousels |
| `LazyVGrid` | Top → Bottom, multi-column | Photo grids, card grids |
| `LazyHGrid` | Left → Right, multi-row | Horizontal grid carousels |

> ⚠️ All lazy layouts **must be inside a ScrollView** —
> they have no built-in scrolling themselves.

---

## 📐 LazyVStack Parameters

```swift
LazyVStack(
    alignment: .center,    // horizontal alignment of children
    spacing: 10,           // gap between items
    pinnedViews: [.sectionHeaders]  // pin headers while scrolling
) { }
```

| Parameter | Default | Description |
|---|---|---|
| `alignment` | `.center` | Horizontal child alignment |
| `spacing` | system default | Gap between items |
| `pinnedViews` | `[]` | Pin headers/footers while scrolling |

### Pinned Section Headers

```swift
LazyVStack(pinnedViews: [.sectionHeaders]) {
    Section(header:
        Text("Today")
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(.white)    // ← needed to cover content behind
    ) {
        ForEach(todayItems) { item in
            ItemRow(item: item)
        }
    }
}
```

> 💡 `pinnedViews: [.sectionHeaders]` makes headers **stick to the top**
> as you scroll past them — like contacts app section letters.

---

## 🔢 ForEach with Large Range

```swift
ForEach(0..<1000) { index in ... }
```

- `0..<1000` is a **compile-time fixed range** — no `id:` needed
- SwiftUI uses the index as the implicit identifier
- With `LazyVStack`, only visible indices are instantiated

> ⚠️ For dynamic data (array that can change), use `Identifiable` models
> instead of a fixed range — range-based `ForEach` can't handle inserts/deletes.

---

## ✅ When to Use Lazy vs Eager

```swift
// Use VStack (eager) when:
// - Less than ~20 items
// - Items are simple and lightweight
// - You need all items in memory (e.g., for animation coordination)
VStack {
    ForEach(0..<5) { _ in SimpleRow() }
}

// Use LazyVStack (lazy) when:
// - 20+ items
// - Items load data (images, network calls)
// - Items are complex or heavyweight
LazyVStack {
    ForEach(0..<1000) { _ in ComplexCard() }
}
```

| Item Count | Recommendation |
|---|---|
| < 20 | `VStack` — simpler, no lazy overhead |
| 20–100 | Either — `LazyVStack` preferred |
| 100+ | `LazyVStack` — essential |
| 1000+ | `LazyVStack` — mandatory |

---

## ✅ Modifier Summary

| Element | Purpose |
|---|---|
| `ScrollView(.vertical, showsIndicators: false)` | Vertical scroll container, no indicator bar |
| `LazyVStack` | Renders children only when about to appear |
| `ForEach(0..<1000)` | Generates 1000 index values |
| `.onAppear { print(...) }` | Proves which items have been rendered |
| `.padding()` on `LazyVStack` | Insets the entire content block |

---

## 💡 Real-World Pattern — Instagram Feed

```swift
struct FeedView: View {
    @State private var posts: [Post] = []

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 0) {
                ForEach(posts) { post in
                    PostCard(post: post)
                        .onAppear {
                            // load more when near the bottom
                            if post.id == posts.last?.id {
                                loadMorePosts()
                            }
                        }
                }
            }
        }
        .task { await loadInitialPosts() }
    }

    func loadMorePosts() { /* fetch next page */ }
    func loadInitialPosts() async { /* fetch first page */ }
}
```

> 💡 The `.onAppear` on the **last item** is the standard pattern
> for **infinite scroll / pagination** — trigger the next page load
> when the user reaches the bottom of the current list.

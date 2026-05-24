# SwiftUI ScrollView — Property Highlights

A beginner-friendly breakdown of every ScrollView pattern, direction, nesting, and programmatic scrolling in SwiftUI.

---

## 📄 Code Overview

```swift
import SwiftUI

struct SwiftUIViewScrollView: View {
    @State private var selectedPosition: Int? = nil

    var body: some View {
        VStack {
            Button { selectedPosition = 5 } label: { Text("ScrollTo") }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<10) { index in
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.blue)
                            .padding()
                            .frame(width: 300, height: 250)
                            .shadow(radius: 10)
                            .overlay {
                                Text("Index: \(index)")
                                    .font(.title).bold().foregroundColor(.white)
                            }
                            .id(index)          // ← required for programmatic scroll
                    }
                }
            }
        }
    }
}
```

---

## 📜 ScrollView — Basic Anatomy

```swift
ScrollView(.horizontal, showsIndicators: false) {
    HStack { ... }   // ← content must be in a Stack
}
```

| Parameter | Value | Description |
|---|---|---|
| `axes` | `.vertical` / `.horizontal` / `[.vertical, .horizontal]` | Scroll direction(s) |
| `showsIndicators` | `true` / `false` | Show or hide scroll bar |

> 💡 `ScrollView` itself has **no intrinsic size** — it takes available space.
> The content inside (VStack/HStack) determines scroll length.

---

## 🔄 All Scroll Directions

### Vertical ← most common
```swift
ScrollView(.vertical, showsIndicators: false) {
    VStack {
        ForEach(0..<10) { index in
            RoundedRectangle(cornerRadius: 16)
                .fill(.blue)
                .padding()
                .frame(height: 250)
        }
    }
}
```
- Scrolls **top → bottom**
- Content stack: `VStack`
- Cards need a fixed **height**, width fills screen

---

### Horizontal
```swift
ScrollView(.horizontal, showsIndicators: false) {
    HStack {
        ForEach(0..<10) { index in
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 300, height: 250)
        }
    }
}
```
- Scrolls **left → right**
- Content stack: `HStack`
- Cards need a fixed **width** — height fills available space

---

### Both Axes
```swift
ScrollView([.vertical, .horizontal], showsIndicators: false) {
    VStack {
        ForEach(0..<10) { _ in
            HStack {
                ForEach(0..<10) { index in
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 300, height: 250)
                }
            }
        }
    }
}
```
- Scrolls in **both directions** — like a spreadsheet or map
- Outer: `VStack` for rows, inner: `HStack` for columns

---

### Nested ScrollViews ← most common real-world pattern
```swift
ScrollView(.vertical) {                          // outer: vertical
    VStack {
        ForEach(0..<10) { _ in
            ScrollView(.horizontal) {            // inner: horizontal
                HStack {
                    ForEach(0..<10) { index in
                        RoundedRectangle(cornerRadius: 16)
                            .frame(width: 300, height: 250)
                    }
                }
            }
        }
    }
}
```
- Each row scrolls **horizontally independently**
- The page scrolls **vertically** between rows
- This is the **Netflix / App Store** layout pattern

---

## 🆔 .id() — Required for Programmatic Scrolling

```swift
RoundedRectangle(cornerRadius: 16)
    .frame(width: 300, height: 250)
    .id(index)   // ← tags each card with its index number
```

- Assigns a **unique identifier** to each view in the scroll
- Required for `ScrollViewReader` to find and scroll to it
- Can be any `Hashable` type: `Int`, `String`, `UUID`

---

## 📍 Programmatic Scrolling — ScrollViewReader

```swift
@State private var selectedPosition: Int? = nil

VStack {
    Button { selectedPosition = 5 } label: { Text("ScrollTo") }

    ScrollViewReader { proxy in                    // ← gives access to scroll API
        ScrollView(.horizontal) {
            HStack {
                ForEach(0..<10) { index in
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 300, height: 250)
                        .id(index)                 // ← tag each item
                }
            }
        }
        .onChange(of: selectedPosition) { newValue in
            if let position = newValue {
                withAnimation {
                    proxy.scrollTo(position, anchor: .center)  // ← scroll to it
                }
            }
        }
    }
}
```

### ScrollViewReader API

| Method | Description |
|---|---|
| `proxy.scrollTo(id)` | Scrolls to the view with matching `.id()` |
| `proxy.scrollTo(id, anchor:)` | Scrolls with alignment control |

### anchor Options

| Value | Positions Target At |
|---|---|
| `.leading` | Left edge of scroll view |
| `.center` | Center of scroll view ← most common |
| `.trailing` | Right edge |
| `.top` | Top of scroll view |
| `.bottom` | Bottom of scroll view |

---

## 🎯 Scroll Behavior Modifiers — iOS 17+

```swift
// Commented out in this file — modern snap/paging API
ScrollView(.horizontal) {
    HStack { ... }
        .scrollTargetLayout()              // marks items as scroll targets
}
.scrollTargetBehavior(.viewAligned)        // snaps to each item
.scrollPosition(id: $selectedPosition)    // two-way binding for position
```

| Modifier | Purpose |
|---|---|
| `.scrollTargetLayout()` | Marks the layout as containing scroll targets |
| `.scrollTargetBehavior(.viewAligned)` | Snaps scroll to each item |
| `.scrollTargetBehavior(.paging)` | Snaps to full pages |
| `.scrollPosition(id:)` | Reads and writes current scroll position |

---

## 🔑 Key Concept — ScrollView vs List

| Feature | `ScrollView` + `ForEach` | `List` |
|---|---|---|
| Direction | Horizontal or Vertical | Vertical only |
| Row styling | ❌ Manual | ✅ Built-in |
| Swipe to delete | ❌ | ✅ `.onDelete` |
| Lazy loading | ❌ (use `LazyVStack`) | ✅ Built-in |
| Custom layouts | ✅ Full control | ⚠️ Limited |
| Horizontal scroll | ✅ | ❌ |

---

## ⚡ Performance — Lazy Stacks

Regular `VStack`/`HStack` renders **all views at once**:

```swift
// ❌ Renders all 1000 items immediately — memory heavy
ScrollView {
    VStack {
        ForEach(0..<1000) { index in
            HeavyCardView(index: index)
        }
    }
}

// ✅ Renders only visible items — use for large lists
ScrollView {
    LazyVStack {                    // ← "Lazy" prefix
        ForEach(0..<1000) { index in
            HeavyCardView(index: index)
        }
    }
}
```

| Stack | Renders | Use When |
|---|---|---|
| `VStack` / `HStack` | All items immediately | < 20 items |
| `LazyVStack` / `LazyHStack` | Only visible items | 20+ items |
| `LazyVGrid` / `LazyHGrid` | Only visible items | Grid layouts |

---

## ✅ Modifier Summary

| Modifier | Purpose |
|---|---|
| `ScrollView(.horizontal)` | Horizontal scroll container |
| `ScrollView(.vertical)` | Vertical scroll container |
| `ScrollView([.horizontal, .vertical])` | Both axes |
| `showsIndicators: false` | Hides scroll bar |
| `.id(index)` | Tags view for programmatic scrolling |
| `ScrollViewReader { proxy in }` | Gives access to `proxy.scrollTo()` |
| `proxy.scrollTo(id, anchor:)` | Programmatically scrolls to a view |
| `.scrollTargetLayout()` | iOS 17+ — marks scroll targets |
| `.scrollTargetBehavior(.viewAligned)` | iOS 17+ — snaps to items |

---

## 💡 Real-World Patterns

### Horizontal Card Carousel
```swift
ScrollView(.horizontal, showsIndicators: false) {
    HStack(spacing: 16) {
        ForEach(items) { item in
            CardView(item: item)
                .frame(width: 280, height: 180)
                .id(item.id)
        }
    }
    .padding(.horizontal, 20)
    .scrollTargetLayout()
}
.scrollTargetBehavior(.viewAligned)
```

### Chat — Auto-scroll to Latest Message
```swift
ScrollViewReader { proxy in
    ScrollView {
        LazyVStack {
            ForEach(messages) { message in
                MessageBubble(message: message)
                    .id(message.id)
            }
        }
    }
    .onChange(of: messages.count) { _ in
        withAnimation {
            proxy.scrollTo(messages.last?.id, anchor: .bottom)
        }
    }
}
```

### Netflix Row Layout
```swift
ScrollView(.vertical, showsIndicators: false) {
    LazyVStack(alignment: .leading, spacing: 24) {
        ForEach(categories) { category in
            Text(category.title).font(.headline).padding(.leading)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(category.items) { item in
                        ThumbnailView(item: item)
                            .frame(width: 140, height: 200)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
```

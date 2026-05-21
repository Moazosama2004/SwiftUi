# SwiftUI ZStack & Overlay — Property Highlights

A beginner-friendly breakdown of `ZStack`, `.overlay()`, `.background()`, and all three ways to layer views in SwiftUI.

---

## 📄 Code Overview

```swift
import SwiftUI

struct SwiftUIViewZStack: View {
    let url = URL(string: "https://picsum.photos/400")

    var body: some View {
        VStack(spacing: 24) {

            ZStack(alignment: .bottomLeading) {

                // Layer 1 — background: AsyncImage
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView().frame(width: 300, height: 300)

                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 300, height: 300)
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(.blue, lineWidth: 5)
                            )

                    case .failure(_):
                        Image(systemName: "photo.slash").foregroundStyle(.red)

                    @unknown default:
                        EmptyView()
                    }
                }

                // Layer 2 — foreground: online indicator dot
                Circle()
                    .fill(.green)
                    .frame(width: 50, height: 50)
                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 0))
            }

            Text("Moaz Osama")
                .font(.system(size: 32, weight: .regular, design: .rounded))
        }
    }
}
```

---

## 🗂️ ZStack — Layering Views

```swift
ZStack(alignment: .bottomLeading) {
    BottomView()   // rendered first → appears BEHIND
    TopView()      // rendered last  → appears IN FRONT
}
```

- Stacks children **front to back** — first child is furthest back
- All children share the **same origin point** by default
- Size is determined by the **largest child**

### ZStack Alignment

```swift
ZStack(alignment: .bottomLeading)
```

Controls where **smaller children** are positioned relative to the ZStack's bounds:

| Value | Position |
|---|---|
| `.center` | Dead center (default) |
| `.topLeading` | Top-left corner |
| `.topTrailing` | Top-right corner |
| `.bottomLeading` | Bottom-left corner ← current |
| `.bottomTrailing` | Bottom-right corner |
| `.top` / `.bottom` | Top or bottom, centered horizontally |
| `.leading` / `.trailing` | Left or right, centered vertically |

> 💡 Here `.bottomLeading` places the green dot at the **bottom-left** of the avatar —
> the classic "online indicator" position used by Instagram, WhatsApp, and iMessage.

---

## 🟢 Online Status Dot — Padding Trick

```swift
Circle()
    .fill(.green)
    .frame(width: 50, height: 50)
    .padding(EdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 0))
```

The dot is at `.bottomLeading` but needs a small inset to sit **on top of the avatar edge**
rather than at the very corner of the ZStack bounds:

| Edge | Value | Effect |
|---|---|---|
| `top` | `0` | No inset from top |
| `leading` | `5` | Push 5pt away from left edge |
| `bottom` | `5` | Push 5pt away from bottom edge |
| `trailing` | `0` | No inset from right |

---

## 🔵 .overlay() — Layering on Top of One View

```swift
image
    .clipShape(Circle())
    .overlay(
        Circle()
            .stroke(.blue, lineWidth: 5)
    )
```

- Places a view **directly on top** of its parent
- The overlay is **centered and sized to match** the parent by default
- Does **not affect layout** — the parent's frame is unchanged

### .stroke() inside .overlay()

```swift
.overlay(
    Circle().stroke(.blue, lineWidth: 5)
)
```

> 💡 This is the standard pattern for **bordered avatars**.
> You can't use `.stroke()` directly on a clipped image —
> overlaying a stroked shape draws the border on top perfectly.

---

## 🔑 Key Concept — Three Ways to Layer Views

The commented-out code demonstrates all three approaches side by side:

### Approach 1 — ZStack
```swift
ZStack(alignment: .center) {
    Circle().fill(.red).frame(width: 200, height: 200)
    Text("1").font(.system(size: 48, weight: .bold))
}
```
- Full control over alignment and positioning
- Both views participate equally in layout
- **Best for:** complex layering, multiple overlapping views

---

### Approach 2 — .overlay { }
```swift
Circle()
    .fill(.red)
    .frame(width: 200, height: 200)
    .overlay {
        Text("1").font(.system(size: 48, weight: .bold))
    }
```
- The **Circle drives the layout** — Text is placed on top
- Overlay is centered and matches parent bounds automatically
- **Best for:** decorating a specific view (badges, borders, labels)

---

### Approach 3 — .background { }
```swift
Text("1")
    .font(.system(size: 48, weight: .bold))
    .background {
        Circle().fill(.red).frame(width: 200, height: 200)
    }
```
- The **Text drives the layout** — Circle is placed behind
- Background is centered under the parent
- **Best for:** adding a shape behind text or a small view

---

### All Three Compared

| Approach | Layout Driver | Direction | Best For |
|---|---|---|---|
| `ZStack` | Largest child | Both | Complex multi-layer compositions |
| `.overlay {}` | Parent view | On top | Badges, borders, labels over a shape |
| `.background {}` | Parent view | Behind | Shape behind text or icon |

```
ZStack              .overlay {}         .background {}
┌─────────┐         ┌─────────┐         ┌─────────┐
│ ╭─────╮ │         │ ╭─────╮ │         │ ╭─────╮ │
│ │  1  │ │         │ │  1  │ │         │ │  1  │ │
│ ╰─────╯ │         │ ╰─────╯ │         │ ╰─────╯ │
└─────────┘         └─────────┘         └─────────┘
Both equal         Circle owns layout   Text owns layout
```

---

## ✅ Modifier Summary

| Modifier | Applied To | Purpose |
|---|---|---|
| `ZStack(alignment: .bottomLeading)` | Container | Layers views, aligns smaller children to bottom-left |
| `.clipShape(Circle())` | AsyncImage | Clips image to circular shape |
| `.overlay(Circle().stroke(...))` | Clipped image | Draws blue border ring on top |
| `.padding(EdgeInsets(...))` | Green dot | Insets dot away from ZStack corner |
| `alignment: .center` | HStack/VStack | Centers children on cross axis |

---

## 💡 Real-World Pattern — Full Avatar with Badge

```swift
ZStack(alignment: .bottomTrailing) {

    // Profile photo
    AsyncImage(url: url) { phase in
        switch phase {
        case .success(let image):
            image
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .overlay(Circle().stroke(.white, lineWidth: 3))
        default:
            Circle()
                .fill(.gray.opacity(0.3))
                .frame(width: 80, height: 80)
        }
    }

    // Online indicator
    Circle()
        .fill(.green)
        .frame(width: 20, height: 20)
        .overlay(Circle().stroke(.white, lineWidth: 2))
        .padding(4)
}
```

# SwiftUI Images — Property Highlights

A beginner-friendly breakdown of SF Symbols and custom images in SwiftUI, including rendering modes, resizing, and clipping.

---

## 📄 Code Overview

```swift
import SwiftUI

struct SwiftUIViewImages: View {
    var body: some View {
        VStack(spacing: 10) {

            // 1. SF Symbol (system icon)
            Image(systemName: "pencil.tip.crop.circle.badge.plus")
                .symbolRenderingMode(.palette)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
                .foregroundStyle(.blue, .yellow)

            // 2. Custom image from Assets
            Image("app-icon")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
                .clipShape(Circle())
                .clipped()
        }
    }
}
```

---

## 🖼️ Two Image Sources

| Initializer | Source | Example |
|---|---|---|
| `Image(systemName:)` | SF Symbols library (built-in Apple icons) | `"pencil.tip.crop.circle.badge.plus"` |
| `Image("name")` | Assets.xcassets in your project | `"app-icon"` |

> 💡 SF Symbols are vector-based — they scale perfectly at any size and support all SwiftUI color modifiers.  
> Browse all 6000+ symbols in the **SF Symbols app** (free from Apple).

---

## 📐 Resizing — Required Before .frame()

By default, `Image` renders at its **natural pixel size** and ignores `.frame()`.  
You must call `.resizable()` first to allow size changes:

```swift
// ❌ Frame is ignored — image stays its natural size
Image("app-icon")
    .frame(width: 300, height: 300)

// ✅ Image respects the frame
Image("app-icon")
    .resizable()
    .frame(width: 300, height: 300)
```

---

## ↔️ Content Mode — .aspectRatio() vs .scaledToFit/Fill

Two ways to control how an image fills its frame:

```swift
// Long form
.aspectRatio(contentMode: .fit)
.aspectRatio(contentMode: .fill)

// Short form (identical result)
.scaledToFit()   // ← used on custom image
.scaledToFill()  // ← commented out on SF Symbol
```

| Mode | Behavior | Risk |
|---|---|---|
| `.fit` | Scales image to fit **within** the frame, preserving aspect ratio | May leave empty space |
| `.fill` | Scales image to **fill** the frame, preserving aspect ratio | May overflow/crop |

```
.fit                        .fill
┌──────────────┐            ┌──────────────┐
│  ┌────────┐  │            │██████████████│
│  │ image  │  │     vs     │██████████████│
│  └────────┘  │            │██████████████│
└──────────────┘            └──────────────┘
 Empty space on sides        Overflows frame
```

> ⚠️ `.scaledToFill()` overflows its frame — always pair with `.clipped()` or `.clipShape()` to hide the overflow.

---

## ✂️ Clipping — .clipShape() vs .cornerRadius() vs .clipped()

Three ways to clip an image's visible area:

```swift
.clipShape(Circle())                          // ← active: clips to circle
.clipShape(RoundedRectangle(cornerRadius: 24)) // ← commented out
.cornerRadius(100)                             // ← commented out
.clipped()                                     // ← active: clips to frame bounds
```

| Modifier | Shape | Notes |
|---|---|---|
| `.clipShape(Circle())` | Circle | Clean, precise — preferred modern approach |
| `.clipShape(RoundedRectangle(cornerRadius:))` | Rounded rect | Flexible, takes any corner radius |
| `.cornerRadius(100)` | Rounded rect | Older API, still works |
| `.clipped()` | Rectangle (frame bounds) | Hides overflow outside the `.frame()` |

> 💡 `.clipped()` after `.clipShape(Circle())` is **redundant** here since `clipShape` already clips —
> but it's a good habit when using `.scaledToFill()` to ensure nothing overflows.

---

## 🎨 SF Symbol Rendering Modes

### .renderingMode() — older API
```swift
.renderingMode(.original)   // shows the symbol's built-in colors
.renderingMode(.template)   // single color, controlled by .foregroundColor()
```

### .symbolRenderingMode() — modern API *(active)*
```swift
.symbolRenderingMode(.palette)
```

| Mode | Description |
|---|---|
| `.monochrome` | Single color — all paths share one color |
| `.hierarchical` | Single color with opacity layers for depth |
| `.palette` | Multiple explicit colors — one per symbol layer |
| `.multicolor` | Symbol's built-in fixed colors (like emoji-style icons) |

---

## 🖌️ .foregroundStyle() — Coloring SF Symbol Layers

```swift
.foregroundStyle(.blue, .yellow)
```

- Used with `.symbolRenderingMode(.palette)`
- Each argument colors **one layer** of the symbol
- Supports up to 3 colors (primary, secondary, tertiary)

```swift
.foregroundStyle(.blue)                    // primary only
.foregroundStyle(.blue, .yellow)           // primary + secondary ← current
.foregroundStyle(.blue, .yellow, .red)     // primary + secondary + tertiary
```

> 💡 The number of visible layers depends on the symbol.  
> Not all symbols have 3 layers — check in the SF Symbols app.

---

## ✅ Active vs Commented-Out Modifiers

**SF Symbol — Active:**
- `.symbolRenderingMode(.palette)`
- `.resizable()` + `.aspectRatio(contentMode: .fit)`
- `.frame(width: 300, height: 300)`
- `.foregroundStyle(.blue, .yellow)`

**SF Symbol — Commented out:**
- `.font(.system(size: 100))` — alternative sizing without `.resizable()`
- `.renderingMode(.original)` — older rendering API
- `.scaledToFill()` — fill mode instead of fit

**Custom Image — Active:**
- `.resizable()` + `.scaledToFit()`
- `.frame(width: 300, height: 300)`
- `.clipShape(Circle())`
- `.clipped()`

**Custom Image — Commented out:**
- `.cornerRadius(100)` — older rounding API
- `.clipShape(RoundedRectangle(cornerRadius: 24))` — card-style clip

---

## 💡 SF Symbol Sizing — Two Approaches

```swift
// Approach 1 — font size (no .resizable() needed)
Image(systemName: "star.fill")
    .font(.system(size: 100))

// Approach 2 — resizable + frame (more layout control)
Image(systemName: "star.fill")
    .resizable()
    .scaledToFit()
    .frame(width: 100, height: 100)
```

| Approach | Control | Best For |
|---|---|---|
| `.font(size:)` | Size tied to font system | Inline icons with text |
| `.resizable()` + `.frame()` | Pixel-precise layout | Standalone large icons |

---

## 💡 Real-World Pattern — Avatar Image

```swift
Image("profile-photo")
    .resizable()
    .scaledToFill()
    .frame(width: 60, height: 60)
    .clipShape(Circle())
    .overlay(
        Circle().stroke(.white, lineWidth: 2)
    )
```

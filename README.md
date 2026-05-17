# SwiftUI Text View — Property Highlights

A beginner-friendly breakdown of `Text` view modifiers in SwiftUI, demonstrated with a real example.

---

## 📄 Code Overview

```swift
import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        Text("Hello, World Moaz ...")
            .font(.system(size: 32, weight: .bold, design: .default))
            .border(.red, width: 2)
            .frame(width: 300, height: 300, alignment: .center)
            .border(.blue, width: 3)
            .minimumScaleFactor(0.5)
            .foregroundColor(.red)
    }
}
```

---

## 🔤 Typography Modifiers

| Modifier | Description |
|---|---|
| `.font(.title)` | Applies a predefined semantic font size |
| `.font(.system(size:weight:design:))` | Custom font with explicit size, weight, and design |
| `.fontWeight(.bold)` / `.bold()` | Makes the text bold |
| `.italic()` | Makes the text italic |
| `.underline(color:)` | Adds an underline, optionally colored |
| `.strikethrough(color:)` | Adds a strikethrough line |
| `.foregroundColor(.red)` | Sets the text color |

---

## 📐 Layout & Spacing Modifiers

| Modifier | Description |
|---|---|
| `.frame(width:height:alignment:)` | Constrains the view to a fixed size with alignment |
| `.multilineTextAlignment(.center)` | Aligns multi-line text (`.leading`, `.center`, `.trailing`) |
| `.lineLimit(2)` | Limits the number of visible lines |
| `.minimumScaleFactor(0.5)` | Allows text to shrink down to 50% of its size to fit |
| `.kerning(10)` | Adjusts spacing between characters |
| `.baselineOffset(-20)` | Shifts text up or down relative to its baseline |

---

## 🖼️ Border & Decoration

| Modifier | Description |
|---|---|
| `.border(.red, width: 2)` | Adds a red border **around the Text itself** |
| `.border(.blue, width: 3)` | Adds a blue border **around the frame** |

> ⚠️ **Order matters!** Modifiers apply top to bottom.  
> The red border wraps the text's natural size.  
> The blue border wraps the `.frame(300x300)` — so they appear at different sizes.

---

## 💡 Key Concept: Modifier Order

```swift
Text("Hello")
    .border(.red, width: 2)      // ← wraps text's intrinsic size
    .frame(width: 300, height: 300)
    .border(.blue, width: 3)     // ← wraps the 300x300 frame
```

Each modifier wraps the result of the one before it — think of it like layers.

---

## ✅ Active vs Commented-Out Modifiers

In the current code, these are **active**:

- `.font(.system(size: 32, weight: .bold, design: .default))`
- `.border(.red, width: 2)`
- `.frame(width: 300, height: 300, alignment: .center)`
- `.border(.blue, width: 3)`
- `.minimumScaleFactor(0.5)`
- `.foregroundColor(.red)`

These are **commented out** (available to experiment with):

- `.font(.title)`, `.fontWeight(.bold)`, `.bold()`
- `.underline(color: .red)`, `.strikethrough(color: .blue)`, `.italic()`
- `.multilineTextAlignment(.center)`
- `.baselineOffset(-20)`, `.kerning(10)`, `.lineLimit(2)`

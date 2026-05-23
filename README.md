# SwiftUI Buttons — Property Highlights

A beginner-friendly breakdown of every button style, modifier, and custom label pattern in SwiftUI.

---

## 📄 Code Overview

```swift
import SwiftUI

struct SwiftUIViewButtons: View {
    var body: some View {
        VStack(spacing: 20) {
            Button("Automatic Title") { print("Automatic Title") }
                .buttonStyle(.automatic).tint(.red)

            Button("Bordered Title") { print("Bordered Title") }
                .buttonStyle(.bordered).foregroundStyle(.blue).tint(.red)

            Button("BorderedProminent Title") { print("BorderedProminent Title") }
                .buttonStyle(.borderedProminent).foregroundStyle(.green).tint(.red)

            Button("Borderless Title") { print("Borderless Title") }
                .buttonStyle(.borderless)

            Button("Plain Title") { print("Plain Title") }
                .buttonStyle(.plain)

            Button("CustomButtonStyle Title") { print("Custom Title") }
                .buttonStyle(CustomButtonStyle())

            Button("BorderedProminent Title") { print("BorderedProminent Title") }
                .buttonStyle(.borderedProminent)
                .foregroundStyle(.green)
                .tint(.red)
                .controlSize(.large)
                .buttonBorderShape(.capsule)

            // Custom label — icon + text
            Button { print("upload") } label: {
                HStack(spacing: 10) {
                    Image(systemName: "photo.fill").font(.title)
                    Text("Upload Image").font(.title).bold()
                }
            }

            // Custom label — icon only
            Button { print("photo") } label: {
                Image(systemName: "photo.fill")
            }
            .buttonStyle(.bordered)

            // Custom label — fully custom shape
            Button { print("like") } label: {
                Circle()
                    .fill(.white)
                    .frame(width: 50, height: 50)
                    .shadow(radius: 10)
                    .overlay {
                        Image(systemName: "heart.fill")
                            .foregroundStyle(.red)
                    }
            }
        }
    }
}
```

---

## 🎨 Button Styles — All 5 System Styles

```swift
.buttonStyle(.automatic)         // platform decides
.buttonStyle(.bordered)          // outlined container
.buttonStyle(.borderedProminent) // filled container
.buttonStyle(.borderless)        // text only, no container
.buttonStyle(.plain)             // text only, adapts to theme
```

| Style | Appearance | Platform Dependent | Use Case |
|---|---|---|---|
| `.automatic` | System default | ✅ Yes | General purpose |
| `.bordered` | Outlined container | ✅ Yes | Secondary actions |
| `.borderedProminent` | Filled container | ✅ Yes | Primary actions |
| `.borderless` | Text only, identical everywhere | ❌ No | Inline actions |
| `.plain` | Text only, adapts to theme | ✅ Yes | List rows, menus |
| `CustomButtonStyle()` | You define everything | ❌ No | Brand-specific UI |

> 💡 From your code comments:
> - `.automatic`, `.bordered`, `.borderedProminent`, `.plain` → **change per platform** (iOS vs macOS vs watchOS)
> - `.borderless` → **identical on all platforms**

---

## 🎨 .tint() vs .foregroundStyle() on Buttons

These two modifiers interact differently depending on the button style:

```swift
Button("Bordered").buttonStyle(.bordered)
    .foregroundStyle(.blue)   // ← text/icon color
    .tint(.red)               // ← container/background color
```

| Modifier | Affects | Works With |
|---|---|---|
| `.tint(.red)` | Container fill, border color | `.bordered`, `.borderedProminent`, `.automatic` |
| `.foregroundStyle(.blue)` | Text and icon color | All styles |

```swift
// .borderedProminent example
Button("Action").buttonStyle(.borderedProminent)
    .tint(.red)             // red filled background
    .foregroundStyle(.green) // green text on top of red background
```

> ⚠️ `.foregroundStyle()` on `.borderedProminent` overrides the
> automatic white text — use carefully to maintain contrast.

---

## 📐 Button Size & Shape Modifiers

```swift
Button("Large Capsule")
    .buttonStyle(.borderedProminent)
    .controlSize(.large)
    .buttonBorderShape(.capsule)
```

### .controlSize()

| Value | Result |
|---|---|
| `.mini` | Smallest — compact UIs |
| `.small` | Slightly smaller than default |
| `.regular` | Default size |
| `.large` | Larger padding and text ← current |
| `.extraLarge` | Largest (iOS 17+) |

### .buttonBorderShape()

| Value | Shape |
|---|---|
| `.automatic` | System default (rounded rect) |
| `.roundedRectangle` | Rounded rectangle |
| `.capsule` | Pill shape ← current |
| `.circle` | Circle (icon buttons) |

---

## 🚫 .disabled()

```swift
.disabled(true)   // ← commented out
```

- Grays out the button and blocks interaction
- Works on any view, not just buttons
- Typically driven by a `@State` variable:

```swift
@State private var isLoading = false

Button("Submit") { isLoading = true }
    .disabled(isLoading)
```

---

## 🏗️ Custom ButtonStyle

```swift
struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title)
            .foregroundColor(.black)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(.red)
            )
    }
}
```

### configuration Properties

| Property | Type | Description |
|---|---|---|
| `configuration.label` | `View` | The button's content (title or custom label) |
| `configuration.isPressed` | `Bool` | `true` while finger is down |
| `configuration.role` | `ButtonRole?` | `.destructive`, `.cancel`, or `nil` |

### Adding Press Animation

```swift
func makeBody(configuration: Configuration) -> some View {
    configuration.label
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).fill(.red))
        .scaleEffect(configuration.isPressed ? 0.95 : 1.0)  // ← shrinks on press
        .opacity(configuration.isPressed ? 0.8 : 1.0)       // ← dims on press
        .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
}
```

---

## 🔑 Key Concept — Two Button Initializers

```swift
// Initializer 1 — title string (simple)
Button("Title") {
    // action
}

// Initializer 2 — custom label (full control)
Button {
    // action
} label: {
    // any View here
}
```

| Initializer | Label | Use When |
|---|---|---|
| `Button("Title") { }` | String only | Simple text buttons |
| `Button { } label: { }` | Any View | Icons, custom shapes, complex layouts |

---

## 🖼️ Three Custom Label Patterns

### Pattern 1 — Icon + Text
```swift
Button { } label: {
    HStack(spacing: 10) {
        Image(systemName: "photo.fill").font(.title)
        Text("Upload Image").font(.title).bold()
    }
}
```

### Pattern 2 — Icon Only
```swift
Button { } label: {
    Image(systemName: "photo.fill")
}
.buttonStyle(.bordered)  // ← style wraps the icon
```

### Pattern 3 — Fully Custom Shape
```swift
Button { } label: {
    Circle()
        .fill(.white)
        .frame(width: 50, height: 50)
        .shadow(radius: 10)
        .overlay {
            Image(systemName: "heart.fill")
                .foregroundStyle(.red)
        }
}
// No .buttonStyle() — the label IS the entire visual
```

| Pattern | buttonStyle needed | Best For |
|---|---|---|
| Icon + Text | Optional | Toolbar actions, inline CTAs |
| Icon only | ✅ Recommended | Compact icon buttons |
| Custom shape | ❌ Skip it | Floating action buttons, like buttons |

---

## ✅ Modifier Summary

| Modifier | Purpose |
|---|---|
| `.buttonStyle(.x)` | Sets the visual style of the button container |
| `.tint(.red)` | Colors the container/border |
| `.foregroundStyle(.green)` | Colors the text/icon |
| `.controlSize(.large)` | Controls button padding and text size |
| `.buttonBorderShape(.capsule)` | Changes the container shape |
| `.disabled(true)` | Disables interaction and grays out |
| `configuration.isPressed` | Detects press state in custom styles |

---

## 💡 Real-World Pattern — Primary + Secondary Button Pair

```swift
VStack(spacing: 12) {

    // Primary CTA
    Button("Create Account") { }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
        .buttonBorderShape(.capsule)
        .tint(.blue)
        .frame(maxWidth: .infinity)

    // Secondary action
    Button("Sign In") { }
        .buttonStyle(.bordered)
        .controlSize(.large)
        .buttonBorderShape(.capsule)
        .tint(.blue)
        .frame(maxWidth: .infinity)
}
.padding(.horizontal, 24)
```

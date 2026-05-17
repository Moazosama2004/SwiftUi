# SwiftUI Stepper — Property Highlights

A beginner-friendly breakdown of `Stepper`, value binding, custom increment logic, ranges, step values, and dynamic UI updates in SwiftUI.

---

## 📄 Code Overview

```swift
import SwiftUI

struct SwiftUIViewStepper: View {

    @State private var value = 0.0

    var body: some View {

        VStack {

            Stepper("Value: \(value)", value: $value)
                .font(.title)
                .tint(.blue)

            Stepper(value: $value) {

                HStack {
                    Image(systemName: "figure")
                    Text("Value: \(value)")
                }
                .font(.title)
                .foregroundStyle(.red)

            }

            Stepper("Value : \(value)") {
                value += 3
            } onDecrement: {
                value -= 3
            }

            Stepper("Value: \(value)",
                    value: $value,
                    step: 10)
                .font(.title)
                .tint(.blue)

            Stepper("Value: \(value)",
                    value: $value,
                    in: 0...5)
                .font(.title)
                .tint(.blue)

            Stepper("Value: \(value)",
                    value: $value,
                    in: 0...5,
                    step: 5)
                .font(.title)
                .tint(.blue)

            Circle()
                .fill(.red)
                .frame(width: 100 + value,
                       height: 100 + value)

        }
        .padding()
    }
}
```

---

# 🔢 What is Stepper?

`Stepper` is a SwiftUI control used to increment or decrement a value.

It provides:

- ➕ Increment button
- ➖ Decrement button

Usually used for:

- quantity selectors
- counters
- zoom controls
- settings adjustments
- numeric input

---

## 📱 Default Stepper

```swift
Stepper("Value: \(value)", value: $value)
```

Default appearance:

```text
[-] Value: 0.0 [+]
```

Tapping:

```text
+ → increases value
- → decreases value
```

---

# 🔑 Stepper + Binding Relationship

```swift
@State private var value = 0.0
```

Stores mutable local state.

```swift
Stepper("Value: \(value)", value: $value)
```

The `$` creates a `Binding<Double>`.

---

## 🧠 Why Binding is Required

Stepper needs permission to:

- READ the current value
- WRITE updated values

```swift
value     // actual Double
$value    // Binding<Double>
```

---

# 🔄 Reactive UI Updates

```swift
Stepper("Value: \(value)", value: $value)
```

The displayed text updates automatically.

### Flow

```text
User taps +
      ↓
value changes
      ↓
SwiftUI redraws body
      ↓
Text updates automatically
```

---

# 🎨 Styling the Stepper

```swift
.font(.title)
.tint(.blue)
```

---

## 🔠 .font(.title)

```swift
.font(.title)
```

Changes label typography.

Example:

```text
Value: 0.0
```

becomes larger.

---

## 🔵 .tint(.blue)

```swift
.tint(.blue)
```

Changes the accent color of:

- increment button
- decrement button

---

# 🧱 Custom Stepper Label

```swift
Stepper(value: $value) {

    HStack {
        Image(systemName: "figure")
        Text("Value: \(value)")
    }

}
```

Instead of a plain text label, you provide a custom view.

---

## 📦 Equivalent Layout

```swift
HStack {
    Image(systemName: "figure")
    Text("Value: \(value)")
}
```

Allows:

- icons
- stacks
- custom layouts
- styled labels

---

# 🟢 .foregroundStyle(.red)

```swift
.foregroundStyle(.red)
```

Changes:

- SF Symbol color
- text color

inside the custom label.

---

# ⚙️ Custom Increment / Decrement Logic

```swift
Stepper("Value : \(value)") {
    value += 3
} onDecrement: {
    value -= 3
}
```

This Stepper does NOT use automatic binding stepping.

You manually define behavior.

---

## 🔥 Why Use Custom Closures?

Useful when you want:

- custom increment amounts
- validation
- animations
- sound effects
- networking actions
- analytics tracking

---

## 📈 Increment by 3

```swift
value += 3
```

Every tap on ➕:

```text
0 → 3 → 6 → 9
```

---

## 📉 Decrement by 3

```swift
value -= 3
```

Every tap on ➖:

```text
9 → 6 → 3 → 0
```

---

# 🔟 step Parameter

```swift
Stepper("Value: \(value)",
        value: $value,
        step: 10)
```

Controls how much the value changes per tap.

---

## Example

```text
0 → 10 → 20 → 30
```

instead of:

```text
0 → 1 → 2 → 3
```

---

# 📏 Value Range

```swift
Stepper("Value: \(value)",
        value: $value,
        in: 0...5)
```

Limits the allowed values.

---

## Allowed Values

```text
0 ≤ value ≤ 5
```

Stepper automatically prevents:

- going below 0
- going above 5

---

# 🔢 Range + Step Combined

```swift
Stepper("Value: \(value)",
        value: $value,
        in: 0...5,
        step: 5)
```

Combines:

- range restriction
- custom step amount

---

## Behavior

```text
0 → 5
```

Only valid values:

```text
0
5
```

because:

```text
step = 5
range = 0...5
```

---

# 🔴 Dynamic Circle Resizing

```swift
Circle()
    .fill(.red)
    .frame(width: 100 + value,
           height: 100 + value)
```

The Stepper directly controls the circle size.

---

## 🧠 Reactive UI Concept

```swift
UI = function(state)
```

When `value` changes:

```text
Stepper changes value
       ↓
Circle frame recalculates
       ↓
Circle resizes automatically
```

---

# 📐 Circle Size Formula

```swift
width  = 100 + value
height = 100 + value
```

---

## Example Sizes

| value | Circle Size |
|---|---|
| 0 | 100 × 100 |
| 10 | 110 × 110 |
| 50 | 150 × 150 |

---

# 📦 VStack Layout

```swift
VStack {
    ...
}
.padding()
```

Stacks all steppers vertically.

---

## .padding()

Adds outer spacing around the container.

```text
┌─────────────────────┐
│     padded area     │
│    Stepper views    │
│     padded area     │
└─────────────────────┘
```

---

# 🆚 Stepper Initializers Comparison

| Initializer | Purpose |
|---|---|
| `Stepper(_:value:)` | Automatic increment/decrement |
| `Stepper(value:label:)` | Custom label view |
| `Stepper(_:onIncrement:onDecrement:)` | Manual control logic |
| `Stepper(_:value:step:)` | Custom increment amount |
| `Stepper(_:value:in:)` | Range-limited stepper |
| `Stepper(_:value:in:step:)` | Range + custom step |

---

# ✅ Modifier Summary

| Modifier | Purpose |
|---|---|
| `Stepper` | Increment/decrement control |
| `$value` | Two-way binding |
| `.font(.title)` | Enlarges label text |
| `.tint(.blue)` | Styles stepper accent color |
| `.foregroundStyle(.red)` | Styles custom label content |
| `step:` | Controls increment size |
| `in:` | Restricts valid range |
| `.padding()` | Adds outer spacing |
| `.frame(width:height:)` | Dynamically sizes the circle |

---

# 💡 Real-World Patterns

## 🛒 Quantity Selector

```swift
Stepper("Quantity: \(quantity)",
        value: $quantity,
        in: 1...99)
```

---

## 🔍 Zoom Controller

```swift
Stepper("Zoom: \(zoomLevel)",
        value: $zoomLevel,
        in: 1...5,
        step: 0.5)
```

---

## 🎵 Volume Control

```swift
Stepper("Volume: \(volume)",
        value: $volume,
        in: 0...100,
        step: 5)
```

---

## 📏 Dynamic Shape Resizer

```swift
Circle()
    .frame(width: size,
           height: size)

Stepper("Size",
        value: $size,
        in: 50...300,
        step: 10)
```

---

# 🧠 Key Learning Concepts

| Concept | Learned From |
|---|---|
| State-driven UI | `@State` + Stepper |
| Two-way binding | `$value` |
| Declarative rendering | Dynamic circle resizing |
| Custom labels | `Stepper(value:) { }` |
| Manual step logic | `onIncrement` / `onDecrement` |
| Range restriction | `in:` |
| Custom increment size | `step:` |
| Dynamic layouts | `.frame(width:height:)` |
| Reactive updates | Stepper-driven UI redraws |

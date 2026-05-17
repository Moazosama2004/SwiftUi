# SwiftUI Slider — Property Highlights

A beginner-friendly breakdown of `Slider`, value binding, ranges, step values, custom labels, editing states, and reactive UI updates in SwiftUI.

---

## 📄 Code Overview

```swift
import SwiftUI

struct SwiftUIViewSlider: View {

    @State private var value = 5.0
    @State private var change = false

    var body: some View {

        VStack {

            Text("Value : \(value)")
                .font(.title)
                .bold()

            Slider(value: $value)

            Slider(value: $value, in: 0...10)

            Slider(value: $value, in: 0...10) {

                HStack() {
                    Image(systemName: "figure")
                    Text("Value : \(value)")
                }

            }
            .tint(.red)

            Slider(value: $value,
                   in: 0...10,
                   step: 1.0)

            Slider(value: $value,
                   in: 10...100,
                   step: 1.0) {

                Text("Value : \(value)")

            } minimumValueLabel: {

                HStack() {
                    Image(systemName: "figure")
                    Text("Min : 10")
                }

            } maximumValueLabel: {

                HStack() {
                    Image(systemName: "figure")
                    Text("Max : 100")
                }

            } onEditingChanged: { valueSliderChanged in

                change = valueSliderChanged

            }

            Spacer()

            Circle()
                .fill(.red)
                .frame(width: 100 + value,
                       height: 100 + value)
                .opacity(change ? 1.0 : 0.0)

        }
        .padding()
    }
}
```

---

# 🎚️ What is Slider?

`Slider` is a SwiftUI control used to select a value from a continuous range.

It allows users to:

- drag a thumb horizontally
- choose numeric values visually
- adjust settings interactively

Common use cases:

- volume controls
- brightness
- zoom level
- progress adjustment
- value tuning

---

## 📱 Default Slider

```swift
Slider(value: $value)
```

Default behavior:

```text
minimum = 0
maximum = 1
```

The slider updates the bound value continuously while dragging.

---

# 🔑 Slider + Binding Relationship

```swift
@State private var value = 5.0
```

Stores mutable local state.

```swift
Slider(value: $value)
```

The `$` creates a `Binding<Double>`.

---

## 🧠 Why Binding is Required

Slider needs permission to:

- READ the current value
- WRITE updated values

```swift
value     // actual Double
$value    // Binding<Double>
```

---

# 🔄 Reactive UI Updates

```swift
Text("Value : \(value)")
```

Automatically updates whenever the slider changes.

---

## Flow Visualization

```text
User drags Slider
        ↓
value changes
        ↓
SwiftUI redraws body
        ↓
Text updates automatically
```

---

# 🔠 Displaying the Value

```swift
Text("Value : \(value)")
    .font(.title)
    .bold()
```

Shows the current slider value in large bold text.

---

## .font(.title)

```swift
.font(.title)
```

Makes the text larger.

---

## .bold()

```swift
.bold()
```

Applies bold font weight.

---

# 📏 Slider Range

```swift
Slider(value: $value, in: 0...10)
```

Restricts allowed values.

---

## Allowed Values

```text
0 ≤ value ≤ 10
```

The slider thumb cannot move outside this range.

---

# 🧱 Custom Slider Label

```swift
Slider(value: $value, in: 0...10) {

    HStack() {
        Image(systemName: "figure")
        Text("Value : \(value)")
    }

}
```

Provides a custom label view for the slider.

---

## Equivalent Layout

```swift
HStack {
    Image(systemName: "figure")
    Text("Value : \(value)")
}
```

Allows:

- SF Symbols
- styled labels
- custom layouts
- multiple views

---

# 🔴 .tint(.red)

```swift
.tint(.red)
```

Changes the slider accent color.

Applies to:

- active track color
- thumb color

---

# 🔢 step Parameter

```swift
Slider(value: $value,
       in: 0...10,
       step: 1.0)
```

Controls how much the value changes.

---

## Without step

```text
1.234
1.678
2.913
```

continuous values.

---

## With step: 1.0

```text
0
1
2
3
```

discrete integer-style movement.

---

# 📦 Full Slider Initializer

```swift
Slider(value: $value,
       in: 10...100,
       step: 1.0) {

    Text("Value : \(value)")

} minimumValueLabel: {

    HStack() {
        Image(systemName: "figure")
        Text("Min : 10")
    }

} maximumValueLabel: {

    HStack() {
        Image(systemName: "figure")
        Text("Max : 100")
    }

} onEditingChanged: { valueSliderChanged in

    change = valueSliderChanged

}
```

This is the most customizable Slider initializer.

---

# 🏷️ minimumValueLabel

```swift
minimumValueLabel: {
    Text("Min : 10")
}
```

Displays content near the minimum edge.

---

## Example Layout

```text
Min:10 ───────────── Max:100
```

---

# 🏷️ maximumValueLabel

```swift
maximumValueLabel: {
    Text("Max : 100")
}
```

Displays content near the maximum edge.

---

# 🎯 onEditingChanged

```swift
onEditingChanged: { valueSliderChanged in
    change = valueSliderChanged
}
```

Detects when the user:

- starts dragging
- stops dragging

---

## Boolean States

| State | Meaning |
|---|---|
| `true` | User is actively dragging |
| `false` | User stopped dragging |

---

## Drag Lifecycle

```text
User touches slider
        ↓
onEditingChanged(true)

Dragging...
        ↓

User releases slider
        ↓
onEditingChanged(false)
```

---

# 🔴 Dynamic Circle Animation

```swift
Circle()
    .fill(.red)
    .frame(width: 100 + value,
           height: 100 + value)
```

The slider directly controls circle size.

---

# 👁️ Conditional Visibility with .opacity()

```swift
.opacity(change ? 1.0 : 0.0)
```

Shows the circle ONLY while dragging.

---

## Behavior

### While Dragging

```text
change = true
opacity = 1.0
```

Circle visible.

---

### When Dragging Ends

```text
change = false
opacity = 0.0
```

Circle hidden.

---

# 🧠 Reactive UI Concept

```swift
UI = function(state)
```

The UI automatically reacts to:

- slider movement
- editing state
- value changes

without manual UI updates.

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
| 10 | 110 × 110 |
| 50 | 150 × 150 |
| 100 | 200 × 200 |

---

# 📦 Spacer()

```swift
Spacer()
```

Pushes the circle toward the bottom of the `VStack`.

---

## VStack Layout Visualization

```text
Text
Slider
Slider
Slider
Spacer()   ← consumes remaining space
Circle     ← pushed downward
```

---

# 🆚 Slider Initializers Comparison

| Initializer | Purpose |
|---|---|
| `Slider(value:)` | Default slider |
| `Slider(value:in:)` | Range-limited slider |
| `Slider(value:label:)` | Custom label |
| `Slider(value:in:step:)` | Discrete step movement |
| `Slider(value:in:step:minimumValueLabel:maximumValueLabel:onEditingChanged:)` | Fully customizable slider |

---

# ✅ Modifier Summary

| Modifier | Purpose |
|---|---|
| `Slider` | Continuous value selector |
| `$value` | Two-way binding |
| `.font(.title)` | Enlarges text |
| `.bold()` | Applies bold weight |
| `.tint(.red)` | Styles slider accent color |
| `in:` | Restricts value range |
| `step:` | Controls increment amount |
| `minimumValueLabel:` | Leading slider label |
| `maximumValueLabel:` | Trailing slider label |
| `onEditingChanged` | Detects drag start/end |
| `.frame(width:height:)` | Dynamically sizes the circle |
| `.opacity()` | Controls visibility |
| `Spacer()` | Pushes views apart vertically |
| `.padding()` | Adds outer spacing |

---

# 💡 Real-World Patterns

## 🔊 Volume Control

```swift
Slider(value: $volume,
       in: 0...100)
```

---

## 🌞 Brightness Adjustment

```swift
Slider(value: $brightness,
       in: 0...1)
```

---

## 🔍 Zoom Slider

```swift
Slider(value: $zoom,
       in: 1...5,
       step: 0.5)
```

---

## 🎨 Brush Size Controller

```swift
Slider(value: $brushSize,
       in: 1...50,
       step: 1)
```

---

## 🎥 Video Progress Scrubber

```swift
Slider(value: $progress,
       in: 0...duration)
```

---

# 🧠 Key Learning Concepts

| Concept | Learned From |
|---|---|
| State-driven UI | `@State` + Slider |
| Two-way binding | `$value` |
| Declarative rendering | Dynamic circle resizing |
| Range restriction | `in:` |
| Discrete stepping | `step:` |
| Custom labels | `minimumValueLabel` / `maximumValueLabel` |
| Editing lifecycle | `onEditingChanged` |
| Conditional visibility | `.opacity()` |
| Layout spacing | `Spacer()` |
| Reactive updates | Slider-driven UI redraws |

# SwiftUI AsyncImage — Property Highlights

A beginner-friendly breakdown of `AsyncImage` and how to handle all loading states in SwiftUI.

---

## 📄 Code Overview

```swift
import SwiftUI

struct SwiftUIViewAsyncImage: View {
    let url = URL(string: "https://picsum.photos/400")

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: 100, height: 100)

            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipped()

            case .failure(_):
                Image(systemName: "photo.slash")
                    .foregroundStyle(.red)

            @unknown default:
                EmptyView()
            }
        }
    }
}
```

---

## 🌐 AsyncImage — What It Does

```swift
AsyncImage(url: url) { phase in ... }
```

- Downloads an image from a **remote URL** asynchronously
- Built into SwiftUI — no third-party library needed
- Automatically handles background downloading, caching (basic), and state management
- Rebuilds the view whenever the phase changes

| Feature | Supported |
|---|---|
| Remote URL loading | ✅ |
| Loading state handling | ✅ |
| Error state handling | ✅ |
| Basic memory caching | ✅ |
| Disk caching | ❌ (use SDWebImage or Kingfisher for this) |

---

## 🔗 URL Construction

```swift
let url = URL(string: "https://picsum.photos/400")
```

- `URL(string:)` returns **`URL?`** (optional) — it can fail if the string is malformed
- `AsyncImage` accepts `URL?` directly — passing `nil` triggers the `.empty` phase
- Always validate URLs in production:

```swift
// Safe URL construction
guard let url = URL(string: "https://example.com/image.jpg") else { return }

// Or use a computed property
var imageURL: URL? {
    URL(string: "https://picsum.photos/400")
}
```

---

## 🔄 AsyncImagePhase — All States

The `phase` parameter is an enum with **4 cases**:

```swift
switch phase {
case .empty:      // ← loading or not started yet
case .success:    // ← image downloaded successfully
case .failure:    // ← download failed
@unknown default: // ← future cases (required by Swift)
}
```

### State Flow

```
App launches
     │
     ▼
  .empty  ──── download starts ────►  .success(image)
     │
     └──── download fails ─────────►  .failure(error)
```

---

## ⏳ .empty — Loading State

```swift
case .empty:
    ProgressView()
        .frame(width: 100, height: 100)
```

- Shown while the image is **downloading** or before it starts
- `ProgressView()` shows a native iOS spinner
- Always match the frame to your `.success` frame — prevents layout jumping

```swift
// Styled loading placeholder
case .empty:
    ZStack {
        RoundedRectangle(cornerRadius: 12)
            .fill(.gray.opacity(0.2))
        ProgressView()
    }
    .frame(width: 100, height: 100)
```

---

## ✅ .success — Image Loaded

```swift
case .success(let image):
    image
        .resizable()
        .scaledToFill()
        .frame(width: 100, height: 100)
        .clipped()
```

- `image` here is a SwiftUI `Image` — apply modifiers just like `Image("name")`
- `.resizable()` is required before `.frame()` — same rule as regular images
- `.scaledToFill()` + `.clipped()` fills the frame without distortion

> ⚠️ The `image` from `.success` is not a `UIImage` — it's already a SwiftUI `Image`.  
> You cannot call `.resizable()` before extracting it from the phase.

---

## ❌ .failure — Error State

```swift
case .failure(_):
    Image(systemName: "photo.slash")
        .foregroundStyle(.red)
```

- Triggered when the download fails (no internet, bad URL, server error, etc.)
- `_` ignores the error — use a named variable to inspect it:

```swift
case .failure(let error):
    VStack {
        Image(systemName: "photo.slash")
            .foregroundStyle(.red)
        Text(error.localizedDescription)
            .font(.caption)
    }
```

---

## ❓ @unknown default — Future-Proofing

```swift
@unknown default:
    EmptyView()
```

- Required by Swift when switching over enums from external frameworks
- Handles **any new cases Apple adds** in future iOS versions
- Without it, the compiler warns that the switch may be non-exhaustive
- `EmptyView()` renders nothing — safe fallback

---

## 🔑 Key Concept — Phase vs Simple Initializer

`AsyncImage` has two initializers:

```swift
// Simple — no phase control
AsyncImage(url: url)
// Shows nothing while loading, image when done, nothing on failure

// Phase-based — full control ← used in this file
AsyncImage(url: url) { phase in
    // you handle all states
}

// Content + placeholder — middle ground
AsyncImage(url: url) { image in
    image.resizable()
} placeholder: {
    ProgressView()
}
```

| Initializer | Control | Use When |
|---|---|---|
| `AsyncImage(url:)` | None | Quick prototyping only |
| `AsyncImage(url:content:placeholder:)` | Loading + success | Most common use case |
| `AsyncImage(url:) { phase in }` | All 4 states | Production apps ← current |

---

## ✅ Modifier Summary

| Modifier | Applied To | Purpose |
|---|---|---|
| `URL(string:)` | URL | Safely constructs optional URL |
| `{ phase in switch }` | AsyncImage | Handles all download states |
| `ProgressView()` | .empty | Native loading spinner |
| `.resizable()` | success image | Enables frame-based sizing |
| `.scaledToFill()` | success image | Fills frame without distortion |
| `.clipped()` | success image | Hides overflow outside frame |
| `Image(systemName:)` | .failure | Fallback error icon |
| `@unknown default` | switch | Future-proof exhaustiveness |

---

## 💡 Real-World Pattern — Rounded Avatar with AsyncImage

```swift
AsyncImage(url: URL(string: "https://picsum.photos/200")) { phase in
    switch phase {
    case .empty:
        Circle()
            .fill(.gray.opacity(0.2))
            .frame(width: 60, height: 60)
            .overlay(ProgressView())

    case .success(let image):
        image
            .resizable()
            .scaledToFill()
            .frame(width: 60, height: 60)
            .clipShape(Circle())

    case .failure(_):
        Circle()
            .fill(.gray.opacity(0.2))
            .frame(width: 60, height: 60)
            .overlay(
                Image(systemName: "person.fill")
                    .foregroundStyle(.gray)
            )

    @unknown default:
        EmptyView()
    }
}
```

# SwiftUI @FocusState — Property Highlights

A beginner-friendly breakdown of `@FocusState`, focus chaining, and `submitLabel` in SwiftUI.

---

## 📄 Code Overview

```swift
import SwiftUI

struct SwiftUIViewFocusPropertyWrapper: View {

    enum LoginFocusedStates {
        case username
        case email
        case password
    }

    @FocusState private var selectedFocusedState: LoginFocusedStates?
    @State private var username = ""
    @State private var email    = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: 20) {

            TextField("username", text: $username)
                .submitLabel(.next)
                .focused($selectedFocusedState, equals: .username)
                .onSubmit { selectedFocusedState = .email }

            TextField("email", text: $email)
                .submitLabel(.next)
                .focused($selectedFocusedState, equals: .email)
                .onSubmit { selectedFocusedState = .password }

            SecureField("password", text: $password)
                .submitLabel(.next)
                .focused($selectedFocusedState, equals: .password)
                .onSubmit { print("Login Process....") }
        }
        .padding()
        .onAppear {
            selectedFocusedState = .username   // auto-focus on launch
        }
    }
}
```

---

## 🔑 @FocusState — The Core Concept

```swift
@FocusState private var selectedFocusedState: LoginFocusedStates?
```

- A property wrapper that **tracks and controls which field is focused**
- When its value changes → keyboard appears on the matching field
- When set to `nil` → keyboard dismisses
- **Optional** (`?`) because no field may be focused

### @State vs @FocusState

| Wrapper | Purpose | Triggers Redraw |
|---|---|---|
| `@State` | General value storage | ✅ Yes |
| `@FocusState` | Keyboard focus tracking only | ✅ Yes |

```swift
// @State — you own and mutate the value freely
@State private var counter = 0

// @FocusState — SwiftUI also writes to this (when user taps a field)
// AND you write to it (to move focus programmatically)
@FocusState private var focused: LoginFocusedStates?
```

---

## 🗂️ Focus Enum

```swift
enum LoginFocusedStates {
    case username
    case email
    case password
}
```

- Each case maps to **one focusable field**
- The optional `LoginFocusedStates?` means:
  - `.username` → username field is focused
  - `.email` → email field is focused
  - `.password` → password field is focused
  - `nil` → no field focused, keyboard dismissed

> 💡 Using an enum instead of a Bool allows managing **multiple fields**
> with a single `@FocusState` variable — much cleaner than one Bool per field.

### Bool vs Enum @FocusState

```swift
// Simple — Bool for a single field
@FocusState private var isUsernameFocused: Bool

TextField("username", text: $username)
    .focused($isUsernameFocused)

// Advanced — Enum for multiple fields ← current
@FocusState private var focused: LoginFocusedStates?

TextField("username", text: $username)
    .focused($focused, equals: .username)
```

---

## 🔗 .focused() — Connecting Fields

```swift
TextField("username", text: $username)
    .focused($selectedFocusedState, equals: .username)
//           ↑                              ↑
//    binding to FocusState         which case activates this field
```

| Parameter | Description |
|---|---|
| `$selectedFocusedState` | Binding to the `@FocusState` variable |
| `equals: .username` | This field is focused when state equals `.username` |

> 💡 `$selectedFocusedState` uses the `$` prefix — same as `@Binding`.
> `@FocusState` works like `@State` but the binding is passed to `.focused()`.

---

## ⛓️ Focus Chaining — The Full Flow

```swift
// Field 1 — username
.focused($selectedFocusedState, equals: .username)
.onSubmit { selectedFocusedState = .email }       // → move to email

// Field 2 — email
.focused($selectedFocusedState, equals: .email)
.onSubmit { selectedFocusedState = .password }    // → move to password

// Field 3 — password
.focused($selectedFocusedState, equals: .password)
.onSubmit { print("Login Process....") }          // → submit form
```

### Chain Diagram

```
App appears
    │
    ▼ .onAppear { selectedFocusedState = .username }
┌───────────┐
│ username  │ ← keyboard open, cursor here
└───────────┘
    │ user taps Return (.next)
    ▼ .onSubmit { selectedFocusedState = .email }
┌───────────┐
│  email    │ ← keyboard stays open, focus jumps
└───────────┘
    │ user taps Return (.next)
    ▼ .onSubmit { selectedFocusedState = .password }
┌───────────┐
│ password  │ ← keyboard stays open, focus jumps
└───────────┘
    │ user taps Return
    ▼ .onSubmit { print("Login Process....") }
  Login! ✅
```

---

## 🏷️ .submitLabel()

```swift
.submitLabel(.next)
```

Controls the **label on the Return key** of the keyboard:

| Value | Key Shows | Use For |
|---|---|---|
| `.done` | "Done" | Last field, closes keyboard |
| `.next` | "Next" ← current | Middle fields, chains focus |
| `.go` | "Go" | Search, navigation |
| `.search` | "Search" | Search bars |
| `.send` | "Send" | Messages, chat |
| `.join` | "Join" | Group/room entry |
| `.route` | "Route" | Maps, directions |
| `.return` | "return" | Default |
| `.continue` | "Continue" | Multi-step forms |

> 💡 The last field (password) uses `.next` here but `.done` would be
> more semantically correct since it submits the form, not moves focus.

---

## 👁️ Auto-Focus on Appear

```swift
.onAppear {
    selectedFocusedState = .username
}
```

- Opens the keyboard immediately when the view appears
- Cursor lands in the username field automatically
- Standard UX pattern for **login and signup screens**

> ⚠️ On some iOS versions there's a known delay —
> wrapping in `DispatchQueue.main.asyncAfter(deadline: .now() + 0.5)`
> can make auto-focus more reliable:
> ```swift
> .onAppear {
>     DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
>         selectedFocusedState = .username
>     }
> }
> ```

---

## ❌ Dismissing the Keyboard

```swift
// Set to nil → keyboard dismisses, no field focused
selectedFocusedState = nil

// Common trigger — Done button
Button("Done") {
    selectedFocusedState = nil
}

// Or dismiss on background tap
.onTapGesture {
    selectedFocusedState = nil
}
```

---

## ✅ Modifier Summary

| Modifier | Purpose |
|---|---|
| `@FocusState private var x: Enum?` | Tracks which field is focused |
| `.focused($x, equals: .case)` | Links a field to a focus state case |
| `.submitLabel(.next)` | Labels the Return key on the keyboard |
| `.onSubmit {}` | Runs when Return key is tapped |
| `selectedFocusedState = .email` | Programmatically moves focus |
| `selectedFocusedState = nil` | Dismisses keyboard |
| `.onAppear { focused = .username }` | Auto-focuses on view appearance |

---

## 💡 Real-World Pattern — Complete Login Form

```swift
struct LoginForm: View {
    enum Field { case email, password }

    @FocusState private var focused: Field?
    @State private var email    = ""
    @State private var password = ""
    @State private var isLoading = false

    var body: some View {
        VStack(spacing: 16) {

            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .submitLabel(.next)
                .focused($focused, equals: .email)
                .onSubmit { focused = .password }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(.gray.opacity(0.1)))

            SecureField("Password", text: $password)
                .textContentType(.password)
                .submitLabel(.done)
                .focused($focused, equals: .password)
                .onSubmit { login() }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(.gray.opacity(0.1)))

            Button("Sign In") { login() }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .disabled(email.isEmpty || password.isEmpty)
        }
        .padding()
        .onTapGesture { focused = nil }   // dismiss keyboard on background tap
        .onAppear { focused = .email }
    }

    func login() {
        focused = nil   // dismiss keyboard before async work
        isLoading = true
        // perform login...
    }
}
```

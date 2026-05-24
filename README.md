# SwiftUI TextField & SecureField — Property Highlights

A beginner-friendly breakdown of text input, keyboard types, input behavior, and SecureField in SwiftUI.

---

## 📄 Code Overview

```swift
import SwiftUI

struct SwiftUIViewTextField: View {
    @State private var username  = ""
    @State private var age       = ""
    @State private var phone     = ""
    @State private var email     = ""
    @State private var password  = ""

    var body: some View {
        VStack(spacing: 20) {
            TextField("Username", text: $username)  .keyboardType(.alphabet)
            TextField("Age",      text: $age)       .keyboardType(.numberPad)
            TextField("Email",    text: $email)     .keyboardType(.emailAddress)
            TextField("Phone",    text: $phone)     .keyboardType(.phonePad)
            TextField("Phone",    text: $phone)     .keyboardType(.phonePad).disabled(true)
            SecureField("Password", text: $password)
        }
        .padding()
    }
}
```

---

## 🔤 TextField — Basic Anatomy

```swift
TextField("Placeholder", text: $username)
```

| Part | Description |
|---|---|
| `"Placeholder"` | Hint text shown when field is empty |
| `text: $username` | Two-way `@Binding<String>` — reads & writes the state |

> 💡 `$username` is a `Binding<String>` — the same `@Binding`
> concept from the previous file, just used by a built-in SwiftUI view.

---

## 🎨 Custom Styled TextField — Shared Pattern

Every field in this file uses the same visual recipe:

```swift
TextField("Username", text: $username)
    .padding()                          // internal text inset
    .frame(height: 60)                  // fixed height
    .background {
        LinearGradient(
            colors: [.red, .yellow],
            startPoint: .leading,
            endPoint: .trailing
        )
    }
    .clipShape(Capsule())               // pill shape clip
    .foregroundColor(.white)            // white text
```

### Why This Order Matters

```
TextField (intrinsic size)
    │
    ├── .padding()       → grows the tappable + visual area
    ├── .frame(height:)  → fixes height to 60pt
    ├── .background {}   → gradient fills the padded frame
    └── .clipShape()     → clips gradient to capsule shape
```

> ⚠️ `.clipShape(Capsule())` must come **after** `.background {}`
> or the gradient won't be clipped correctly.

---

## ⌨️ Keyboard Types

```swift
.keyboardType(.alphabet)      // Username
.keyboardType(.numberPad)     // Age
.keyboardType(.emailAddress)  // Email
.keyboardType(.phonePad)      // Phone
```

### All Common Keyboard Types

| Type | Shows | Use For |
|---|---|---|
| `.default` | Full QWERTY | General text (default) |
| `.alphabet` | Letters only, no numbers row | Names, usernames ← Username |
| `.numberPad` | 0–9 only, no return key | Age, PIN, quantity ← Age |
| `.decimalPad` | 0–9 + decimal point | Prices, measurements |
| `.emailAddress` | QWERTY + @ and . prominent | Emails ← Email |
| `.phonePad` | Dial pad layout (0–9 + * #) | Phone numbers ← Phone |
| `.URL` | QWERTY + / and . prominent | Web addresses |
| `.twitter` | QWERTY + @ and # prominent | Social handles |

> ⚠️ `.numberPad` and `.phonePad` have **no Return key** — use a
> toolbar or `FocusState` to dismiss the keyboard programmatically.

---

## 📤 .onSubmit { }

```swift
TextField("Age", text: $age)
    .keyboardType(.numberPad)
    .onSubmit {
        print("Age is: \(age)")   // runs when Return is tapped
    }

TextField("Email", text: $email)
    .onSubmit {
        print("Email is: \(email)")
    }
```

- Triggered when the user taps the **Return / Done key**
- Not triggered for `.numberPad` or `.phonePad` (no Return key)
- Common use: move focus to next field, trigger a search, validate input

```swift
// Real-world: chain focus through fields
.onSubmit {
    focusedField = .nextField
}
```

---

## 🔡 Text Input Behavior Modifiers

### .disableAutocorrection()
```swift
.disableAutocorrection(true)   // on Email field
```
- Turns off iOS autocorrect red underlines and substitutions
- Essential for emails, usernames, codes — anything that isn't natural language

### .textInputAutocapitalization()
```swift
.textInputAutocapitalization(.characters)  // on Email field
```

| Value | Behavior |
|---|---|
| `.never` | No auto-capitalization |
| `.characters` | ALL CAPS ← Email field |
| `.words` | Capitalizes Each Word |
| `.sentences` | Capitalizes first word (default) |

> 💡 `.characters` on an email field forces uppercase —
> useful for uppercase-only codes but unusual for emails.
> Typically you'd use `.never` for email fields in production.

### .textContentType() — commented out
```swift
// .textContentType(.emailAddress)
// .textContentType(.password)
```
- Tells iOS what **semantic type** of content this field expects
- Enables **AutoFill** from Keychain, iCloud, and Contacts
- Strongly recommended for login/signup forms in production

| Value | Enables |
|---|---|
| `.emailAddress` | AutoFill email from Contacts |
| `.password` | AutoFill password from Keychain |
| `.newPassword` | Strong password suggestion |
| `.oneTimeCode` | AutoFill SMS verification codes |
| `.telephoneNumber` | AutoFill phone from Contacts |

---

## 🚫 .disabled()

```swift
// Active phone field
TextField("Phone", text: $phone)
    .keyboardType(.phonePad)

// Disabled phone field — identical but non-interactive
TextField("Phone", text: $phone)
    .keyboardType(.phonePad)
    .disabled(true)             // grayed out, cannot be tapped
```

- Grays out the field and blocks all interaction
- Typically driven by a `@State` or `@Binding` Bool:

```swift
@State private var isEditable = false

TextField("Phone", text: $phone)
    .disabled(!isEditable)
```

---

## 🔒 SecureField

```swift
SecureField("Password", text: $password)
    .padding()
    .frame(height: 60)
    .background { ... }
    .clipShape(Capsule())
    .foregroundColor(.white)
```

- Identical API to `TextField` — drop-in replacement
- Text is **masked with dots** automatically
- Disables copy/paste for security
- Autocorrect and autocapitalization are disabled by default

### TextField vs SecureField

| Feature | `TextField` | `SecureField` |
|---|---|---|
| Text visible | ✅ Yes | ❌ Masked |
| Copy/paste | ✅ Yes | ❌ Disabled |
| Autocorrect | ✅ Default on | ❌ Default off |
| Use for | All other inputs | Passwords, PINs |

---

## 🎨 TextFieldStyle — System Styles (commented out)

```swift
// Platform-dependent styles
TextField("Username", text: $username)
    .textFieldStyle(.automatic)      // system default per platform
    .textFieldStyle(.roundedBorder)  // rounded rectangle border

// Custom styling (no textFieldStyle needed)
TextField("Email", text: $email)
    .padding()
    .background { ... }
    .clipShape(Capsule())
```

| Style | Appearance | Platform |
|---|---|---|
| `.automatic` | System default | ✅ Varies |
| `.roundedBorder` | Gray rounded border | ✅ Varies |
| `.plain` | No decoration | ✅ Varies |
| Custom (this file) | Full control | ❌ Identical everywhere |

> 💡 Once you apply `.background {}` + `.clipShape()` manually,
> **don't** also apply `.textFieldStyle()` — they conflict.

---

## ✅ Field-by-Field Summary

| Field | keyboardType | Special Modifiers |
|---|---|---|
| Username | `.alphabet` | — |
| Age | `.numberPad` | `.onSubmit {}` |
| Email | `.emailAddress` | `.disableAutocorrection(true)`, `.textInputAutocapitalization(.characters)`, `.onSubmit {}` |
| Phone (active) | `.phonePad` | — |
| Phone (disabled) | `.phonePad` | `.disabled(true)` |
| Password | *(default)* | `SecureField` — masked automatically |

---

## 💡 Real-World Pattern — Login Form

```swift
struct LoginForm: View {
    @State private var email    = ""
    @State private var password = ""
    @FocusState private var focusedField: Field?

    enum Field { case email, password }

    var body: some View {
        VStack(spacing: 16) {
            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .focused($focusedField, equals: .email)
                .onSubmit { focusedField = .password }  // jump to password
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(.gray.opacity(0.1)))

            SecureField("Password", text: $password)
                .textContentType(.password)
                .focused($focusedField, equals: .password)
                .onSubmit { login() }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(.gray.opacity(0.1)))

            Button("Sign In", action: login)
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
        }
        .padding()
    }

    func login() { print("Logging in with \(email)") }
}
```

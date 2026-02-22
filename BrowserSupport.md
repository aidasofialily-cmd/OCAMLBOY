# 🌐 Browser Support & System Requirements

CAMLBOY is a high-performance Game Boy emulator written in OCaml. To ensure cycle-accurate timing and smooth 60 FPS rendering, the following browser standards are required.

## 🚀 Supported Browsers

We support the **last two major versions** of all evergreen browsers.

| Browser | Status | Minimum Version | Notes |
| :--- | :--- | :--- | :--- |
| **Chrome / Edge** | ✅ Full | 92+ | Best performance via V8 engine. |
| **Firefox** | ✅ Full | 90+ | Excellent support for OCaml-to-JS. |
| **Safari (macOS)** | ⚠️ Partial | 15.4+ | Requires WebGL 2.0 manual toggle on older OS. |
| **Safari (iOS)** | ⚠️ Partial | 16.0+ | Performance may vary due to JIT limitations. |
| **Internet Explorer** | ❌ No | N/A | Not supported (Lacks ES6+ and WebGL). |

---

## 🛠 Technical Requirements

The emulator relies on the following modern Web APIs. If your browser has these disabled, CAMLBOY will fail to initialize.

### 1. WebGL 2.0
Used for the PPU (Pixel Processing Unit) rendering.
* **Why:** Necessary for efficient sprite layering and palette swapping shaders.
* **Test:** [Check WebGL Support](https://get.webgl.org/webgl2/)

### 2. Web Audio API
Handles the APU (Audio Processing Unit) emulation.
* **Note:** Most browsers require a user interaction (like a click) before audio can start.

### 3. WebAssembly (WASM) / JS_of_OCaml
If the build target is WASM, your browser must support the WASM MVP.
* **Memory:** Requires at least 64MB of heap memory for the OCaml runtime.

### 4. Gamepad API (Optional)
Supported for users wishing to use physical controllers.

---

## 🔍 Troubleshooting

### Slow Performance?
1. Ensure **Hardware Acceleration** is enabled in your browser settings.
2. Close background tabs that are consuming high CPU/RAM.
3. If on a laptop, ensure you are not in "Power Saver" mode.

### No Sound?
Browsers block auto-playing audio. Click the **"Start"** or **"Unmute"** button within the emulator UI to initialize the AudioContext.

---

## 🧪 Testing Environment
We use [Playwright](https://playwright.dev/) to run automated compatibility tests against Chromium, Firefox, and WebKit during our CI/CD process.

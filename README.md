# Apps2Samsung

*Install any app on your Samsung TV.*

<p align="center">
  <img src=".github/jellyfin-tizen-logo.svg" width="220" />
</p>
<p align="center">
  <img src="https://img.shields.io/github/v/release/Apps2Samsung/Apps2Samsung?label=stable&style=for-the-badge" />
  <img src="https://img.shields.io/github/v/release/Apps2Samsung/Apps2Samsung?include_prereleases&label=beta&style=for-the-badge" />
  <img src="https://img.shields.io/badge/Tizen-TV-blue?style=for-the-badge" />
  <img src="https://img.shields.io/badge/OS-Windows%20%7C%20Linux%20%7C%20macOS-brightgreen?style=for-the-badge" />
  <a href="https://discord.gg/7mga3zh8Cv">
    <img src="https://img.shields.io/badge/Discord-Community-7289DA?style=for-the-badge&logo=discord&logoColor=white" />
  </a>
</p>

<p align="center">
  <b>Apps2Samsung</b> is a small cross-platform tool that side-loads <b>any app</b> onto <b>Samsung devices running Tizen OS</b> — Smart TVs, projectors and smart monitors —
  <a href="https://jellyfin.org">Jellyfin</a>, Moonlight, Moonfin, Litefin and the whole <a href="https://github.com/Apps2Samsung/tizen-community-packages">community catalog</a>, or your own <code>.wgt</code>.
  <br/>
  It handles device detection, certificates, and installation so you don’t have to fight with Tizen Studio or manual sideloading.
  <br/><br/>
  🌐 Available in: Danish, Dutch, English, French, German, Portuguese, Turkish
  <br/>
  🇩🇰 🇳🇱 🇬🇧 🇫🇷 🇩🇪 🇵🇹 🇹🇷 
</p>

> ### 🍴 About this fork
>
> This is a community fork of **[Samsung-Jellyfin-Installer / Apps2Samsung](https://github.com/Jellyfin2Samsung/Samsung-Jellyfin-Installer)** by **Patrick Stel ([@PatrickSt1991](https://github.com/PatrickSt1991))**. All credit for the tool itself goes to Patrick and the upstream contributors — please ⭐ and support the original project.
>
> This fork only adds **native Apple Silicon (ARM64 macOS) support**:
> - A bundled native `darwin-arm64` esbuild with architecture-aware selection — fixes JavaScript transpilation on M-series Macs (upstream shipped only an x86-64 binary and looked for a non-existent `osx-universal` path)
> - Pre-selects the default Jellyfin build in the app dropdown instead of leaving it empty
> - A `make-macos-app.sh` helper that wraps a build into a double-clickable, signed `.app`
>
> **Most users should use the [official upstream releases](https://github.com/Jellyfin2Samsung/Samsung-Jellyfin-Installer/releases).** To build this fork natively on Apple Silicon, see [Building from source on macOS](#-building-from-source-on-macos-apple-silicon).

---

## 📦 Current Versions

<!-- versions:start -->

| Channel    | Version                                                             | Notes                        |
|------------|---------------------------------------------------------------------|------------------------------|
| **Stable** | [v2.5.5](https://github.com/Apps2Samsung/Apps2Samsung/releases/tag/v2.5.5)                                        | Recommended for most users   |
| **Beta**   | [N/A](#)                                            | Includes new features        |

<!-- versions:end -->

👉 All releases: https://github.com/Apps2Samsung/Apps2Samsung/releases

---

## 🚀 How It Works (Short Version)

Before you begin, ensure your Samsung TV is in Developer Mode. This is required to install apps on it.

👉 [How to enable Developer Mode on your TV](https://github.com/Apps2Samsung/Apps2Samsung/wiki/FAQ#-how-to-enable-developer-mode-on-your-tv)

1. Run the tool on your computer
2. Select your Samsung TV
3. Pick an app (Jellyfin, the community catalog, or a custom `.wgt`)
4. Install

That’s it. No manual certificate handling required in most cases.

🎥 Full walkthrough:  
https://www.youtube.com/watch?v=_8mSV5pW-ic

**NixOS:** Clone the repository and run `nix-shell` — the shell environment will automatically build and launch the tool.

---

## 🍎 Building from source on macOS (Apple Silicon)

This fork builds and runs **natively on Apple Silicon** (M1–M4) — no Rosetta required.

**Prerequisite — the .NET 8 SDK:**

```bash
brew install dotnet@8
export DOTNET_ROOT="$(brew --prefix dotnet@8)/libexec"
export PATH="$(brew --prefix dotnet@8)/bin:$PATH"
```

**Build a native, double-clickable app bundle:**

```bash
cd Jellyfin2Samsung-CrossOS
dotnet publish Apps2Samsung.csproj -c Release -r osx-arm64 \
  -p:SelfContained=true -p:UseAppHost=true -o publish/osx-arm64
./make-macos-app.sh osx-arm64        # assembles & ad-hoc signs publish/Apps2Samsung.app
open publish/Apps2Samsung.app
```

Drag `Apps2Samsung.app` into `/Applications` to install it. On Intel Macs, substitute `osx-x64` in both commands.

---

## 📚 Documentation

All detailed documentation lives in the wiki:

- 🚀 [Quick Start](../../wiki)
- ❓ [FAQ](../../wiki/FAQ)
- ⚙️ [Configuration & Jellyfin Settings](../../wiki/Configuration)
- 🔮 [Alternative Install Methods](../../wiki/Alternatives)
- 🗑️ [Uninstall / Remove](../../wiki/Remove)

> Orsay-based TVs (pre-2015 models) are no longer supported.

---

## 📦 Community Packages

Community-shared and older `.wgt` builds can be found here:  
https://github.com/Apps2Samsung/tizen-community-packages

---

## 🛠️ Support & Contributing

Contributions of all kinds are welcome — whether it’s bug reports, feature requests, code, documentation, or translations.

- Bug reports & feature requests: [Issues](../../issues)
- Ideas, feedback & questions: [Discussions](../../discussions)
- Community chat: [Discord](https://discord.gg/7mga3zh8Cv)

## 🌍 Translations

Want to help translate **Apps2Samsung**? Community translations are always appreciated.

You can contribute here:

- [Transifex](https://app.transifex.com/madebypatrick/apps2samsung)
- [Crowdin](https://crowdin.com/project/jellyfin2samsung)

You can help by translating missing strings, improving existing translations, or reviewing your language.

Translation updates are synced back into this repository automatically.

---

## ❤️ Support the Project

If this tool helped you, consider supporting its development:

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/M4M71JOT9R)

---

## 🙏 Contributors & Thanks

This project is made possible by the people who contribute their time, knowledge, and feedback.

<a href="https://github.com/Apps2Samsung/Apps2Samsung/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=Apps2Samsung/Apps2Samsung" />
</a>

Special thanks to:
- **jeppevinkel** — for providing the Jellyfin Tizen `.wgt` builds  
  https://github.com/jeppevinkel/jellyfin-tizen-builds
- **@RadicalMuffinMan** — for the Moonfin client and related work  
  https://github.com/Moonfin-Client/Smart-TV
- **@MoazSalem** — for the Litefin client and related work  
  https://github.com/MoazSalem/litefin/

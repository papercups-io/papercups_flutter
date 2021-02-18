## [2.0.4] - 18/02/2021.
Bumps `flutter_markdown` to 0.6.0

## [2.0.1, 2.0.2, 2.0.3] - 16/02/2021.
These releases are maintenance related, addressing some issues found on pub.dev to improve its score.

### Fixes
* Bump `intl` to 0.17.0
* Bump `http` to 0.13.0
* Modify description to make it over 60 characters
* Avoided using braces in interpolation when not needed. 

## [2.0.0] - 16/02/2021.

# 🎉 2.0 has landed!
This release brings major changes to how this package works. Most importantly, it is now completely native, ensuring speed and performace along with more customisability. This will also enable new features such as chat message notifications, in-app overlays, local message retention and many others, make sure to leave suggestions [here](https://github.com/papercups-io/papercups_flutter) for what to build next.

### New Features
* Native Dart implementation!
* Full themeing control w/gradients.
* Full Internationalization control - every part can be set to any language.
* Dark mode
* Added elevation option to message box

### Enhancements
* Fixes issue of fuzzy timestamps not updating, see https://github.com/papercups-io/chat-widget/issues/73.
* Support for Flutter Desktop.
* Much better loading times

### Breaking changes
* Removed support for `onStartLoading`, `onFinishLoading` and `onError`.
* Removed agent availability configuartion, see https://github.com/papercups-io/papercups_flutter/issues/16.
* Removed `iframeUrl`.
* `baseUrl` in props must not contain a prefix (no `http`,`https`,`ws`, etc).

### Contributors
Thanks to [@Fiyiin](https://github.com/Fiyiin) for helping me out building this version of the library!

## [1.0.1] - 05/01/2021.

* 🍱 Update Readme.md with new logo


## [1.0.0+1] - 1/12/2020.

* 🎉 1.0 Release!
* 🐛 Fix customer data bug

## [0.2.2] - 30/11/2020.

* ⚡️ Performance imporvements to `genIframeUrl`
* ✨ Added `toMap()` and `toJsonString()` to the classes, better URI generation.

## [0.2.1] - 26/11/2020.

* 🚨 Remove unused import (improve pub score)

## [0.2.0] - 26/11/2020.

### New features
* ✨ `onStartLoading`, `onFinishLoading` and `onError` functions. (#4)

### Enhancements
* 📝 Improved docs with higher coverage and syntax highlighting (Thanks to @Immortalin).
* ⚡️ Web widget is now constant. Better preformance.
* ✨ Update example to show new features.

## [0.1.4] - 23/11/2020.

* 🎨 Restructure code and fix warnings

## [0.1.3] - 23/11/2020.

* 🐛 Add platfromView stub, should fix platfrom id and pub score

## [0.1.2] - 22/11/2020.

* 🐛 Try and fix analyzer error again

## [0.1.1] - 22/11/2020.

* 🐛 Try and fix analyzer error, known issue at https://github.com/flutter/flutter/issues/41563

## [0.1.0] - 22/11/2020.

### New features
* ✨ Flutter Web support!

### Enhancements
* 📝 Added Known Issues (#10)
* 🎨 Internal restructuring to support Flutter Web.

### Fixes
* ✏️ Fixed changelog typos

## [0.0.3] - 20/11/2020.

### Enhancements
* 📝 Improved Readme.md (#9)
* 📝 Improved API documentation (#1)

### Bug Fixes
* 🐛 Fixed external id not working correctly (#9)
* 🐛 Fixed bools being sent incorrectly (#3)

## [0.0.2] - 18/11/2020.

* Increase Pub Score.

## [0.0.1] - 17/11/2020.

* 🎉 Initial Release.

# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## 1.0.0 - 2024-12-18

### Added
- Comprehensive documentation comments for all public APIs
- Extensive test suite covering all major components:
  - MayrMdCms class tests
  - MayrMdCmsConfig tests
  - MayrMdCmsBase tests
  - MayrMdCmsRenderer widget tests
  - MayrMdCmsMarkdownRenderer tests
  - Extension tests
  - Integration tests
- Constants for magic strings to improve code maintainability

### Changed
- **BREAKING**: Fixed typo in method name: `newtwork()` renamed to `network()`
- Improved code organization following Software Engineering Principles (KISS, DRY, SRP, SOC)
- Enhanced link handling with better separation of concerns
- Updated README with corrections:
  - Fixed method name references (fromLocal → local, fromNetwork → network)
  - Corrected typo "Instal" → "Install"
  - Updated extension examples to use correct base class
  - Added missing commas in code examples
- Improved code documentation throughout the codebase

### Fixed
- Method naming inconsistencies in documentation
- Missing documentation in public APIs
- Code examples in README that used incorrect method names

---

## 0.2.0

- Automated deployments added

## 0.1.0 - Initial Release

- First version of mayr_md_cms released.
- Supports fetching and rendering Markdown from local, network, or custom sources.
- Handles link clicks and supports URL opening or copying to clipboard.
- Internal actions through custom links like `[About Us](internal:about_us)`.
- Fully customisable error widget, loading widget, markdown styles, and more.
- Extendable, allowing users to create custom classes by extending MayrMdCms.

# Socialise. Marketing Website

Static single-page marketing website for Socialise, a social events platform. Deployed via GitHub Pages at `www.socialiseevents.co.uk`.

## Project Structure

```
index.html          # Entire site: HTML, CSS (~830 lines), JS (~143 lines)
assets/ben.png      # Team member photo
assets/chris.png    # Team member photo
CNAME               # GitHub Pages DNS (www.socialiseevents.co.uk)
```

No build tools, frameworks, or npm packages. Pure vanilla HTML/CSS/JS.

## Architecture

### HTML Sections

| Section | Element | ID | Key Classes |
|---------|---------|-----|-------------|
| Navigation | `<nav>` | — | `.nav`, `.nav-links`, `.nav-right`, `.menu-toggle`, `.menu-backdrop` |
| Hero | `<section>` | `#hero` | `.hero`, `.hero-badge`, `.hero-title`, `.hero-title-gradient`, `.hero-actions` |
| Manifesto | `<section>` | `#about` | `.manifesto`, `.manifesto-text` |
| Features | `<section>` | `#features` | `.features`, `.features-grid`, `.feature-card` |
| Team | `<section>` | `#team` | `.team`, `.team-grid`, `.team-card` |
| Contact | `<section>` | `#contact` | `.contact`, `.contact-grid`, `.contact-card` |
| Footer | `<footer>` | — | `.footer` |

Background orbs: `.orb-container` > `.orb-1`, `.orb-2`, `.orb-3` (decorative blurred circles).

### CSS Custom Properties

Themes controlled via `[data-theme="dark"]` on `<html>`. Key variables:

- `--color-primary: #E2725B` (coral), `--color-secondary: #2D5F5D` (teal), `--color-accent: #F4B942` (gold)
- `--color-bg`: page background (`#FAFAF6` light, `#080810` dark)
- `--color-nav-bg`: semi-transparent nav background (used with backdrop-filter via `::before` pseudo-element)
- `--color-surface`, `--color-border`, `--color-text`, `--color-text-muted`
- `--font-heading: 'Outfit'`, `--font-body: 'Quicksand'` (Google Fonts)
- `--ease-out: cubic-bezier(0.16, 1, 0.3, 1)`, `--ease-spring: cubic-bezier(0.34, 1.56, 0.64, 1)`

### Responsive Breakpoint

Single breakpoint: `@media (max-width: 768px)`:
- Features grid collapses to 1 column
- Nav links become a 260px fixed side panel sliding from right
- Hamburger menu toggle shown
- `@media (prefers-reduced-motion: reduce)` disables all animations

### JavaScript (5 IIFEs)

1. **Theme Toggle** — Toggles `data-theme="dark"`, persists in `localStorage('theme')`, updates `<meta name="theme-color">`
2. **Scroll Reveal** — `IntersectionObserver` adds `.visible` to `.reveal` elements (supports `.reveal-delay-1` through `-4`)
3. **Nav Scroll Effect** — Adds `.scrolled` to `.nav` when `scrollY > 60`; highlights active `.nav-link` based on visible section
4. **Feature Card Spotlight** — Tracks mouse position via `--mouse-x`/`--mouse-y` CSS vars on `.feature-card` for radial gradient glow
5. **Mobile Menu Toggle** — Toggles `.open` on `.menu-toggle`, `.nav-links`, `.menu-backdrop`; locks body scroll

Plus smooth anchor scroll (`scrollIntoView`) on all `a[href^="#"]`.

### Z-Index Stacking

```
body::after (grain overlay)    z-index: 9999  pointer-events: none
.nav (fixed nav bar)           z-index: 100
  .menu-toggle                 z-index: 102
  .nav-links (mobile panel)    z-index: 101
  .menu-backdrop               z-index: 100
  .nav::before (blur effect)   z-index: -1
section                        z-index: 1
.orb-container                 z-index: 0
```

**Important**: The nav blur effect (`backdrop-filter`) is on `.nav::before` (not `.nav` directly) to avoid creating a containing block that would break `position: fixed` children (side menu panel, backdrop).

### External Links

- App: `https://app.socialiseevents.co.uk`
- Business email: `hello@socialiseevents.co.uk`
- Support email: `support@socialiseevents.co.uk`

## Testing

```bash
# Local preview
python -m http.server 8000
# Then visit http://localhost:8000
```

Key things to verify:
- Theme toggle (dark/light) persists across reload
- Mobile side menu opens/closes correctly (test at <768px width)
- Scroll reveal animations trigger on scroll
- Feature card spotlight follows mouse cursor
- Nav blur effect appears after scrolling 60px
- Side menu panel and backdrop render above all page content when scrolled

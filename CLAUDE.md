> **IMPORTANT — Cross-project rules apply.** Read `~/.claude/claude-shared/CLAUDE.md` before starting work. If that file doesn't exist, run: `git clone https://github.com/christosgalaios/claude-shared.git ~/.claude/claude-shared`

# Socialise. Marketing Website

## Claude Code Tooling

This project ships project-level skills and MCP servers so any cloud or remote session has the same capabilities as the local dev environment.

### MCP Servers (`.mcp.json`)

| Server | Package | Purpose | Requires |
|--------|---------|---------|---------|
| `context7` | `@upstash/context7-mcp` | Library/framework docs lookup | — |
| `magic` | `@21st-dev/magic` | 21st.dev reactive component search & generation | `TWENTYFIRST_API_KEY` |
| `nano-banana` | `nano-banana-mcp` | Gemini-powered image generation & editing | `GEMINI_API_KEY` |
| `stitch` | `@_davideast/stitch-mcp` | Google Stitch UI mockup generator | `STITCH_GOOGLE_CLOUD_PROJECT` |

> **Cloud setup:** Run `bash .claude/setup.sh` once per new environment to verify env vars and pre-warm packages.
>
> **Local note:** `supabase` MCP is in the global user config but omitted here — this is a static site with no DB.

### Project Skills (`.claude/skills/`)

Invoke skills with `/skill-name` or by describing the task — Claude auto-selects the right one.

#### UI Pipeline
| Skill | Trigger |
|-------|---------|
| `design-to-code` | "build", "design", "create a section", "new component", `/design` |
| `ui-ux-pro-max` | Design review, choosing colours/fonts, UX feedback |

#### Marketing & Copy
| Skill | Trigger |
|-------|---------|
| `copywriting` | Write/improve page copy, headlines, CTAs, value props |
| `page-cro` | Conversion rate issues, landing page feedback, "why isn't this converting" |
| `ai-seo` | Optimize for AI search (ChatGPT, Perplexity, Gemini), answer engine optimization |
| `seo-audit` | Technical SEO review, meta tags, Core Web Vitals, rankings |
| `content-strategy` | "what should I write about", blog planning, topic clusters |
| `analytics-tracking` | GA4, event tracking, UTM parameters, conversion measurement |
| `schema-markup` | JSON-LD structured data, rich snippets, FAQ schema |
| `ab-test-setup` | A/B tests, split tests, hypothesis design |

### Skill & MCP Compatibility Notes

- All skills are pure markdown — they work in any Claude Code environment with no install step.
- All MCP servers use `npx` — they require Node.js ≥ 18 and internet access to download packages.
- `context7` has no API key requirement and will work out of the box.
- `magic`, `nano-banana`, and `stitch` require env vars (see setup script above). Without them, those MCP tools will fail silently — Claude will fall back to writing components manually.
- The `design-to-code` skill orchestrates `stitch` + `nano-banana` + `ui-ux-pro-max` + `magic` in sequence. Skip phases whose MCP server isn't available.

Static single-page marketing website for Socialise, a social events platform. Deployed via GitHub Pages at `www.socialise.events`.

## Brand Identity

- **Logo**: **S**ocialise**.** — the "S" is terracotta, the "." is gold, rest is default text color
- **Condensed mark**: "S." (terracotta S + gold dot)
- **Brand accent utilities**: `.brand-s` (terracotta) and `.brand-dot` (gold) are used on key headings to reinforce the logo motif
- **Colors**: Terracotta `#E2725B`, Teal `#2D5F5D`, Gold `#F4B942`, Paper `#F9F7F2`
- **Fonts**: Outfit (headings), Quicksand (body)
- **Tone**: Warm, wholesome, human — NOT corporate, NOT "AI-matched intimate dinners"

## Product Context (important for copy)

- Socialise is about **wholesome social events**: pub nights, hikes, board games, social deduction, speed friendships, walks, and more
- There is **NO matching algorithm** — the app suggests events based on your interests and learns from you
- **MangoAI** is the mascot AND personal AI assistant — users can say things like "I fancy a walk this weekend" and Mango finds events
- **Micro-Meets** are small-group hangouts (4-6 people) at curated venues — NOT dinner-focused, NOT "intimate"
- **Tribes** are interest-based communities users can join
- Starting in Bristol, UK

## Project Structure

```
index.html                      # Entire site: HTML, CSS (~1100 lines), JS (~180 lines)
assets/ben.png                  # Team member photo (Co-Founder)
assets/chris.png                # Team member photo (Co-Founder)
assets/hero-illustration.png    # Hero section illustration (Gemini-generated, ~8MB)
assets/mango-kitten.png         # Mango mascot illustration (Gemini-generated, ~7MB)
assets/community-event.png      # Community event scene (Gemini-generated, ~8MB)
CNAME                           # GitHub Pages DNS (www.socialise.events)
.claude/launch.json             # Dev server config (Node.js, port 3000)
```

No build tools, frameworks, or npm packages. Pure vanilla HTML/CSS/JS.

## Architecture

### HTML Sections

| Section | Element | ID | Key Classes |
|---------|---------|-----|-------------|
| Navigation | `<nav>` | — | `.nav`, `.nav-inner`, `.nav-logo`, `.nav-links`, `.nav-right`, `.menu-toggle`, `.menu-backdrop` |
| Hero | `<section>` | `#hero` | `.hero`, `.hero-grid`, `.hero-badge`, `.hero-title`, `.hero-title-gradient`, `.hero-actions`, `.hero-visual`, `.hero-image-float`, `.hero-social-proof` |
| About | `<section>` | `#about` | `.about`, `.about-inner`, `.about-text` |
| How It Works | `<section>` | — | `.how-it-works`, `.steps-indicators`, `.step-indicator`, `.steps-grid`, `.step-card`, `.step-icon`, `.step-number` |
| Features | `<section>` | `#features` | `.features`, `.features-grid`, `.feature-card`, `.feature-icon` |
| Spotlight | `<section>` | — | `.spotlight`, `.spotlight-grid`, `.spotlight-image`, `.spotlight-content`, `.spotlight-benefits` |
| Team | `<section>` | `#team` | `.team`, `.team-grid`, `.team-card`, `.team-bio-overlay`, `.team-bio-text` |
| CTA | `<section>` | — | `.cta`, `.cta-inner`, `.cta-mango` |
| Contact | `<section>` | `#contact` | `.contact`, `.contact-grid`, `.contact-card` |
| Footer | `<footer>` | — | `.footer`, `.footer-content`, `.footer-logo` |

Background orbs: `.orb-container` > `.orb-1`, `.orb-2`, `.orb-3` (decorative blurred circles).

### CSS Custom Properties

Themes controlled via `[data-theme="dark"]` on `<html>`. Key variables:

- `--color-primary: #E2725B` (terracotta), `--color-secondary: #2D5F5D` (teal), `--color-accent: #F4B942` (gold)
- `--color-bg`: page background (`#F9F7F2` light, `#0c0c14` dark)
- `--color-bg-warm`: warm background for alternating sections (`#F5F0E8` light, `#12121c` dark)
- `--color-nav-bg`: semi-transparent nav background (used with backdrop-filter via `::before` pseudo-element)
- `--color-card-bg`, `--color-card-hover-border`, `--color-surface`, `--color-border`, `--color-text`, `--color-text-muted`
- `--font-heading: 'Outfit'`, `--font-body: 'Quicksand'` (Google Fonts)
- `--radius-sm: 12px`, `--radius-md: 20px`, `--radius-lg: 28px`, `--radius-xl: 36px`
- `--ease-out: cubic-bezier(0.16, 1, 0.3, 1)`, `--ease-spring: cubic-bezier(0.34, 1.56, 0.64, 1)`

### 21st.dev-Inspired Design Patterns

These patterns were adapted from 21st.dev React components into vanilla CSS:

- **Hero dot grid**: `radial-gradient` dots with `mask-image` radial fade (`.hero::before`)
- **Step indicators**: Numbered circles connected by a horizontal line (`.steps-indicators::before`)
- **Bounce card hover**: `transform: scale(0.97) rotate(-0.5deg)` with spring easing on feature cards, team cards, contact cards
- **Team bio overlay**: `clip-path: circle()` reveal from avatar position on hover (`.team-bio-overlay`)
- **Spotlight benefit cards**: Card-style list items with `translateX(4px)` hover slide
- **CTA radial glow**: `radial-gradient` pseudo-element behind CTA content

### Section Transitions

Sections with different backgrounds use `clip-path: inset(-1px round 80px)` for soft rounded edges instead of hard lines. On mobile: `round 40px`.

A parallax depth effect makes warm sections (how-it-works, spotlight, CTA) scroll at a slightly different rate, creating a floating panel feel.

### Responsive Breakpoint

Single breakpoint: `@media (max-width: 768px)`:
- Hero grid, features grid, spotlight grid, team grid collapse to 1 column
- Nav links become a 260px fixed side panel sliding from right
- Hamburger menu toggle shown
- Hero floating cards hidden on mobile
- Step indicators hidden, inline step numbers shown instead
- Section curve radius reduced from 80px to 40px
- `@media (prefers-reduced-motion: reduce)` disables all animations

### JavaScript (7 IIFEs)

1. **Theme Toggle** — Toggles `data-theme="dark"`, persists in `localStorage('theme')`, updates `<meta name="theme-color">`, swaps sun/moon icons
2. **Scroll Reveal** — `IntersectionObserver` adds `.visible` to `.reveal` elements (supports `.reveal-delay-1` through `-4`)
3. **Parallax Depth** — Warm sections scroll at slightly different rate via `translateY` transform, using `requestAnimationFrame`. Respects `prefers-reduced-motion`.
4. **Nav Scroll Effect** — Adds `.scrolled` to `.nav` when `scrollY > 60`; highlights active `.nav-link` based on visible section
5. **Feature Card Spotlight** — Tracks mouse position via `--mouse-x`/`--mouse-y` CSS vars on `.feature-card` for radial gradient glow
6. **Mobile Menu Toggle** — Toggles `.open` on `.menu-toggle`, `.nav-links`, `.menu-backdrop`; locks body scroll
7. **Smooth Scroll** — `scrollIntoView` on all `a[href^="#"]`

### Z-Index Stacking

```
body::after (grain overlay)    z-index: 9999  pointer-events: none
.nav (fixed nav bar)           z-index: 100
  .menu-toggle                 z-index: 102
  .nav-links (mobile panel)    z-index: 101
  .menu-backdrop               z-index: 100
  .nav::before (blur effect)   z-index: -1
.team-bio-overlay              z-index: 3
.team-card img                 z-index: 2
.team-name, .team-role         z-index: 1
section                        z-index: 1
.orb-container                 z-index: 0
```

**Important**: The nav blur effect (`backdrop-filter`) is on `.nav::before` (not `.nav` directly) to avoid creating a containing block that would break `position: fixed` children (side menu panel, backdrop).

### External Links

- App: `https://app.socialise.events`
- Business email: `hello@socialise.events`
- Support email: `support@socialise.events`

## Testing

```bash
# Local preview (preferred — uses .claude/launch.json)
# Preview tools will auto-start on port 3000

# Manual alternative
python -m http.server 8000
```

Key things to verify:
- Theme toggle (dark/light) persists across reload
- Mobile side menu opens/closes correctly (test at <768px width)
- Scroll reveal animations trigger on scroll
- Feature card spotlight follows mouse cursor
- Nav blur effect appears after scrolling 60px
- Side menu panel and backdrop render above all page content when scrolled
- Hero floating cards animate and display correctly on desktop
- Illustrations load in hero, spotlight, and CTA sections
- Team card bio overlay reveals on hover (clip-path circle animation)
- Section transitions are smooth with rounded edges and parallax
- Bouncy hover effect on feature, team, and contact cards
- Brand accent S and dot visible in hero title and section headings

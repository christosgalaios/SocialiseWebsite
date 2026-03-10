---
name: design-to-code
description: "Full design pipeline: mockup → design system → reactive components. Combines Stitch (UI mockups), Nano Banana (visual references), UI UX Pro Max (design intelligence), and 21st.dev Magic (component implementation). Use when building any new UI feature, page, section, or component from scratch. Triggers: 'build', 'design', 'create a page', 'new screen', 'UI for', 'component for', 'design this', 'build me a', 'make a', 'full pipeline', '/design'."
---

# Design-to-Code Pipeline

Full UI/UX workflow combining all design tools in sequence:
**Stitch mockup → Nano Banana reference → UI UX Pro Max design system → 21st.dev reactive components**

## When to Apply

Use this skill when the user wants to:
- Build a new page, screen, section, or feature from scratch
- Design and implement a UI component end-to-end
- Go from an idea to production-ready code
- Explicitly requests the full design pipeline

Skip this skill for small, targeted edits to existing UI (just use UI UX Pro Max directly).

## Pipeline Phases

### Phase 1 — Mockup & Visual Reference

**Goal:** Establish visual direction before writing any code.

1. **Stitch mockup** — Use the `stitch` MCP to generate a UI wireframe/mockup of the requested component or page. Call the appropriate Stitch tool with a clear description of the layout, key sections, and purpose.

2. **Nano Banana reference** (if helpful) — Use the `nano-banana` MCP to generate a visual reference image that communicates style, mood, or specific UI patterns. Useful for hero sections, illustrations, dashboards, or any visually complex UI.

3. Present both outputs to the user. Ask: *"Does this direction look right, or should I adjust before moving to design?"*

### Phase 2 — Design System

**Goal:** Define the visual language before touching code.

Apply UI UX Pro Max guidelines to determine:

- **Style** — Choose from: glassmorphism, claymorphism, minimalism, brutalism, neumorphism, bento grid, dark mode, flat design, skeuomorphism. Match to product type and audience.
- **Color palette** — Select from the 97 palettes. Define primary, secondary, accent, background, surface, and text colors with hex values.
- **Typography** — Choose a font pairing (57 available). Define heading font, body font, and scale (sizes for h1–h4, body, small, caption).
- **Spacing system** — 4px or 8px base grid. Define xs/sm/md/lg/xl values.
- **Component style** — Border radius, shadow depth, border style, icon set.

Output this as a brief design spec (can be a markdown table or short list). Do not write any component code yet.

Check against critical UX rules before proceeding:
- Color contrast ≥ 4.5:1 for normal text
- Touch targets ≥ 44×44px
- Focus states on all interactive elements
- Responsive breakpoints defined (mobile-first)

### Phase 3 — Component Implementation

**Goal:** Build production-ready reactive components using the mockup + design system.

Use the `21st-magic` MCP tool (`mcp__magic__21st_magic_component_builder`) to search for and generate each component. For each component:

1. Pass the design spec (palette, fonts, style) as context
2. Reference the Stitch mockup layout
3. Request the specific component with full interactivity

Build in this order (most to least foundational):
1. Layout wrapper / page shell
2. Navigation / header
3. Primary content sections
4. Interactive elements (forms, buttons, modals)
5. Data display (tables, charts, cards)

**Implementation rules:**
- Use the project's existing stack (check for package.json — React/Next.js/Vue/Svelte)
- Apply Tailwind classes if Tailwind is present
- Use shadcn/ui primitives if installed
- Keep components composable and reusable
- Add loading states and error handling
- Ensure full keyboard accessibility

### Phase 4 — Review

After implementation, do a final check:
- Verify the output matches the Phase 1 mockup
- Confirm the design spec from Phase 2 is applied consistently
- Check responsive behavior at mobile (375px), tablet (768px), desktop (1280px)
- Flag any accessibility issues

## Usage

User says anything like:
> "build a pricing page for Socialise"
> "design a dashboard sidebar with navigation"
> "create a hero section with CTA"
> "full pipeline for the onboarding screen"

Respond by executing all 4 phases in order. Do not skip phases or jump straight to code. The mockup and design system phases prevent wasted implementation effort.

## Related Skills

- `ui-ux-pro-max` — Design guidelines reference (used in Phase 2)
- `page-cro` — Apply after implementation to optimize for conversions
- `copywriting` — Use alongside Phase 3 to fill components with real copy
- `frontend-design` plugin — Use for highly custom or experimental UI

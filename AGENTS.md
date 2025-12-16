# Repository Guidelines

## Project Structure & Module Organization
- `flake.nix` defines inputs (unstable/stable nixpkgs, home-manager, disko, niri, waybar, ghostty) and the `nixosConfigurations.foo` host.
- Core system modules: `configuration.nix` (base OS), `home.nix` (home-manager user config), `niri.nix`, `waybar.nix`, `ghostty.nix`, `packages.nix`, plus hardware/disko files for installs.
- `overlays/` holds package tweaks (e.g., `overlays/waybar.nix`, `overlays/nnn.nix`).
- Dev environment: `devenv.nix` and `devenv.yaml` set up the shell (Node.js, npm, git) and example scripts; `fish/functions/` contains shell helpers.

## Build, Test, and Development Commands
- Enter dev shell: `nix develop` (or `devenv shell`) to load toolchain and scripts.
- Evaluate/format: `nix flake check` to verify flake integrity; `nix fmt .` if you have `nixpkgs-fmt` available to keep Nix files consistent.
- Apply configuration locally: `sudo nixos-rebuild switch --flake .#foo` (or `test` instead of `switch` for a non-persistent check).
- Preview services/UI bits: rebuild and restart the relevant user session; for quick script sanity, use `devenv test` (runs the sample `enterTest` block).

## Coding Style & Naming Conventions
- Nix files: 2-space indentation, trailing commas in attribute sets, and keep inputs/modules sorted where practical.
- Name host-specific modules with the hostname (e.g., `foo` in flake output); place overlays in `overlays/<component>.nix`.
- Prefer small, composable modules over monoliths; keep user-level settings in `home.nix`.
- Shell helpers live under `fish/functions/` using lowercase short names.

## Testing Guidelines
- Primary check is evaluation: run `nix flake check` before proposing changes; fix any eval or formatting failures.
- For system changes, run `sudo nixos-rebuild test --flake .#foo` to validate activation without persisting.
- If altering bar/WM config (`waybar.nix`, `niri.nix`), verify the session after rebuild and capture screenshots of visible changes.

## Commit & Pull Request Guidelines
- Recent history shows terse, lower-case summaries; prefer imperative, descriptive messages (`update waybar modules`, `tune niri workspace rules`) to aid review.
- One logical change per commit; mention affected module (`niri`, `home`, `overlays`) in the summary when possible.
- PRs should describe scope, include command outputs for checks (`nix flake check`, `nixos-rebuild test`), and attach screenshots for UI-facing tweaks.
- Link issues or TODOs if applicable, and call out any required secrets or machine-specific steps.

## Security & Configuration Tips
- Keep secrets out of the repo; use Nix options or environment variables rather than embedding credentials.
- When adding caches or inputs, update `flake.nix` substituters/trusted keys consistently.
- Avoid host-specific paths in shared modules; gate machine-only settings in `configuration.nix` or hardware files.

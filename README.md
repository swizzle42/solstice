# Solstice

A custom atomic OS image built on [Universal Blue](https://universal-blue.org/)'s Aurora (DX, Nvidia open) and Fedora Bootc, using [BlueBuild](https://blue-build.org/).

## What's in it

- **Base:** `ghcr.io/ublue-os/aurora-dx-nvidia-open`
- **Packages:** `niri`, `dms`, `xwayland-satellite`, `nix`, `nix-daemon`
- **System Flatpaks:** Firefox, Bitwarden, Spotify, Obsidian
- Signed with [cosign](https://github.com/sigstore/cosign) via BlueBuild's `signing` module

## Installation

### Rebasing from an existing atomic Fedora system
 
If you're not currently on a `bluebuild`-signed image, first rebase to the unsigned image to get things set up:
 
```bash
sudo bootc switch --transport registry ghcr.io/swizzle42/solstice:latest
```
 
Reboot, then switch to the signed image so future updates are verified:
 
```bash
sudo bootc switch ghcr.io/swizzle42/solstice:latest
```
 
*(If you're on an older `rpm-ostree`-based system instead of `bootc`, use `rpm-ostree rebase ostree-unverified-registry:ghcr.io/swizzle42/solstice:latest` for the first step, then `rpm-ostree rebase ostree-image-signed:docker://ghcr.io/swizzle42/solstice:latest` for the second.)*

### Fresh install
 
Download the ISO from the [Releases](../../releases) page (if published) or build one yourself using the [BlueBuild ISO instructions](https://blue-build.org/how-to/installation/).

## Updates
 
Updates build automatically via GitHub Actions (see `.github/workflows/build.yml`) and are pulled the same way as any other bootc/rpm-ostree image:
 
```bash
sudo bootc upgrade
```
 
## Building locally
 
```bash
bluebuild build ./recipes/recipe.yml
```

The `latest` tag will automatically point to the latest build. That build will still always use the Fedora version specified in `recipe.yml`, so you won't get accidentally updated to the next major version.

## Verification

These images are signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). You can verify the signature by downloading the `cosign.pub` file from this repo and running the following command:

```bash
cosign verify --key cosign.pub ghcr.io/swizzle42/solstice
```

# 🌿 Stoneleaf

**A terminal-based static information system framework for durable, offline-first knowledge libraries.**
Built for resilience, minimalism, and permanence — Stoneleaf serves information with intention, not interruption.

![Built for Terminal](https://img.shields.io/badge/interface-terminal-green)
![Offline-First](https://img.shields.io/badge/offline-supported-brightgreen)
![License: MIT](https://img.shields.io/badge/license-MIT-blue)

---

## 📘 Overview

Stoneleaf is a terminal-based, lightweight information system framework designed to run on basic web or Gopher servers. It delivers static, hierarchically-organized content using simple, durable protocols — making it perfect for low-power devices, grid-down scenarios, and minimalist deployments.

Inspired by organizational systems like Dewey Decimal and Johnny.Decimal, Stoneleaf turns content libraries into navigable, intuitive archives. Whether you're running it on a Raspberry Pi, hosting via Gopher, or accessing via `lynx`, Stoneleaf is designed for permanence and clarity.

---

## 🧩 Key Features

- **Offline-Capable** – Self-hosted, zero external dependencies. Runs from USB, SD, or internal storage.
- **Resilient Protocols** – Supports Gopher and minimalist HTTP (ideal for terminal browsers).
- **Grid-Down Friendly** – Optimized for Raspberry Pi, PocketCHIP, and other SBCs.
- **Immutable by Design** – Static content discourages constant editing; encourages stewardship.
- **Highly Portable** – Zip and migrate easily using SSH, rsync, S/FTP, torrent, or magnet links.
- **Structured Simplicity** – Uses a clear directory tree inspired by library science for easy navigation.

---

## 🌐 Supported Protocols & Tools

### Gopher

- Minimal ASCII/text format
- Hierarchical directories
- Ultra-lightweight and fast on poor connections

**Recommended Tools:**

- [RFC 1436 – Gopher Protocol](https://tools.ietf.org/html/rfc1436)
- [Gophernicus](https://gophernicus.org) – Lightweight Gopher server
- [geomyidae](https://tildegit.org/sloum/geomyidae) – Tiny Gopher daemon
- Terminal Clients: `lynx`, `gopher`, `gophers`

---

### HTTP (Static HTML)

- Compatible with both terminal and graphical browsers
- Pure HTML navigation
- Serve via built-in or lightweight servers

**Recommended Tools:**

- [RFC 1945 – HTTP/1.0](https://tools.ietf.org/html/rfc1945)
- [RFC 1866 – HTML 2.0](https://tools.ietf.org/html/rfc1866)
- `python3 -m http.server` – Simple local hosting
- [BusyBox HTTPd](https://busybox.net/downloads/BusyBox.html)
- [Darkhttpd](https://unix4lyfe.org/darkhttpd)

---

## 📚 Philosophy

Rebelling against the age of constant connectivity, fleeting content, and paywalls, Stoneleaf offers an alternative: a **resilient, slow, and intentional archive**. It resists complexity by embracing simplicity, and it values authorship over algorithm.

- Designed for environments with unstable power, poor connectivity, or old hardware
- Information is curated and organized for long-term utility — not real-time noise
- Promotes digital stewardship: thoughtful curation over hasty updates
- Transparent and understandable by anyone

> “The structure is not just a file tree — it's a mental map.”

---

## 🗂 Suggested Directory Structure

Stoneleaf uses a methodical, numeric directory system (inspired by Dewey Decimal and Johnny.Decimal). Each category lives within a `/library` directory, and can include text, markdown, or HTML files.

### 📁 Example Tree

```plaintext
library/
├── 00.reference/
│   ├── 00.00.index/
│   │   └── dir.tree.txt
│   ├── 00.01/
│   └── 00.02/
├── 01.subject/
├── 02.resources/
...
```

### 🧾 Generate Index

Use this command to generate an index file of your tree:

```bash
tree > sldirtree.csv && mv sldirtree.csv 00.reference/00.00.index/
```
This file should then be placed in the `00` directory.

---

## 🏗 Build the Initial Library

Run the included `dirgen.sh` script to create a blank scaffold (10,100 folders total):

```bash
#!/bin/bash

for i in {0..99}; do
    top_dir=$(printf "%02d" "$i")
    mkdir -p "$top_dir"
    for j in {0..99}; do
        sub_dir=$(printf "%02d" "$j")
        mkdir -p "$top_dir/${top_dir}.${sub_dir}"
    done
done
```

Place the provided `index.php` or an HTML index file in the root directory to enable browsing.

---

## ☁️ Hosting & Syncing

### Local Instance

- No server required
- Viewable with file-based terminal or GUI browsers
- Ideal for offline or read-only systems

### Remote Sync

Use `rsync` to mirror a local copy to a remote host:

```bash
sudo rsync -avh --delete ~/stoneleaf/local/ user@[SERVER]:/path/to/library
```

- Adds new local files to remote
- Deletes removed local files from remote
- Preserves local structure as authoritative

Ensure `rsync` is installed on the remote machine.

---

## 📥 Populating the Library

- Prefer `.txt`, `.md`, or `.html` for maximum compatibility
- Avoid dynamic content or scripts
- Audio or video files can be added but will need to be downloaded to play unless browser is capable

Keep it readable with terminal tools and future-proof for minimal devices.

---

## 🔄 Sharing & Downloading

To share your Stoneleaf instance:

- Host publicly via HTTP or gopher
- Offer `.zip` archives for download
- Create magnet links to share archives
- Support `wget`, `curl`, or `httrack` for retrieval

**Stoneleaf is designed for duplication.**

---

## 📁 Examples

Coming soon: the `examples/` folder will contain:

- Sample index HTML file
- Example Gophermap
- Text article template
- Screenshot of `lynx` browsing a Stoneleaf library

---

## 📄 License

This project is licensed under the **MIT License**. See [`LICENSE`](https://mit-license.org/) for details.

---

## 🌍 Learn More

- [Johnny.Decimal System](https://johnnydecimal.com/)
- [The Gopher Project](https://gopher.floodgap.com/)
- [Slow Web Movement](https://www.sloww.co/slow-web/)

---

> “When the cloud fails, let your archive stand.”
```
# StoneLeaf

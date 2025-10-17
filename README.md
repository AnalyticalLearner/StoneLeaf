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

A StoneLeaf library is not just a bunch of folders on a web server, rather each library is a declaration of the importance of the data within.     
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
- [Apache Web Server](https://httpd.apache.org/)
- `python3 -m http.server` – Simple local hosting
- [Darkhttpd](https://unix4lyfe.org/darkhttpd)

---

### Required Packages
These packages are *not* included in this repository.

- Web server (Apache 2, Nginx, etc.)
- tree
- rsync
- openssh-server

---

## 📚 Philosophy of Use

Rebelling against the age of constant connectivity, fleeting content, and paywalls, Stoneleaf offers an alternative: a **resilient, static (aka stable), and intentional archive**. It resists complexity by embracing simplicity, and it values authorship over algorithm.

- Designed for environments with unstable power, poor connectivity, or old hardware.
- Information is curated and organized for long-term utility and not real-time noise.
- Promotes digital stewardship: thoughtful curation over hasty updates.
- Transparent and understandable by anyone.
- StoneLeaf seeks to reignite the value of information before the information is locked away.
- This not about shuttling copyrighted works as much as it is about preserving information and thus culture, history, and education.

> “The structure is not just a file tree — it's a mental map.”

### 
This framework is built on the principle of durable knowledge in unstable times. In an age of constant connectivity, dynamic content, and digital manipulation, this system serves as a counterbalance: a quiet, resilient archive of trustworthy information that is not easily changed, lost, or corrupted. Its design encourages deliberate authorship and careful curation rather than reactive publishing. The goal is to serve static information with purpose, offering clarity and utility where speed and noise often dominate.

Unlike modern web platforms that depend on scripts, clouds, and servers that can vanish or fail without notice, this framework thrives in minimalist, offline-first environments. It assumes conditions where the power grid may be unreliable, internet access is unavailable, or devices must operate with extreme frugality. The framework is optimized for single-board computers, old hardware, and terminal-based browsers, enabling deployment in environments ranging from rural villages to emergency response stations to remote homesteads.

Information is organized in a deep, methodical hierarchy inspired by systems like Dewey Decimal or Johnny.Decimal. This reinforces the philosophy that organization enhances longevity. Each category, file, and entry point is crafted to be intuitive to navigate without the aid of search engines or GUIs. The structure itself becomes part of the user's understanding — a mental map as much as a file tree.

Importantly, this system encourages a kind of digital stewardship: content is meant to be maintained, not updated hastily. Its simplicity is its security; its transparency is its authority. The use of open protocols like Gopher and plain HTTP means anyone can understand how it works, replicate it, and extend it without proprietary tools. The philosophy is not just about resisting complexity — it is about reclaiming control over how, when, and where knowledge is accessed.


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

---

## 🏗 Build the Initial Library

Run the included `dirgen.sh` script in your destination folder to create a blank scaffold (10,100 folders total). The script content is below.

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

### 🧾 Generate Index

Use this command to generate an index file of your tree:

```
tree -a -I '.*' > tree.txt
```
This file should then be placed in the `00` directory.

---

## ☁️ Hosting & Syncing

### Local Instance

- No server required
- Viewable with file-based terminal or GUI browsers
- Ideal for offline or read-only systems

### Remote Hosting
- Install a basic web server
- Deploy StoneLeaf directories at the root or  in a `/stoneleaf` directory.

### Remote Sync

Use `rsync` (or SFTP) to mirror a local copy to a remote host:

```bash
sudo rsync -avh --delete ~/stoneleaf/local/ user@[SERVER]:/path/to/library
```

- Adds new local files to remote
- Deletes removed local files from remote
- Preserves local structure as authoritative

*Ensure `rsync` is installed on the remote machine.*

---

## 📥 Populating the Library

- Prefer `.txt`, `.md`,  `.csv`, or `.html` for maximum compatibility.
- Avoid dynamic content or scripts.
- Audio or video files can be added but will need to be downloaded to be played unless browser is capable of playing from the HTTP source.

Keep it readable with terminal tools and future-proof for minimal devices.

---

## 🔄 Sharing & Downloading

To share your Stoneleaf instance:

- Host publicly via HTTP(s) or gopher.
- Offer `.zip` archives for download.
- Create magnet links to share archives.
- Include links to other StoneLeaf libraries from within your own using the `peers.md` file.

**Stoneleaf is designed for duplication.**

---

## 📄 License

This project is licensed under the **MIT License**. See [`LICENSE`](https://mit-license.org/) for details.

---

## 🌍 Learn More

- [Johnny.Decimal System](https://johnnydecimal.com/)
- [The Gopher Project](https://gopher.floodgap.com/)

---

> “When the cloud fails, let your archive stand.”


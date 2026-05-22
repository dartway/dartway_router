# Contributing to DartWay

Thank you for your interest in contributing to **DartWay**!
We appreciate all improvements — from small fixes to major features.

---

## 🧩 How to contribute

1. **Fork** the repository and create a feature branch.
2. Make your changes and ensure that tests and formatting pass.
3. Commit with a **Signed-off-by** line (see below).
4. Open a Pull Request with a clear description of what you've done.

---

## ✅ Developer Certificate of Origin (DCO)

All commits must include a `Signed-off-by` line. This certifies that you have the right to submit your contribution under the project's license.

To sign your commits, use:

```bash
git commit -s -m "your message"
```

This adds a line like:

```
Signed-off-by: Your Name <your@email.com>
```

**If the DCO check fails**, one or more commits are missing the sign-off. Fix it with:

```bash
git rebase HEAD~N --signoff
git push --force-with-lease origin <your-branch-name>
```

Replace `N` with the number of unsigned commits.

💡 **Tip:** Create a shortcut for signed commits:

```bash
git config --global alias.c "commit -s -m"
# Then just use:
git c "Add feature X"
```

Full DCO text: https://developercertificate.org

---

## 🔒 Licensing and third-party code

- All contributions are licensed under **Apache License 2.0**.
- If you include third-party code:
  - Confirm it's compatible with Apache-2.0.
  - Include the original copyright notice and license.
  - Mention the source in your PR description.

---

## 🧠 Need help?

Open a **GitHub Discussion** or contact the maintainers.

Thanks for helping make DartWay better!
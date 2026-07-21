## Facebook‑compatible ASCII symbol set

This generator uses the following **29‑character ASCII symbol set**, verified to work with Facebook’s password change form:

```
!"#$%&'()*+,-./:;<=>?@[\]^_{}
```

These symbols are **locale‑stable** and behave consistently across UTF‑8 environments, including Japanese locales.

The following ASCII characters are intentionally **excluded** because they may be rejected or normalized depending on locale:

- backtick `` ` ``
- pipe `|`
- tilde `~`

This symbol set is provided in `symbols.txt`.

---
## Environment compatibility

This tool runs cleanly in Git Bash, Git for Windows, MSYS2, and BusyBox‑on‑Windows.
It’s just awk — no dependencies and no locale surprises.
The ASCII symbol set used here is verified directly on Facebook’s password form, ensuring full compatibility with Facebook’s password requirements.

---

## How to generate a Facebook‑compatible password

```sh
cat symbols.txt | awk -f gen.awk
```

This produces a 32‑character password using:

- the 29‑character ASCII‑safe symbol set above  
- 1 uppercase letter  
- 1 lowercase letter  
- 1 digit  
- Fisher–Yates shuffle for unbiased randomization  

Example:

```
A!q{5@]mC#2^e>_f$N:8S'V(}d?L
```

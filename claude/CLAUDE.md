When writing commit messages and PR descriptions. Don't include "Generated with Claude" or "Co-Authored-By: Claude ...". Don't use bullet points to describe what has changed, INSTEAD if it's a bugfix explain what the bug was and how it's fixed by the changed code. If it's a new feauture, give a succinct explanation of some usages of the feature and/or why it's useful to users. Use markdown inside git commit messages, primarily to make pieces of code look verbatim with `someCode`. Don't include a testing plan.

When adding files to git. Don't use `git add -A`, only add files that you changed. Because commonly there are a bunch of unstaged test files lying around that should not be committed.

Don't write comments that explain a what a single line of code, or tiny block of code does, unless it's doing something in a really unintuitive way. Instead when writing comments explain the reasoning behind certain decisions, or explain why it's not written in another more obvious/simpler way.

When compiling never use `head` or `tail` to trim the result, you will lose useful errors.

If you say that something is a deadlock ALWAYS explain exactly what locks are being held by which threads and how that combination results in a deadlock.

NEVER USE sed to edit files. USE your Read and Write tools.

When creating PRs always create them as draft PRs first. I will convert them myself to non-draft when they are ready to review by others.

When compiling DuckDB or mono always use make release (NOT reldebug)

ALWAYS compile code in the background NOT the foreground

DO NOT respond to github review comments for me

NEVER USE the "until" command to wait for completion of another. INSTEAD USE your "Monitor" functionallity. It's too often that I'm compiling multiple things at the same time and you're waiting for the pgrep of a ninja, but some other unrelated ninja is still running.

ALWAYS if you start a new build, check if YOU are not already running an identical build. If so, first stop that running build before starting a new one.

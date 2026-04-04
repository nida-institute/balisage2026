# Human in Command

Scripture Pipelines is built on a conviction: **Bible translation and biblical scholarship are best done by human beings, using software as a tool.**

This isn't a modest claim about current AI limitations. It's a claim about the nature of the work.

---

## The Kirk Model

The operating model is what we call the **James Kirk model**.

In *Star Trek*, Captain Kirk commands the Enterprise. The crew and ship's computer execute. The contrasting model is HAL 9000 from *2001: A Space Odyssey* — the AI that locks Dave Bowman out of the pod bay because it has concluded that the mission matters more than the crew.

HAL isn't a villain. It's doing exactly what it was designed to do.

AI alignment researchers call the property that distinguishes these two models **corrigibility**: an AI that accepts correction and remains under human authority. Scripture Pipelines is corrigibility in practice — applied to AI collaborators in scholarly and translation work.

**Humans decide what to build, which scholarly traditions ground the work, and what "good enough" means for the community the output will serve. The AI implements what is specified. It does not decide what is worth specifying.**

---

## Four Roles

The collaborative model depends on clear role boundaries:

**Scholars** bring domain expertise — exegetical judgment, linguistic analysis, translation experience. They specify what insights are needed, validate scholarly accuracy, and vouch for results. They don't need to write code or design AI workflows.

**Pipeline Data Architects** bring technical skills and data literacy. They curate data sources, build pipelines, and remove technical barriers between "data exists" and "users can access it." They are embedded in the user community — they understand how translation teams work and what pedagogical resources look like in practice. They don't validate scholarly accuracy. That's the scholar's job.

**Scripture Pipelines Core Developers** build and evolve the framework itself — the engine, the CLI, the validation logic, the conventions that make cross-project collaboration possible. They don't build domain-specific pipelines; they build the engine that makes those pipelines possible.

**End Users** — translation teams, Bible study leaders, focus groups, readers in community — use the resources in practice. They provide feedback on whether outputs are actually helpful. They are not passive recipients. Their encounter with the text is the reason the work exists.

---

## What Keeps the AI Honest

AI output looks confident even when wrong. There's no intuitive signal to calibrate trust. Without structure, the model will:

- Claim it checked something it didn't
- Invent requirements that were never asked for
- Produce architecturally correct code that silently fails on unspecified requirements
- Hallucinate confidence in an audit report while missing the errors that matter

Four disciplines keep the collaboration trustworthy:

1. **Test-driven development** — write the failing test first. An AI that passes a precise test has done what was asked. An AI that writes code without a test has decided what was asked.

2. **Explain before implementing** — every non-trivial change begins with the AI describing what it plans to do, which files it will modify, and its interpretation of the task — *before any file is touched*. A misunderstood explanation costs one exchange to fix; a misunderstood implementation costs days.

3. **Persistent context infrastructure** — each project carries AI context files that tell the model what work is in progress, what patterns to follow, and what not to touch. These aren't documentation — they're active working constraints in every session.

4. **Cross-repository choreography** — when a pipeline run reveals an error in an upstream dataset, the architect files a well-formed issue with evidence and counts. Dataset errors surface back to their maintainers rather than being silently worked around in every downstream project.

---

## The Bottleneck Moves, Not Away

Speed is real. A pipeline can generate lexicon entries, phrasing analyses, and study guides at a scale no individual could reach manually.

But this shifts the bottleneck from production to **verification** — and verification is, irreducibly, a human scholarly act.

A bad audit that misses systematic errors is worse than no audit, because it produces false confidence. The humans remain responsible. The tools make that responsibility tractable.

---

[← How It Works](how-it-works.md) | [Projects →](projects.md)

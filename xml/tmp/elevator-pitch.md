# Scripture Pipelines Elevator Pitch

**For: Bible geek AI programmers**

---

## The Problem

Biblical scholarship is drowning in open data — morphological annotations, syntactic treebanks, discourse markup, lexicons, papyri transcriptions — but lacks the human capacity to synthesize it at scale. Datasets built by one scholarly community remain invisible to others. The bottleneck isn't data; it's rigorous human analysis.

## The Solution

**Scripture Pipelines**: Declarative YAML-based AI workflows for biblical scholarship. Each pipeline step declares a contract (inputs, prompt, outputs). Every intermediate result is saved. Scholars can audit one step at a time, rerun with updated prompts without redoing upstream work, and verify that AI followed instructions.

## Why It Works

**James Kirk Model**: Human commands, AI executes. Not autonomous agents deciding what to build — corrigible collaborators under human authority.

## Four Roles

- **Scholars**: Domain expertise (exegesis, linguistics, translation). Validate accuracy, vouch for results. Don't need to code.
- **Pipeline Data Architects**: Technical skills + data literacy. Build infrastructure, design workflows, curate data sources. Embedded in user communities (know how Bible study groups actually work).
- **Scripture Pipelines Core Developers**: Build the framework itself — engine, CLI, test suite, step types. Not domain-specific pipelines.
- **End Users**: Translation teams, Bible study leaders, readers in community. Use resources, provide feedback on what actually helps.

## Four Disciplines (AI can offload most of the work)
1. **TDD**: Spec → AI writes tests → AI implements. Tests determine if it worked.
2. **Explain-before-implementing**: AI describes its plan before touching files — catches misunderstandings before they become commits.
3. **Persistent context**: `.github/copilot-instructions.md` (repo constitution), `docs/ai-context/` (data sources, pipeline language, goals), `project/TODO.md` (active work, linked to issues/boards).
4. **Cross-repo choreography**: AI creates issues, adds comments, maintains project boards. GitHub is the communication bus.

## Production Use

Multiple Nida Institute projects generating freely licensed resources: lexicons, grammatical analyses, discourse structures, Bible study guides. Case study: **Ears to Hear** leaders' guide generation.

## The Vision

**Kairos Project**: Global community of scholars serving Bible translation and the global church. Not just Western academics — translation teams, oral cultures, multilingual learners. AI makes scholarly insights accessible in forms these communities can actually use. Communities talk with each other; insights flow both directions.

## Bottom Line

Reproducible, auditable, AI-assisted biblical scholarship at scale — built for human accountability, serving global communities.

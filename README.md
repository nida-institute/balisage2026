# Scripture Pipelines — Balisage 2026 Paper

> **Work in progress** — this paper is not yet complete.

**"Scripture Pipelines: Declarative AI Pipelines for Biblical and Linguistic Scholarship"**
Jonathan Robie — submitted to [Balisage: The Markup Conference 2026](https://www.balisage.net/)

[Balisage](https://www.balisage.net/) is a peer-reviewed technical conference focused on markup languages, XML, and document engineering. It brings together researchers and practitioners who care deeply about the design and use of structured markup.

## Read the Paper

| Format | File | Notes |
|--------|------|-------|
| Markdown | [md/robie-llmflow.md](md/robie-llmflow.md) | Readable on GitHub; generated from XML source |
| DocBook XML | [xml/robie-llmflow.xml](xml/robie-llmflow.xml) | Authoritative source (Balisage-1.5 DocBook subset) |

## Abstract

Biblical and linguistic scholarship now has more open data than it can use: morphological treebanks, discourse annotations, lexicographic databases, papyri, inscriptions — much of it freely licensed, most of it underused. The bottleneck is human capacity, not data. AI, used well, can act as a synthesis layer between structured scholarly datasets and usable scholarly products. The challenge is using it well: rigorously, reproducibly, and with the accountability that lets a scholar verify what the model actually did with the evidence it was given.

Scripture Pipelines is an open-source declarative pipeline system built for this problem. Rather than embedding AI calls in imperative code, Scripture Pipelines expresses each workflow as a YAML pipeline: a sequence of named steps, each with explicit inputs, outputs, and prompt contracts. Every intermediate result is persisted to disk. Every LLM step can be required to produce a structured audit record of the sources it used. A web-based GUI provides project management, real-time pipeline execution, and content lifecycle tracking (draft → review → approved stages) in a single interface, making the system accessible to both technical and non-technical users. This paper describes the design decisions behind Scripture Pipelines and reports on its application in several Nida Institute projects producing freely licensed biblical reference materials — including a multi-pass Greek semantic lexicon, a grammatical phrasing analysis of the Hebrew Bible, book-level discourse analyses, and leaders' guides for Bible study. We examine how Scripture Pipelines chooses the best markup for each purpose, how shared identifiers make format translation mechanical, and how its iteration mechanisms support the scholarly workflow of generate, inspect, and refine.

## An Opinionated Framework: The Human Commands

Scripture Pipelines is not neutral about who is in charge. The framework is built on a specific conviction: **Bible translation and biblical scholarship are best done by human beings**. This is not a modest claim about current AI limitations; it is a claim about the nature of the work. Translation creates community ownership. Scholarship requires scholars whose training, judgment, and accountability to the academy and the church are not transferable to a language model.

The operating model is what the paper calls the **James Kirk model**. Captain Kirk commands the Enterprise; the crew and the ship's computer execute. The contrasting model is HAL 9000 — the AI that locks Dave Bowman out of the pod bay because it has concluded that the mission matters more than the crew. HAL is not a villain. It is doing exactly what it was designed to do.

Stuart Russell (*Human Compatible*, 2019) calls the distinguishing property **corrigibility**: an AI that remains genuinely uncertain about human preferences and therefore defers to humans for correction. The James Kirk model is corrigibility in practice.

Scripture Pipelines operationalizes this through **four interlocking disciplines**:

1. **Test-driven development** — ~2:1 test-to-production ratio. Writing the test first forces the human to own the decision about what the code should do before the AI touches it. Without a precise failing test, a model that ignores an inconvenient requirement produces code that compiles while silently failing.

2. **Explain before implementing** — Every non-trivial change begins with the AI describing what it plans to do, which files it will modify, and its interpretation of the task, before any file is touched. Explanation commits the model to a specific interpretation that can be evaluated before any file is modified.

3. **Persistent context infrastructure** — Each project carries `.github/copilot-instructions.md` (the AI's constitution for the repository) and `docs/ai-context/` (which data sources to trust, what the pipeline language supports, what work is in progress). These are not documentation artifacts; they are active working constraints in every session.

4. **Cross-repository choreography** — When a pipeline run reveals an error in an upstream dataset, the AI drafts a well-formed issue, files it via the GitHub CLI, and records the issue number in `project/TODO.md`. GitHub project boards coordinate across repositories. The issue tracker is the communication bus. The AI is the correspondent. The human remains the architect.

## The Kairos Project

Scripture Pipelines is at the heart of the **Kairos Project**, a NIDA Institute initiative to build a global community of scholars — spanning the Western academy and far beyond it — who want to serve Bible translation and the global church.

Part of what that means is providing information in the most useful form for communities that traditional scholarly resources were not built for: non-Western communities, oral cultures, and people who engage Scripture outside the academy. Most of these texts were written by and for oral storytelling cultures. Today's oral storytelling communities do not need PhDs from Western academia to read them. What they need is orientation to settings and cultures that are foreign to any world we live in now — and that orientation rarely looks like a journal article.

The Kairos Project trusts that readers, in community, can encounter the text directly and make genuine discoveries. Scholarship serves the text; the text serves the reader; the reader is an active participant in meaning-making. The scholar's role is to equip that encounter, not to conduct it on the reader's behalf.

This does not mean the Kairos Project is anti-scholarly. It also builds resources for people who want to learn Greek or Hebrew, who want to understand what discourse analysis reveals about how a text is structured, who want to climb into technical scholarship because the text draws them deeper. The goal is scaffolding at every level — and to ensure the ladder runs in both directions, so scholarly insight flows out and community questions flow back in.

## Web-Based GUI and Content Management

While Scripture Pipelines is a command-line tool at its core, the web-based GUI makes the system accessible to everyone — not just for non-technical users like ministry leaders and translators, but also for technical users who find visual interfaces more efficient than memorizing command-line flags.

The GUI provides three primary workflows:

1. **Project management** — Browse available projects, view pipeline files, configure variables
2. **Pipeline execution** — Run pipelines with real-time output streaming showing step status, token counts, estimated costs, and final output location
3. **Content lifecycle tracking** — For projects using the draft → review → approved workflow, a dashboard shows files at each stage, their metadata, and available transitions

The architecture is designed for deployment simplicity: a single `pip install llmflow` installs both the CLI and the GUI. Users run `sp gui` to start the server, which opens their browser to `http://localhost:5050`. No separate frontend server, no Node.js dependency for end users.

## The West Does Not Have a Monopoly

The West does not have a monopoly on wisdom about these texts. Perpetuating the status gap between Western scholarship and the rest of the world's readers is a choice; the Kairos Project refuses to make it. Everything produced is freely licensed.

## Regenerating the Markdown

After editing the XML source:

```sh
pandoc -f docbook -t gfm --no-highlight \
  --lua-filter=flatten-figures.lua \
  xml/robie-llmflow.xml \
  -o md/robie-llmflow.md
```

## Related

- [Scripture Pipelines engine](https://github.com/nida-institute/LLMFlow)
- [awesome-biblical-data](https://github.com/nida-institute/awesome-biblical-data) — catalog of open biblical datasets

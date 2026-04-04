# What Scripture Pipelines Does

Scripture Pipelines is the infrastructure at the heart of the Kairos Project — a declarative pipeline system that lets scholars harness AI to bridge structured scholarly datasets and usable resources for communities worldwide.

Instead of embedding AI calls in imperative code, Scripture Pipelines expresses each workflow as a **YAML pipeline**: a sequence of named steps, each with explicit inputs, outputs, and prompt contracts.

---

## The Core Idea

Think of it as a reproducible, auditable assembly line for scholarly work.

Each pipeline step does one thing:

- Gather evidence from a dataset
- Call an LLM with a specific prompt and structured inputs
- Parse and validate the response
- Save intermediate results to disk
- Pass outputs to the next step

Every result is persisted. Every LLM step can be required to produce a structured record of the sources it used. The scholar can inspect exactly what happened at each stage.

---

## What It Produces

Current Nida Institute projects using Scripture Pipelines include:

| Project | What It Produces |
|---|---|
| **SemLex Greek** | Multi-pass semantic lexicon of New Testament Greek |
| **Hebrew Phrasing** | Grammatical phrasing analysis of the Hebrew Bible |
| **Discourse Flow** | Book-level discourse analyses using Levinsohn annotations |
| **Ears to Hear** | Leaders' guides for Bible study |

All of it freely licensed — built to serve the Kairos mission of equipping communities worldwide.

---

## Format for Every Purpose

Scripture Pipelines uses the right format for each job:

- **YAML** — for pipeline declarations (readable by humans and LLMs)
- **JSON** — for intermediate results (structured, auditable, inspectable)
- **Markdown** — for human-facing outputs (reviewable by scholars and editors)
- **USX 3.1** — for integration with Bible translation and publishing workflows

The canonical source of truth at every stage is the persisted JSON. Everything else is rendered from it.

---

## The Data It Draws On

Pipelines connect to scholarly datasets that are often unknown outside their own communities:

- **Macula Hebrew/Greek** — word-level morphological annotations for the entire Bible
- **Levinsohn LGNTDF** — discourse feature annotations for the Greek New Testament
- **ACAI** — biblical entity annotations (people, places, keyterms) anchored to the text
- **SBLGNT** — base Greek text of the New Testament
- **Perseus TEI, papyri.info, EpiDoc corpora** — the wider Hellenistic world

These aren't afterthoughts. They're the foundation. The LLM synthesizes; the data provides the evidence.

---

## The Name

The name *Scripture Pipelines* reflects its primary design community. But the same infrastructure applies equally well to classical literature, patristics, and other ancient or historical corpora — wherever structured scholarly datasets need to be synthesized at scale. The name names the context, not the limit.

---

[← The Need](need.md) | [How It Works →](how-it-works.md)

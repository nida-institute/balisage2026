# Projects

These are live Nida Institute projects producing freely licensed biblical reference materials using Scripture Pipelines. Each is a concrete example of the Kairos vision: scholarly rigor, openly accessible, built for communities worldwide.

---

## SemLex Greek

**A multi-pass semantic lexicon of the Greek New Testament**

Each lemma goes through a sequence of pipeline passes:

1. **Gather evidence** — corpus citations, Abbott-Smith entries, papyrus parallels, usage in the Hellenistic world
2. **Build senses** — structured JSON sense inventory, with accountability fields requiring the LLM to enumerate every Abbott-Smith sense it was given and record whether it was retained, transformed, or unsupported by evidence
3. **Verify citations** — spot-check that the model engaged with the sources rather than hallucinating glosses
4. **Render entry** — final Markdown formatted for scholarly review and editorial work

The pipeline handles gathering and organizing evidence at a scale no lexicographer could manually sustain. The scholar reviews the synthesis and catches what only subject-matter expertise can recognize.

---

## Hebrew Phrasing

**Grammatical phrasing analysis of the Hebrew Bible**

Built on Macula Hebrew TSV data — word-level morphological annotations for the entire Hebrew Bible, including lemma, gloss, part of speech, stem, conjugation, person/gender/number, and pronominal suffix data.

The pipeline chunks the text by verse, applies structured phrasing analysis via LLM, and produces intermediate JSON that includes the original Macula token data alongside the phrasing decisions — making it possible to spot when a parse deviates from the morphological input.

Retry conditions handle truncated outputs: if the phrasing analysis is shorter than expected or ends mid-phrase, the step reruns automatically with the attempt number injected into the prompt.

---

## Discourse Flow

**Book-level discourse analyses grounded in Levinsohn annotations**

The Discourse Flow pipeline uses Steven Levinsohn's LGNTDF discourse feature annotations — 806 word-level annotations for 1 John alone — as the sole basis for pericope segmentation. The LLM is explicitly prevented from imposing chapter or verse divisions.

Intermediate JSON includes the Levinsohn feature annotations that informed each pericope boundary, so a scholar can verify that the model's segmentation decision was grounded in the pre-computed structural data.

A `--stop-after segment_book` checkpoint lets a scholar verify pericope boundaries before the expensive per-pericope loop runs.

---

## Ears to Hear

**Leaders' guides for Bible study**

A pipeline that generates study guides for communities reading Scripture together — questions that help a group notice what is actually in the text, rather than questions that presuppose Western academic background.

The `enrich_passage` step gives the LLM access to MCP tools: it fetches passage text, then looks up entities it encounters, then retrieves word-sense data for terms it judges significant — potentially 40 tool calls within a single step. The model decides the retrieval sequence; the pipeline declares which tools are available.

Outputs are reviewed by focus groups — translators, pastors, study leaders — who report whether the materials actually work for communities that are not specialists. Their feedback shapes the next pipeline iteration.

---

## What These Projects Share

- Everything produced is **freely licensed**
- Every intermediate result is **persisted to disk** and inspectable
- **Scholars validate** the outputs — the pipeline doesn't vouch for itself
- **Focus groups of end users** test whether resources work in practice
- The goal is equipping communities worldwide, not producing conclusions for them

---

[← Human in Command](human-in-command.md) | [Home →](index.md)

# The Need

## More Data Than Anyone Can Use

Biblical and linguistic scholarship now has more open data than it can use:

- Word-level morphological annotations for the entire Hebrew Bible and Greek New Testament
- Syntactic treebanks encoding decades of scholarly analysis
- Discourse feature datasets (806 word-level Levinsohn annotations for 1 John alone)
- Lexicographic databases aggregating multiple traditions
- Documentary papyri and inscriptions in EpiDoc XML
- Alan Bunning's transcriptions of every early Greek New Testament manuscript — freely available

Much of it freely licensed. Most of it underused.

---

## The Real Bottleneck

The underuse isn't only a scale problem. Much of this data is simply *unknown* to the scholars who would benefit most from it.

Biblical studies, linguistics, text encoding, lexicography, papyrology, and Bible translation each have their own communities, conferences, and conventions — and the datasets built within one community often remain invisible to another.

- A lexicographer may not know about a discourse annotation dataset that would transform their approach to semantic range
- A translation team may not know that the morphological analysis they need was completed a decade ago and is freely licensed

**No single organization commands the full range of expertise required to connect these worlds.**

---

## What AI Can't Do Alone

The typical approach to AI-assisted scholarship is ad hoc: a Python script calls an API, loops over a word list, and writes results to files.

This fails as a sustainable scholarly practice:

- Results are not reproducible because prompts are embedded in code
- Intermediate outputs aren't preserved, so failures require recomputation from scratch
- The relationship between input, prompt, and output is opaque
- Iteration requires modifying code rather than configuration

And beyond infrastructure: AI output looks confident even when wrong. An unchecked language model is no more reliable than an unchecked student paper. **The world has enough ChatGPT-generated text that no one can vouch for.**

What it doesn't have enough of is AI-assisted scholarly work that is transparent, auditable, and freely licensed.

---

## What's Needed

A system that:

1. Expresses workflows as configuration, not code
2. Persists every intermediate result so scholars can inspect what happened
3. Requires AI to account for the sources it was given
4. Makes iteration fast — revise a prompt, rerun one step, compare before and after
5. Keeps humans in command throughout

That's what Scripture Pipelines is built to do.

---

[← The Kairos Project](kairos.md) | [What Scripture Pipelines Does →](what-it-does.md)

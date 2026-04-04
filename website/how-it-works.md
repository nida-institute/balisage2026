# How It Works

A Scripture Pipelines pipeline is a YAML file. It declares a name, optional global settings, and a sequence of steps. Each step reads from a shared context and writes its output back to it.

---

## A Simple Example

```yaml
name: semlex-singlepass

variables:
  lemma: "ἀγαπάω"
  output_dir: "output/agapao"

llm_config:
  model: gpt-4o
  temperature: 0.4

steps:
  - name: gather-evidence
    type: llm
    prompt:
      file: prompts/gather-evidence.gpt
      inputs:
        lemma: "${lemma}"
        corpus: "${corpus_data}"
    output_type: json
    outputs: evidence
    saveas: "${output_dir}/gather-evidence.json"

  - name: build-senses
    type: llm
    prompt:
      file: prompts/build-senses.gpt
      inputs:
        lemma: "${lemma}"
        evidence: "${evidence}"
    output_type: json
    outputs: senses
    saveas: "${output_dir}/senses.json"
```

Run it like this:

```
sp run --var lemma="ἀγαπάω"
```

---

## Step Types

**`type: llm`** — calls an AI model with a prompt file and named inputs. Responses can be parsed as JSON, making their fields available to later steps.

**`type: function`** — calls a Python function for deterministic processing: loading data, parsing references, rendering templates, filtering results.

**`type: for-each`** — iterates over a list, running a block of steps for each item. Results accumulate across iterations. Supports nesting (every verse within every pericope within every book).

**`type: if`** — guards a block of steps behind a condition. When false, the entire block is skipped.

---

## Prompt Contracts

Every prompt file declares the variables it requires:

```
---
requires:
  - lemma
  - evidence
optional:
  - prior_senses
---
For the lemma {{lemma}}, using the following evidence:

{{evidence}}

Produce a JSON sense inventory. For each sense, include an
"abbott_smith_audit" field listing every Abbott-Smith entry you
were given, recording whether you retained, transformed, or could
not support it with corpus evidence.
```

The linter validates that the pipeline supplies every required variable *before* execution begins. The `abbott_smith_audit` field is an accountability contract: by requiring the LLM to enumerate its sources, you can verify whether it actually engaged with the evidence it was given.

---

## Debugging: Two Key Flags

**`--stop-after STEP`** — runs the pipeline to a named step and halts, leaving intermediate outputs on disk for inspection.

**`--rewind-to STEP`** — reruns from a named step forward, reading all prior outputs from disk. No recomputation.

Together these make the core iteration loop — inspect, revise a prompt, rerun from that step — take seconds rather than hours, even in pipelines that are expensive to run from scratch.

---

## The Audit Trail

Every intermediate file is saved to disk. For a Greek lexicon, this produces a tree keyed on Greek characters:

```
output/intermediate/
  ἀγ/
    ἀγαπάω.gather-evidence.json
    ἀγαπάω.senses.json
    ἀγαπάω.entry.md
  πι/
    πιστεύω.gather-evidence.json
    πιστεύω.senses.json
    ...
```

Each lemma's full multi-pass output lives together under its prefix. This makes it natural to open any entry, inspect exactly what each pipeline pass produced, and verify that the model engaged with its sources.

The directory tree is also the audit trail — committed to version control, it records the provenance of every generated artifact.

---

[← What Scripture Pipelines Does](what-it-does.md) | [Human in Command →](human-in-command.md)

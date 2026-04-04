# XML Vision and LLMs: From Bosak 1997 to AI 2026

**Context:** Last Balisage conference. Need to address how Bosak's 1997 XML vision relates to today's AI/LLM landscape.

**Source:** https://www.xml.com/pub/a/w3j/s3.bosak.html

---

## What Worked Beautifully

### Human-Readable Formats (The Core Insight)

**Bosak's principle:** "Documents contain some of the most important data we have, and computers only knew how to do objects. The shape of human knowledge is often found in our documents."

**What happened:**
- XML didn't become the One Universal Format
- But JSON, YAML, TOML, Markdown—all human-readable structured formats—proliferated
- The principle won even though the specific technology didn't monopolize

**Connection to LLMs:**
- LLMs trained on human-readable text, not binary formats
- The entire transformer revolution depends on tokenizing **text** (not objects, not binary)
- Attention mechanisms work on sequences of tokens derived from **readable symbols**
- "Heritage of XML" = the victory of human-readable data representation as the foundation of computing

**Is this going too far?** No. The key insight is:
- Pre-XML era: Data was binary, proprietary, opaque
- Post-XML era: Text is data, readable by humans AND machines
- LLM era: Models trained on this readable text can **reason over structure** because structure is encoded in readable symbols

### Unicode (Languages Just Work)

**Bosak:** "Unicode. Languages just work. That used to be incredibly difficult."

**What happened:** Universal. Every language, every script, one encoding.

**Connection to LLMs:**
- Multilingual models (GPT-4, Claude, Gemini) handle 100+ languages seamlessly
- Tokenization across scripts (Latin, Cyrillic, CJK, Arabic, Devanagari) works
- This was **unthinkable** before Unicode standardization
- LLMs inherit the world Unicode made possible

### Data Integration Across Heterogeneous Sources

**Bosak:** "Data integration across sources that know nothing about each other."

**What happened:**
- XML as universal hub didn't pan out (too many competing standards even within XML)
- But JSON became de facto interchange format for web APIs
- Still the problem: Every API has different schema, field names, structures

**Connection to LLMs:**
- **This is where AI radically changes the game**
- LLMs don't need standardized schemas to integrate data
- They can map between arbitrary field names, structures, formats **on the fly**
- The "universal hub" is no longer a data format—it's a **model that understands intent**
- Example: "Take patient data from Hospital A's JSON and put it in Agency B's database" → LLM + function calling does this without a shared schema

**Critical insight:** Bosak imagined data integration via **standardized formats** (XML DTDs, industry consortia defining tag sets). LLMs achieve integration via **semantic understanding** instead.

### Dynamic Views / Separation of Structure from Formatting

**Bosak:** "Views are dynamic and can be determined when content is delivered to users. Data structure vs. formatting—separate concerns."

**What happened:**
- Stylesheets (XSLT, CSS) did separate structure from presentation
- But the real victory was **templating everywhere** (Jinja, Handlebars, JSX, etc.)
- Same principle: Data in one format, rendered many ways

**Connection to LLMs:**
- LLMs can **generate views on demand from structured data**
- Don't need XSLT transformations—just prompt: "Show me this XML as a table" or "Summarize this JSON as narrative"
- The view generation is **semantic**, not template-based
- Scripture pipeline example: Same scene JSON → Bodies questions, Hearts questions, Connecting questions, all from one data structure

### Just Enough Validation

**Bosak:** Validation is important for data interchange, but optional when not needed.

**What happened:**
- JSON Schema, OpenAPI, Protobuf—validation schemas everywhere
- But looser than XML DTDs—"just enough" won

**Connection to LLMs:**
- LLMs generate **structured output** (JSON, XML) with schema validation
- Function calling = LLMs respecting API schemas
- But LLMs also do **soft validation** (semantic coherence) beyond syntax
- Example: Scripture pipeline validates JSON structure, but also checks for theological coherence, question quality—things no DTD could enforce

### XML Query Languages: XPath and XQuery Still Essential

**What XML got right:** Standardized query languages for structured documents. XPath for navigation, XQuery for transformation.

**What happened:**
- XPath/XQuery became mature standards (XPath 3.1, XQuery 3.1)
- XML databases (BaseX, eXist, MarkLogic) still crucial for document-centric applications
- TEI scholarly editions, DITA documentation, legal publishing—all depend on XPath/XQuery
- **Scripture work:** Morphologically tagged Greek/Hebrew texts are XML (enables precise linguistic queries)

**Connection to LLMs:**
- **LLMs make XPath/XQuery ACCESSIBLE** without replacing them
- Natural language → formal query: Scholar describes intent, LLM generates XQuery
- Example: sdbh-helpers application generates XPath/XQuery from semantic descriptions
- **The pattern:** LLM lowers barrier to entry (no need to memorize XQuery 3.1 syntax), but execution still uses formal query language for precision
- **Why this matters:** XPath/XQuery give **deterministic, repeatable** results. LLM semantic matching is probabilistic. Both are needed.

**Real lexicography example (verb-clauses-by-subject.xq):**

Scholar's intent (natural language):
> "For verb הָיָה, find every clause it appears in, classify each by semantic type of its subject (using SDBH LexDomain codes), handle both explicit subjects and implicit pro-drop cases, and produce grouped counts with sample clauses."

LLM helps generate 400+ line XQuery that:
- Queries macula-hebrew-nodes BaseX database (morphologically tagged WLC)
- Finds all `<m lemma="הָיָה">` elements inside `<Node Cat="CL">` (clause nodes)
- Resolves explicit subjects via `<Node Cat="S">` (subject phrase) descendant words
- Resolves implicit subjects via `@SubjRef` (morphId references to antecedents anywhere in corpus)
- Maps SDBH LexDomain codes to semantic types (God/Divine, People, Animal, Nature, Abstract, etc.)
- Uses 3-pass optimization: collect occurrences → build morphId resolution map → generate records
- Outputs structured JSON: summary by type, full groups, sample clauses, needs-review cases

Result: Precise semantic analysis of 1000+ verb occurrences across OT corpus, with explicit/implicit subject patterns exposed for lexicographic study.

**Why XQuery, not SQL or Python:**
- **Multiple distinct hierarchies need to work together:**
  - Syntax hierarchy: `<Sentence>` → `<Node Cat="CL">` (clause) → `<Node Cat="S">` (subject) → `<Node>` leaf → `<m>` (morpheme)
  - Discourse hierarchy: book → division → pericope → segment (different XML files or JSON structures)
  - Semantic domain hierarchy: Actions → Speech → Speaking Truth (SDBH LexDomain codes nested by semantic abstraction)
  - Quotation hierarchy: direct speech → nested quotes → attributed sayings (who is quoting whom)
  - Emotional flow hierarchy: joy → sorrow → hope (affective progression through narrative)
  - Genre hierarchy: Gospel → miracle → healing → Sabbath controversy (nested genre classifications)
  - Morphological data: could be TSV or relational DB (flat structure is fine)
  - **Each hierarchy is DISTINCT because XML represents only one hierarchy at a time (it's a tree)**
  - **But these hierarchies are LINKED by identifiers: morphId, verse references, entity IDs, LexDomain codes**
- XPath naturally navigates tree structures: `$verb-m/ancestor::Node[@Cat="CL"][1]/Node[@Cat="S"]//m`
- `@SubjRef` can point ANYWHERE in corpus (cross-document references)—XML databases index this efficiently
- Need to query ACROSS multiple hierarchies simultaneously: syntax tree + discourse structure + quotation relationships
- Try expressing "navigate up syntax tree to clause, down to subject phrase, resolve cross-document morphId references, then map LexDomain hierarchy, all while respecting discourse boundaries and tracking quotation levels" in SQL → requires complex self-joins, recursive CTEs, multiple temp tables
- XQuery does it naturally because it can query across multiple distinct hierarchies linked by identifiers

**The synthesis:** XML + XPath/XQuery remain the right tool for **hierarchical linguistic structures that need to be queried together**. Morphology alone? TSV is fine. But constituency parses, discourse trees, and cross-references? That's what XML was designed for. LLMs make these queries accessible to scholars who aren't query language experts, while preserving the deterministic precision scholarly work requires.

### Identifiers Are Centrally Important

**Bosak:** Persistent, stable identifiers matter.

**What happened:**
- URIs, DOIs, ORCIDs—identifier systems proliferated
- Still critical for scholarly publishing, data citation, API design

**Connection to LLMs:**
- LLMs use identifiers for retrieval-augmented generation (RAG)
- Entity linking in knowledge graphs
- Scripture pipeline: OSIS IDs, ACAI IDs—stable identifiers let LLMs reference entities consistently

---

## Bosak's Four Application Categories: How Much Is Now AI?

### 1. Database Interchange (Universal Hub)

**Bosak's vision:** Industry consortia define XML DTDs (HL7 for healthcare, Pinnacles for semiconductors), systems use XML as interchange format.

**What actually happened:**
- Some industries did this (HL7, DITA, DocBook still use XML)
- But JSON APIs became more common than XML interchange
- **Problem persisted:** Every system still has different schemas, field names, structures

**How AI changes it:**
- LLMs read arbitrary schemas and map between them **without standardization**
- No need for industry consortia to agree on tag sets—LLM figures out semantic equivalence
- Example: Hospital A exports patient data as JSON with field "patient_allergies", Agency B imports with field "allergy_list"—LLM maps them
- **The universal hub is the model, not the format**

**What's still needed:** Validation, provenance, legal accountability—things LLMs can't provide alone. Structured formats (XML, JSON) still matter for **audit trails**.

### 2. Distributed Processing (Giving Java Something to Do)

**Bosak's vision:** Download structured data + Java applet, run complex computation client-side (circuit modeling, flight scheduling, etc.)

**What actually happened:**
- Java applets died
- JavaScript + WASM took over client-side computation
- But the **principle won**: Client-side data manipulation, server provides data not computation

**How AI changes it:**
- LLMs can **generate the client-side code on demand**
- Don't need to download pre-written applets—ask LLM to build the tool you need
- Example: "Model these circuits with these parameters" → LLM generates JavaScript simulator from spec
- **The distributed intelligence is the model, not the applet**

**Critical difference:** Bosak imagined **standardized data + custom applications**. AI brings **semantic understanding + generated applications**.

### 3. View Selection (Letting User Decide)

**Bosak's vision:** Download hierarchical TOC once, expand/collapse client-side. Technical manual shows Sparc-only or x86-only by user preference.

**What actually happened:**
- Dynamic TOCs work (implemented in JS, not Java)
- Content filtering by user preference is common
- But still requires **pre-defined views** in data structure

**How AI changes it:**
- LLMs can **generate arbitrary views on demand** from neutral structured data
- Don't need pre-tagged <sparc> and <x86> sections—LLM infers architecture from context
- Example: "Show me only the parts relevant to neural networks" applied to a general ML textbook → LLM extracts that view without explicit markup
- **The view generation is semantic, not structural**

**Scripture pipeline example:** Leader's guide sections (Bodies/Hearts/Connecting) are **generative views** of the same scene data. Didn't exist until LLM created them from structured input.

### 4. Web Agents (Data That Knows About Me)

**Bosak's vision:** Personalized TV guide. Programs described with rich metadata (subject, audience, actors, rating), user preferences in standard format, agents match them.

**What actually happened:**
- Recommendation engines everywhere (Netflix, YouTube, Amazon)
- But mostly **opaque ML models**, not transparent XML metadata matching

**How AI changes it:**
- LLMs can do **semantic matching** without formal metadata schemas
- User can describe preferences in natural language, not structured forms
- Example: "I like sci-fi that explores AI ethics, not action-heavy" → LLM finds matches without explicit genre tags
- **The intelligence is in the model, not the markup**

**What's lost:** Explainability. Bosak's vision had **transparent matching** (these tags match your preferences). AI recommendations are black boxes.

---

## XML Heritage in LLMs: Not Going Too Far

**The claim:** "LLMs are generally much better at JSON than XML, but the heritage of XML is very much what makes them possible."

**Evidence this is true:**

1. **Human-readable structured text as foundation**
   - Transformers tokenize readable symbols
   - Pre-training corpus is text, not binary
   - XML/SGML pioneered "text IS data"—LLMs inherit this

2. **Separation of content from processing**
   - XML separates data from presentation (stylesheets)
   - LLMs separate data from function (prompts + structured input)
   - Same principle: Neutral data representation, multiple uses

3. **Extensible tag vocabularies → Extensible prompt vocabularies**
   - XML: Define your own tags
   - LLMs: Define your own fields in JSON schemas, your own section types in documents
   - Both enable **domain-specific languages** built on general infrastructure

4. **Validation for interchange**
   - XML DTDs validate structure before import
   - LLM function calling validates JSON schemas before API calls
   - Both recognize: Structure matters for machine processing

5. **Unicode universality**
   - XML pushed Unicode adoption
   - LLMs train on massive multilingual Unicode corpora
   - Direct lineage

**What's different:**
- XML required **explicit structure** (tags, DTDs)
- LLMs infer **implicit structure** (semantic understanding)
- XML was about **standardization**
- LLMs are about **semantic flexibility**

**The synthesis:** XML taught us that **human-readable structured text** is the right representation for data. LLMs take this insight and add **semantic understanding**, eliminating the need for explicit standardization while keeping the human-readability principle.

---

## The Semantic Web: What Didn't Work (And What Did)

**Bosak didn't emphasize this, but it became the dream in the 2000s:** RDF, OWL, ontologies, reasoning engines. The idea: Machines understand meaning via formal logic encoded in XML.

**What happened:**
- Semantic Web as envisioned largely failed
- Too much friction: Who maintains the ontologies? How do you get people to use them?
- **But:** Knowledge graphs at Google, Amazon, Facebook, etc. DO use semantic representations
- **But:** Ontologies in specialized domains (medicine, law) DO matter

**Connection to LLMs:**
- LLMs do NOT reason via formal logic over ontologies
- They use **statistical patterns in text** instead
- But **knowledge graphs still matter** for RAG (retrieval-augmented generation)
- Example: Scripture pipeline uses ACAI entities (knowledge graph) to ground LLM reasoning in canonical data

**The synthesis:** Semantic Web's vision was too ambitious (encode ALL meaning formally). But its tools (ontologies, KGs) survive as **supplements to LLMs**, not replacements.

---

## How to Frame This in the Paper

**Possible structure:**

1. **Opening:** Bosak's 1997 vision for XML—what problems was it solving?
2. **What worked:** Human-readable formats, Unicode, extensibility, structure
3. **What didn't:** One Universal Format, Semantic Web as imagined
4. **The AI turn:** LLMs achieve Bosak's goals via semantic understanding instead of explicit standardization
5. **Synthesis:** XML heritage = human-readable structured text. LLMs inherit this. But they add semantic flexibility.
6. **Scripture pipeline as case study:** Structured data (JSON) + LLM generation = Bosak's vision realized differently

**Key message:** The XML community was **right about the problems** (data interchange, extensibility, human+machine readable). They were **right about the principles** (structure matters, text is data). They were **partially right about the solutions** (standardized formats help). But LLMs discovered a **complementary solution**: Semantic understanding reduces the need for explicit standardization while preserving the value of structured representations.

**Closing:** At the last Balisage conference, we honor the XML vision while recognizing that AI has changed the game. Text is still data. Structure still matters. But the universal hub is now a model, not a format.

---

## What Else to Extract from Bosak Paper?

**Key concepts to highlight:**

1. **"Documents contain some of the most important data we have"** — LLMs prove this by training on documents, not databases
2. **"Data belongs to its creators"** — Still true. Structured formats (XML, JSON) give creators control vs. proprietary binary
3. **"Platform- and vendor-independent"** — LLMs work with any text format, but still need open standards for interchange
4. **Industry consortia defining DTDs** — Contrasts with LLM approach (no need for agreed schemas, semantic mapping instead)
5. **"Validation is optional"** — Echoes in LLM world: Structured output when needed, flexible text otherwise
6. **Java applets as code distribution** — Contrasts with LLMs generating code on demand
7. **Stylesheets as view generation** — Contrasts with LLM generating views semantically

**The thread:** Bosak saw the **problem space** correctly. AI changes the **solution space**. But the problems he identified are still the ones we're solving.

---

## Integration Points for Paper (Running Commentary Approach)

**NOT a separate section—sprinkle insights throughout as historical context and validation**

### In Introduction (xml:id="intro")
- Brief Bosak reference: "When Jon Bosak articulated the vision for XML in 1997..."
- Key insight: "Documents contain some of the most important data we have" still true—LLMs prove it by training on text, not databases
- Sets up: We're building on XML's foundation, not abandoning it

### In "The Best Markup for Each Purpose" (xml:id="markup-choices")
**Add after opening paragraph:**
- "The XML community three decades ago recognized that different data structures serve different purposes..."
- Bosak's insight about extensibility: "tag sets should fit the domain"
- Our continuation: YAML for humans configuring pipelines, JSON for machines exchanging data, XML for querying structured scripture

### In "YAML for Pipeline Declarations" (xml:id="yaml-not-xml")
**Brief note:**
- "We choose human-readable formats not because they're new, but because the principle Bosak articulated in 1997 was right: 'both software and people need to be able to read and understand the same data to work well together.'"

### In "JSON for Intermediate Representations" (xml:id="json-not-xml")
**Add paragraph:**
- "LLMs are generally better at JSON than XML, but this is a footnote to XML's larger victory: human-readable structured text as the foundation of computing."
- "The entire transformer revolution depends on tokenizing **text**, not binary formats. This is the world XML made possible."

### In USX/XML Query Section (xml:id="usx-for-scripture")
**Add new subsection: "XPath and XQuery: LLMs Lower the Barrier"**
- Concrete sdbh-helpers example: Natural language → XPath generation → BaseX execution
- "XML query languages remain essential for precise, deterministic queries over structured scripture"
- "LLMs make them accessible to non-experts while preserving their power"
- Example: "Find all aorist participles modifying nouns" → LLM generates XPath → BaseX executes on morphologically tagged Greek

### In "Collaboration Principles" (xml:id="collaboration-principles")
**Brief historical note:**
- Unicode victory: "Languages just work" (Bosak 1997) → enables multilingual LLMs today
- "The XML community's insistence on Unicode was foundational. Today's multilingual models (handling 100+ languages seamlessly) inherit that world."

### In "Audit Infrastructure" or "Five Principles" sections
**Brief validation reference:**
- Bosak: "Just enough validation for the purpose"
- Our approach: JSON schemas validate structure, but LLM-based audits check semantic coherence (things no DTD could enforce)
- Synthesis: Formal validation + semantic validation

### In Conclusion or Integration Discussion
**Reflect on Bosak's four application categories:**
- **Database interchange:** LLMs now map between arbitrary schemas without standardization (the "universal hub is the model, not the format")
- **Distributed processing:** LLMs generate code on demand rather than downloading pre-written applets
- **View selection:** LLMs generate semantic views from neutral data (Bodies/Hearts/Connecting from same scene JSON)
- **Personalization:** LLMs do semantic matching without formal metadata schemas

**Closing reflection (last paragraph or near it):**
- "At the final Balisage conference, we recognize that XML didn't become the universal format Bosak envisioned"
- "But XML's principles—human+machine readable text, extensibility, structure—won decisively"
- "LLMs inherit this foundation and add semantic understanding"
- "We honor XML's vision by building systems where structured data (JSON, XML) and intelligent generation (LLMs) work together, each doing what it does best"

---

## Key Phrases to Weave In

**Short, elegant references (1-2 sentences each):**

1. "Bosak recognized in 1997 that documents contain our most important data. LLMs prove this: they learn from text, not databases."

2. "The XML community insisted text should be readable by humans and machines alike. This principle made transformers possible."

3. "Unicode was XML's quiet victory. Today's multilingual AI stands on that foundation."

4. "Bosak imagined industry consortia defining tag sets for data interchange. LLMs achieve the same goal through semantic understanding instead of standardization."

5. "XPath and XQuery remain vital—LLMs simply make them accessible to those who'd never memorize the syntax."

6. "Validation was always 'just enough for the purpose.' We continue that tradition: structure matters, but so does meaning."

7. "XML didn't monopolize, but its insight—that human knowledge lives in documents, structured as text—shapes everything we build."

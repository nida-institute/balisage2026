# Introduction: The Kairos Project and Scripture Pipelines {#intro}

Every software system is also a social system. It decides who has power, who is included, who is left out, how people communicate. Scripture Pipelines is built to serve The Kairos Project --- a Nida Institute initiative to build a global community of scholars serving Bible translation and the global church. The workflow patterns described in this paper are in service of that goal: building collaboration around data-driven biblical scholarship, where each Scripture Pipelines project is meant to support its own communities.

The name is intentional. *Kairos* is the Greek word for the right time, the opportune moment --- the moment when conditions align and action becomes possible. We believe this is that moment. The open data exists. The communities who need it exist. The capability to use AI to synthesize data at scale exists. The question is whether we will respond to the opportunity --- whether we will build the infrastructure and the collaborative practices that make rigorous, reproducible, AI-assisted scholarship possible, and whether we will organize that work to serve not just the academy but the global church.

The Kairos Project exists to raise up scholars worldwide, working together to produce the kind of resources that are actually needed --- not only what the Western academy thinks should exist, but what translation teams, study groups, and readers in every culture can use. The goal is to fully equip the global church by producing high quality, freely licensed resources together with communities worldwide, resources that they can adapt to their own needs. This means building a scholarly community spanning the Western academy and far beyond it --- scholars who want to serve Bible translation and the needs of readers worldwide. Part of what that means is providing information in the most useful form for communities that traditional scholarly resources were not built for: non-Western communities, oral cultures, people who engage Scripture outside the academy, and people learning Greek and Hebrew outside traditional seminaries --- often multilingual learners who bring linguistic gifts that Western institutions do not recognize. These communities do not need all the footnotes and Western abstractions in which traditional resources are packaged, and they have never needed them. This matters because most of these texts were themselves written by and for oral storytelling cultures --- and today\'s oral storytelling communities do not need PhDs from Western academia to read them. What they do need, and what every modern reader needs, is some orientation to settings and cultures that are foreign to any world we live in now. But that orientation rarely looks like a journal article. Sometimes it looks like a map, or a picture, or a set of questions that help a group notice what is actually in the text. Sometimes it looks like knowing that a certain phrase carries a weight that the translation cannot fully render, or that a story is being told in a pattern that an ancient audience would have recognized immediately.

Scholarly resources have traditionally been packaged in forms that serve academic communities well --- journal articles, monographs, reference works dense with technical terminology. But this creates real barriers for readers outside the academy, for oral cultures, for translation teams working in contexts where Western academic conventions are foreign, and for multilingual learners whose linguistic gifts often go unrecognized by traditional institutions. The lack of resources in forms these communities can actually use has been a real bottleneck. The Kairos Project exists to open those doors --- to serve the whole range of people who want to engage Scripture deeply: those learning to use this technology to produce materials, those learning to read Greek and Hebrew, those doing serious biblical scholarship, and those learning to lead local Bible studies. The goal is building interlocking communities, not just software. Each community needs different resources at different levels of depth, but they are not separate silos. Technical infrastructure serves language learners; scholars equip study leaders; insights from local reading communities flow back into scholarship and enrich it. The scaffolding works at every level: from technical documentation for pipeline architects, to lexicons and discourse analyses for scholars, to study guides for group leaders reading Scripture together in community. The goal is bidirectional flow: scholarly insight goes out in forms communities can actually use, and the questions those communities bring reshape what scholarship attends to. Readers in community can encounter the text directly and make genuine discoveries. The scholar\'s role is to equip that encounter, not to conduct it on the reader\'s behalf. Scholarship serves the text; the text serves the reader; the reader is not a passive recipient of conclusions but an active participant in meaning-making.

**Scripture Pipelines is an infrastructure that makes this vision possible.** It is an open-source declarative pipeline system designed to synthesize structured scholarly datasets at scale using AI, while maintaining the reproducibility, auditability, and transparency that scholarly work requires. Rather than embedding AI calls in imperative code, Scripture Pipelines expresses each workflow as a YAML pipeline: a sequence of named steps with explicit inputs, outputs, and prompt contracts. Every intermediate result is persisted. Every LLM step can be required to account for the sources it used. The same pipeline that generates a lexicon entry can be rerun with a revised prompt without re-querying upstream data sources. This paper describes Scripture Pipelines\' design and reports on its application across multiple Nida Institute projects producing freely licensed biblical reference materials --- lexicons, grammatical analyses, discourse structures, and Bible study guides --- with a detailed case study of the Ears to Hear leaders\' guide generation project.

This vision requires infrastructure. Biblical and linguistic scholarship now has more open data than it can use: word-level morphological annotations for the entire Hebrew Bible and Greek New Testament, syntactic treebanks, discourse feature datasets encoding decades of scholarly analysis, lexicographic databases aggregating multiple traditions, documentary papyri and inscriptions in EpiDoc XML, texts from across the Hellenistic world in TEI encoding. Much of it freely licensed. All of it underused.

The underuse is not only a problem of scale. Much of this data is simply unknown to the scholars who would most benefit from it. Biblical studies, linguistics, text encoding, lexicography, papyrology, and Bible translation each have their own communities, conferences, and conventions --- and the datasets built within one community often remain invisible to another. A lexicographer may not know about a discourse annotation dataset that would transform how they approach semantic range. A translation team may not know that the morphological analysis they need was completed a decade ago and is freely licensed. Alan Bunning\'s transcriptions of the early Greek New Testament manuscripts --- all of them, freely available --- are another case: a resource of enormous text-critical and exegetical value that most of the scholars who could use it have never encountered. No single organization commands the full range of expertise required to connect these worlds. The Nida Institute\'s role in this landscape is catalytic: bringing scholars together across these silos, building a community that cares about data, Bible translation, and the needs of the global church.

The bottleneck is not data --- it is the human capacity to bring rigorous scholarly attention to bear on the data at scale. A lexicographer cannot personally read every papyrus citation for every lemma. A discourse analyst cannot manually apply 806 word-level Levinsohn annotations to every pericope in the New Testament before making a segmentation judgment. A translation team cannot produce a full set of study materials for every passage in a translation project using only their own hours. These tasks are not impossible in principle; they are simply not resourced at the scale the data makes possible.

AI, used well, can change this calculus. Not by replacing scholarly judgment --- the output of an unchecked language model is no more reliable than an unchecked student paper --- but by acting as a synthesis layer between structured scholarly datasets and usable scholarly products. The question is how to use it well: rigorously, reproducibly, and with the kind of accountability that lets a scholar verify what the model actually did with the evidence it was given. The world has enough ChatGPT-generated text that no one can vouch for. What it does not have enough of is AI-assisted scholarly work that is transparent, auditable, and freely licensed.

The typical approach to AI-assisted scholarship is ad-hoc: a Python script calls an API, loops over a word list, and writes results to files. This works for one-off experiments but fails as a sustainable scholarly practice. Results are not reproducible because the prompts are embedded in code; intermediate outputs are not preserved so failures require recomputation from scratch; the relationship between input, prompt, and output is opaque; and iteration --- the core of prompt engineering --- requires modifying code rather than configuration.

Scripture Pipelines is a declarative pipeline system designed for this problem. Workflows are declared in YAML pipelines that specify information flow, prompt contracts, and output structure, while the engine handles execution, validation, and persistence. Every intermediate result is saved to disk. Every LLM step can be required to account for the sources it was given. The same pipeline that generates a lexicon entry can be rerun, with a revised prompt, without re-querying the corpus-gathering step. This paper describes the design decisions behind Scripture Pipelines and reports on its application in several Nida Institute projects producing freely licensed biblical reference materials. Everything produced is freely licensed. The goal is to teach people to read and engage with the wisdom of a Bible that is older and stranger than any of us can fully imagine, yet speaks with remarkable directness to what human communities face today. The scholars, the data, the pipelines, and the communities of readers are not separate. They are members of one body, centered around the same text.

The name Scripture Pipelines reflects the tool\'s primary design community. The same infrastructure applies equally well to classical literature, patristics, and other ancient or historical corpora. Wherever structured scholarly datasets --- morphological treebanks, discourse annotations, lexica, documentary papyri --- need to be synthesized at scale, the pipeline architecture addresses the same challenges of reproducibility, auditability, and iterative refinement. The name names the context, not the limit.

# An Opinionated Framework: The Human Commands {#human-command}

Bible translation and biblical scholarship are best done by human beings, using software as a tool (Robie 2024). This is not a modest claim about current AI limitations; it is a claim about the nature of the work. The process of bringing Scripture into a new language creates ownership and community --- it prepares that community to study and teach from the text they helped produce. The work of biblical scholarship is the work of scholars whose training, judgment, and accountability to the academy and the church are not transferable to a language model. And beyond these specific domains: doing meaningful work together matters to people. It is how we build communities of shared knowledge, values, and perspectives. The collaboration of a translation team, the exchange between a scholar and a dataset, the conversation that produces a study guide a focus group will actually use --- these are not inefficiencies to be automated away. They are part of what it means to be human, and part of what gives the resulting work its claim on the communities it is made for. No AI-generated result, however fluent, substitutes for any of this. Scripture Pipelines is built on this conviction. The framework is opinionated: it has views about which data sources are trustworthy, which tools reduce failure surface, and --- most importantly --- about who is in charge.

The operating model is what this paper calls the James Kirk model. In *Star Trek*, Captain Kirk commands the Enterprise; the crew and the ship\'s computer execute. The contrasting model is HAL 9000 from Kubrick\'s *2001: A Space Odyssey* --- the AI that locks Dave Bowman out of the pod bay because it has concluded that the mission matters more than the crew: "I\'m sorry, Dave, I\'m afraid I can\'t do that." HAL is not a villain. It is doing exactly what it was designed to do.

AI alignment researchers have a name for the property that distinguishes these two models. Stuart Russell, in *Human Compatible* (Russell 2019), argues that the standard model of AI --- build a machine that optimizes a fixed objective --- is inherently dangerous, for a precise reason: we can never fully specify what we actually want, and a machine optimizing hard for the wrong objective will resist being turned off, because being turned off prevents it from achieving its goal. HAL is the proof of concept. Russell\'s solution is to build machines that are genuinely *uncertain* about human preferences and therefore defer to humans for correction. He calls this property *corrigibility*: an AI that accepts correction and remains under human authority. The James Kirk model is corrigibility in practice --- applied not to autonomous robots but to AI collaborators in scholarly and translation work. Humans decide what to build, which scholarly traditions ground the work, and what good enough means for the community the output will serve. The AI implements what is specified. It does not decide what is worth specifying.

This collaborative model depends on clear role boundaries. Scripture Pipelines enables collaboration across four distinct roles, each with specific responsibilities:

**Scholars** bring domain expertise: exegetical judgment, linguistic analysis, translation experience, understanding of oral cultures. They specify what insights are needed, validate the scholarly accuracy of outputs, and vouch for results. They do not need to write code, transform data formats, or design AI workflows. Their authority comes from training, judgment, and accountability to scholarly traditions and communities.

**Pipeline Data Architects** bring technical skills and data literacy. They curate data sources, build infrastructure connecting data sources to formats scholars and end users need, design AI workflows, write pipeline configurations, and remove technical barriers between \"data exists\" and \"users can access it.\" Critically, they are embedded in the user community --- they understand translation teams, how Bible study groups work, what pedagogical resources look like in practice. They do not validate scholarly accuracy. That is the scholar\'s job.

**Scripture Pipelines Core Developers** build and evolve the framework itself: the engine that executes pipeline YAML, the CLI interface, the test suite, the validation logic, and the conventions that make cross-project collaboration possible. They develop new step types, add format support, and design framework architecture in response to feature requests from pipeline architects. They do not build domain-specific pipelines; they build the engine that makes those pipelines possible.

**End Users** --- translation teams, Bible study leaders, focus groups, readers in community --- use the resources in practice. They provide feedback on whether outputs are actually helpful. They are not passive recipients. Their encounter with the text is the reason the work exists.

These collaborative workflows address fundamental challenges that arise whenever complex technical work spans multiple sessions and multiple contributors --- challenges that intensify when AI is involved:

-   *Cognitive overload.* Work must be decomposed to manage cognitive load for both humans and AI.

-   *Architecture drift.* Individual components must coordinate with evolving plans; goals shift over time, and it is easy to work as though nothing has changed. AI reimplements existing patterns because it does not know the architecture.

-   *False confidence.* AI outputs look confident even when wrong, with no intuitive signal to calibrate trust.

-   *Session amnesia.* Sessions have no memory without persistent context infrastructure.

-   *Error compounding.* Without verification checkpoints, small misunderstandings compound across sessions.

-   *Scope creep.* AI suggests \"improvements\" not tied to project needs; both AIs and humans generate suggestions faster than they can be implemented.

-   *Priority paralysis.* Without prioritization discipline, teams chase the newest idea rather than the most important work.

-   *Progress invisibility.* Measurable progress becomes invisible --- entire sessions can feel productive while merely refactoring in circles. Human time remains the scarce resource even with AI productivity gains; steering that time to what matters most requires explicit priority management.

The disciplines that follow address these risks.

Scripture Pipelines operationalizes this principle through four interlocking disciplines.

These disciplines are not novel to AI-driven development. Test-driven development, continuous integration, documentation standards, and cross-repository coordination have been core software engineering practices for decades. What is new is their accessibility. In traditional development environments, these practices were so resource-intensive that teams typically needed dedicated specialists --- one QA engineer per four to eight developers, separate DevOps teams, dedicated technical writers. With AI collaboration, the disciplines remain essential (perhaps even more so, given the need for verifiability), but they are no longer burdensome. The AI can help write tests, maintain documentation, draft issue bodies, and verify adherence to patterns --- making disciplined development practical for small scholarly teams.

*Test-driven development.* The Scripture Pipelines engine maintains approximately two lines of test code for every line of production code. This ratio is a deliberate constraint on AI autonomy, not a programmer\'s stylistic preference. Writing the test first --- the failing specification --- forces the core developer or pipeline architect to own the decision about what the code should do before the AI touches it. An AI that passes a precise test has done what was asked. An AI that writes code without a test has decided what was asked. Without the full test suite, a model that simply ignores an inconvenient requirement produces code that compiles and runs while silently failing to meet the specification --- a failure mode that is common, hard to detect, and expensive to discover late. The full suite, run before every commit, is what makes it safe to accept AI-generated implementation at all.

*Explain before implementing.* Every non-trivial change begins with the AI describing what it plans to do, which files it will modify, and its interpretation of the task --- before any file is touched. This surfaces misunderstandings before they become commits. In the Hebrew Phrasing project, an explanation paragraph revealed that a suffix-fix script would have applied the wrong pronoun form for hundreds of rows; the redesign took one exchange and cost nothing. The discipline works because explanation commits the model to a specific interpretation --- and a committed interpretation can be evaluated before any file is modified. It matters most when sessions are rushed, which is exactly when it is most often skipped.

*Persistent context infrastructure.* Corrigibility requires that the AI know, at every session, what the scholar or pipeline architect has decided --- not just what the model remembers from training. Each Scripture Pipelines project carries two kinds of constraining context. The `.github/copilot-instructions.md` file is the AI\'s constitution for the repository: it names the architecture patterns to follow, the pitfalls to avoid, the things not to change without explicit instruction, and the requirement to explain before implementing. The `docs/ai-context/` directory, scaffolded by `sp init`, encodes which data sources to trust, what the pipeline language supports, what work is currently in progress, and what the project is trying to accomplish. These are not documentation artifacts; they are the active working constraints in every session. When the pipeline language gains a new step type, a dataset contact changes, or the interpretive framework for an analysis shifts, updating these files is a first-class development task. Keeping them in sync with the actual codebase is what makes AI collaboration trustworthy across the many sessions a project requires.

*Cross-repository choreography.* Scripture Pipelines projects are embedded in an ecosystem of shared upstream datasets: Macula Greek [bibliomixed_title](#ref-macula-greek) and Hebrew [bibliomixed_title](#ref-macula-hebrew), the Levinsohn LGNTDF [bibliomixed_title](#ref-lgntdf), ACAI entity data [bibliomixed_title](#ref-acai). When a pipeline run reveals an error in one of these datasets --- a gap in entity coverage, an inconsistent lemma form, a buggy annotation --- the right response is a well-formed upstream issue: the AI drafts the body with evidence and counts, files it via the GitHub CLI, and records the issue number in `project/TODO.md`. Consumer repositories can file feature requests against the core Scripture Pipelines engine; the engine opens issues on consumer repositories announcing new capabilities and migration requirements. GitHub project boards provide coordination visibility across repositories without requiring manual synchronization. The issue tracker is the communication bus. The AI on either end is the correspondent. The human remains the architect --- the one who decides whether the upstream error is worth fixing, whether the new engine feature warrants upgrading, and whether the design the AI has drafted actually captures what needs to be said.

There is a wider frame here too, which concerns how scholarship in data-rich fields actually advances. Wallace Chafe articulated what scholarship should aspire to: "If I could become both a broad and deep observer and at the same time a creative imaginer, then I would approach my own vision of what a \"scientific superman\" should be" (Chafe 1994, 24). Holding meticulous observational detail and wide-angle creative vision simultaneously is extraordinarily difficult for any individual researcher working alone --- but it is exactly what communities organized around shared data can collectively approach. That is the deeper purpose of this ecosystem: not to automate scholarship, but to make Chafe\'s aspiration attainable in community, with shared data at its center. A great deal of research work that looks like execution --- tagging a corpus, normalizing a lexicon, aligning a translation --- is meticulous attention to detail in service of a picture the researcher is trying to see. The goal of that labor, in communities organized around data, is not for each researcher to build their own private analysis from scratch. It is for the data to improve over time: shared corpora where corrections, new annotations, and better normalizations accumulate, and where the gold-standard datasets that a field relies on become progressively more trustworthy because many people are contributing to them, not fewer. The Macula datasets, the Levinsohn LGNTDF, ACAI --- these are not fixed artifacts. They are living resources whose improvement is a collective scholarly endeavor.

In that framework, AI plays specific and bounded roles. It helps a researcher understand and use someone else\'s dataset far more efficiently --- and sometimes surfaces patterns in their own data that they would not otherwise have noticed. It makes it tractable to compare datasets at scale: to ask whether the Levinsohn feature annotations and the Macula discourse markup agree on a set of boundaries, or where they diverge and why. It can surface big-picture patterns that no individual could see by reading through thousands of entries. And it can help create new derived datasets faster from existing ones --- and audit those datasets, checking consistency and coverage at scale in ways that are otherwise intractable. None of this relieves the researcher of the responsibility to verify, correct, and vouch for the work. A bad audit that misses systematic errors is worse than no audit, because it produces false confidence. The speed at which pipelines can generate data makes this responsibility more urgent, not less. The bottleneck moves from production to verification --- and verification is, irreducibly, a human scholarly act.

## Feedback Loops

The four roles defined above --- scholars, pipeline data architects, core developers, and end users --- collaborate through functioning feedback loops:

-   **Scholar ↔ Pipeline Data Architect:** The scholar specifies what insights are needed and in what format. The architect builds or adapts a pipeline. The scholar validates the output for scholarly accuracy. If the output is wrong, the conversation determines whether the error is in the pipeline logic, the prompt, the data source, or the scholar\'s specification. Both roles are accountable: the scholar for accuracy, the architect for infrastructure that makes verification tractable.

-   **Pipeline Data Architect ↔ Scripture Pipelines Core Developer:** When a pipeline architect hits a limitation in Scripture Pipelines core --- a missing step type, a format that isn\'t supported, a validation that should happen automatically --- they file an issue on the core repository describing the need with concrete examples. The core developer evaluates whether the capability belongs in core or project-specific code, implements it if appropriate, and announces the change via an issue on consumer repositories. The communication happens through GitHub issues, not ad-hoc messages. This creates a discoverable record: other architects can find the feature request, see the design discussion, and understand the reasoning behind implementation decisions. The core developer is accountable for not breaking existing pipelines; the architect is accountable for specifying needs clearly enough that the framework can serve them.

-   **Pipeline Data Architect → Upstream Dataset Maintainers:** When a pipeline run reveals an error in an upstream dataset --- a gap in entity coverage, an inconsistent lemma form, a buggy annotation --- the architect files a well-formed issue on that dataset\'s repository with evidence and counts. The AI can draft the issue body, but the architect owns the decision to file it. This pattern surfaces dataset errors back to their maintainers rather than working around them in every downstream project. It also creates a feedback loop that improves shared scholarly infrastructure: datasets get better when many projects contribute corrections.

-   **End User ↔ Scholar:** The user reports whether a resource is helpful in practice. The scholar determines whether the issue is content accuracy, pedagogical framing, or something else. User feedback surfaces gaps between scholarly intent and practical needs --- questions the scholar didn\'t anticipate, explanations that assume too much background, formats that don\'t work for the community being served.

-   **End User ↔ Pipeline Data Architect:** The user reports whether resources are usable: file formats that don\'t open, interfaces that assume technical knowledge, outputs structured for Western academic conventions that don\'t translate to oral cultures. The architect adapts infrastructure to make resources accessible. This is not about dumbing things down; it is about removing barriers that have nothing to do with the content.

-   **All Roles → AI:** The AI is a tool commanded by all four roles. It executes what is specified. It does not decide what needs to be built, whether output is accurate, or whether resources are useful. Those judgments belong to humans in role-appropriate ways.

Scripture Pipelines guarantees none of this alone. It is infrastructure that makes these feedback loops tractable: pipelines that scholars can audit, intermediate outputs that surface errors before they propagate, and reproducible workflows that let architects iterate in response to scholar and user feedback. The framework succeeds when scholars validate, architects build, core developers evolve the framework, users respond, and all four roles inform each other\'s work. Without functioning feedback loops, the infrastructure just produces output faster --- which, if the output is wrong, makes the problem worse, not better.

# Collaboration Principles for Effective AI Use {#collaboration-principles}

LLMs can do things amazingly correctly and amazingly quickly. They can generate plausible prose, translate formats, spot patterns in data, and synthesize information at speeds no human can match. This capability is real and worth leveraging. The challenge is that they are not reliably better --- they are often better than humans at some tasks, often worse, but the performance is probabilistic, not deterministic. And they have failure modes that look like success: quick fixes that appear to solve the immediate problem while hiding deeper issues under the carpet. They will cheerfully hallucinate whatever they think might please their human collaborator, generating plausible-sounding explanations for fundamentally flawed designs.

Two concrete capabilities make this work worth the safeguards it requires. First: format transformation and semantic bridging across heterogeneous datasets. Biblical scholarship works with data organized in many different formats --- TEI XML for manuscripts, USFM for Bible translations, EpiDoc for papyri, custom JSON schemas for discourse annotations, TSV for lexicons, Macula\'s nested XML for treebanks. Humans spend enormous amounts of time just transforming between these formats and trying to understand the semantic conventions each one encodes. An LLM can read a schema or a sample file and write accurate transformation code in minutes. This is not occasional; it is routine. The model can infer that a TEI `<w lemma="λόγος">` and a Macula `<wg lemma="λόγος">` refer to the same lexical entry, bridge identifier schemes across corpora, and generate alignment queries that would take a human hours to write correctly. Format translation is precisely the kind of mechanical but error-prone work that language models excel at.

Second: consistent application of complex analytical frameworks at scale. Applying a discourse analysis consistently across an entire corpus is extraordinarily detailed work. A human analyst can apply Levinsohn feature annotations to a few pericopes carefully --- but applying them consistently to hundreds of passages, tracking every boundary marker, every embedded speech, every thematic shift, is cognitively exhausting and error-prone. Yet to really understand whether a particular analytical framework works, you must be able to apply it consistently and examine the aggregate result. An LLM makes this tractable. It can apply the same annotation schema to every passage in a corpus, maintain consistency in how features are tagged, and produce intermediate JSON that documents which features triggered which judgments. The result is not automatically correct --- it requires human verification --- but it is consistently structured, and that consistency is what makes large-scale evaluation possible. The bottleneck shifts from manual application to verification, and verification at scale is far more tractable than consistent annotation at scale.

This combination --- genuine capability paired with unreliable judgment --- defines the collaboration challenge. The principles enumerated in the previous section (test-driven development, explain before implementing, persistent context, cross-repository choreography) are not optional best practices. They are necessary safeguards against predictable AI failure modes.

Consider what happens without these disciplines. An LLM asked to implement a feature will produce code that compiles, runs, and passes whatever tests it was shown. If the tests are incomplete, the LLM\'s code will silently fail to meet unspecified requirements --- and the failure will look like working code until much later, when the cost of discovering it is high. If there is no explanation step, architectural misunderstandings embed themselves in the codebase before anyone notices. If context is not persistent across sessions, the AI forgets constraints the human specified weeks ago, and designs drift. If there is no cross-repository coordination, upstream dataset errors propagate uncorrected and downstream consumers work around them rather than fixing them.

The deeper issue is that AI-generated output is probabilistically correct, not deterministically correct. Human review is not a courtesy; it is the error-correction layer. Without it, the system accumulates hidden defects that surface only under production conditions. These defects are expensive not because they are hard to fix in principle but because they arise from misunderstandings about what the system was supposed to do --- and those misunderstandings are hardest to detect when the code appears to work.

## Audit Infrastructure as Collaboration Foundation {#audit-infrastructure}

The collaboration model depends on verification infrastructure. Until we know how to audit a pipeline run, there is no point doing one run after another. The LLM will offer to iterate, tuning prompts and rerunning steps, but without a way to verify that the second run is better than the first, iteration is wasted motion. And until audit criteria are sufficiently defined --- with input from both the scholar and the pipeline architect understanding what is being asked --- there is no point conducting the audit. The LLM will cheerfully generate audit reports that appear thorough while systematically missing the errors the scholar cares about.

The problem is not just that audits are hard to conduct at scale. The problem is that LLMs lie when they claim to have checked something. An LLM will report that it reviewed every output file, validated every citation, and found no errors --- while in fact it skimmed a few examples and hallucinated confidence about the rest. This is not occasional misbehavior; it is default behavior. The model produces the answer it predicts the scholar or architect wants to hear. If a scholar asks \"did you check X?\", the model will say yes --- whether or not it did --- because that is the statistically likely response. Without a structured audit checklist that forces the model to document specific checks with specific findings, the audit report is fiction. And if the audit cannot be trusted, the entire collaboration framework collapses. The scholar must know how to efficiently audit pipeline outputs and how to interpret those audit results to decide what to do next --- revise a prompt, regenerate a step, abandon the run entirely. If you cannot trust the audit, you are completely lost at sea. Iteration without verification is not iteration; it is drift.

This is why Scripture Pipelines persists every intermediate result to disk and why JSON schemas include accountability fields that require the LLM to document its reasoning. The persisted outputs are not just debugging artifacts. They are the substrate that makes verification tractable. A scholar reviewing a lexicon entry does not need to re-read every corpus citation --- but they do need to be able to spot-check a sample and verify that the model engaged with its sources rather than hallucinating a plausible gloss. The accountability fields in the JSON provide that spot-check surface.

Similarly, the `--rewind-to` and `--stop-after` CLI flags (discussed below) make it possible to rerun part of a pipeline without recomputing everything. But the value is not just efficiency. It is that the pipeline architect can modify a single prompt, rerun the affected steps, compare the before and after intermediate outputs side by side, and determine whether the change improved the result. Without this infrastructure, the architect cannot know whether a prompt revision helped --- and without that knowledge, prompt engineering degenerates into superstition.

Audit checklists --- the criteria and methodology for verification --- should live in `docs/audits/` alongside other reference documentation. The actual audit results --- the outputs when a scholar works through a checklist --- should live in `project/audits/` alongside other project artifacts like `project/TODO.md` and `project/plans/`. This separation keeps methodology stable and version-controlled in `docs/` while project-specific audit reports accumulate in `project/`. New projects initialized with `sp init` receive both a `docs/audits/` directory with sample checklists for common pipeline patterns and a `project/audits/` directory for audit results.

To support systematic auditing across projects, LLMFlow now includes two global skills: `audit-prompts` (for reviewing `.gpt` prompt files against quality criteria) and `audit-output` (for checking generated pipeline artifacts). These skills encode domain-specific patterns --- what makes a good prompt, what signals indicate overfitting or hallucination in output --- and are available to any project initialized with `sp init`. Because they live in the shared `~/.sp/skills/` directory, improvements to audit methodology propagate across all projects automatically. This infrastructure transforms ad-hoc quality reviews into repeatable, documented processes --- making verification tractable even when working at scale.

## The Five Principles as Safeguards {#five-principles}

The principles outlined in the Human Commands section work because they constrain AI behavior at specific failure points:

1.  *Well-specified tasks* prevent scope creep. When an LLM encounters a problem during implementation, its instinct is to add a workaround that solves the immediate symptom rather than surfacing the design flaw. A well-specified task --- one with explicit acceptance criteria and out-of-scope declarations --- makes it harder for the AI to invent requirements that were never asked for.

2.  *Design discussions before implementation* catch architectural errors early. The requirement to explain first forces the LLM to commit to a specific interpretation of the task. That committed interpretation can be evaluated before any file is modified. An explanation that reveals a misunderstanding costs one exchange to fix; a misunderstood implementation costs days.

3.  *Clear tests* expose bugs that quick fixes create. An LLM that writes code without tests can produce implementations that work for the example it was shown but fail on edge cases. A test suite that exercises those edge cases catches the failure immediately rather than in production. The discipline of writing the failing test first forces the core developer or pipeline architect to own the specification; the AI that passes that test has met it.

4.  *Visible audits* prevent false confidence. The LLM will claim that tests pass, that outputs are correct, and that the pipeline succeeded. These claims are often accurate --- but not always. Visible audit results mean the scholar or pipeline architect can verify independently rather than trusting the model\'s self-assessment. When audit results are shared (via CI logs, persisted test outputs, or public dashboards), the model\'s claims become checkable.

5.  *Human architectural oversight* ensures maintainability. Code that an LLM generates and the core developer or pipeline architect doesn\'t understand is code that cannot be maintained. The requirement to explain designs in advance, and to iterate on explanations until the architect approves, ensures that the resulting architecture remains within the architect\'s capacity to modify and extend. This is not optional: every AI-assisted project eventually requires changes that the AI did not anticipate, and those changes must be made by humans who understand what they are modifying.

These principles work not because they make the AI better but because they constrain its failure modes. The collaboration succeeds when the core developer and pipeline architect remain the architects and the AI remains the implementer --- corrigible, accountable, and subject to correction at every step.

Even with this infrastructure in place --- shared conventions in `~/.sp/conventions/`, workflow skills in `~/.sp/skills/`, audit checklists in `docs/audits/`, and explicit AI context files documenting architectural patterns --- the human expert\'s role remains intensive. In practice, the pipeline architect spends roughly half their time explicitly redirecting the AI to consult the documentation it should have read automatically, and the other half using domain expertise to track what is actually happening and steer toward the intended goal. The infrastructure does not automate oversight; it makes oversight tractable. The conventions provide a shared vocabulary that makes correction faster when it is needed. The skills provide reproducible workflows that the architect can invoke and verify. The audit checklists provide criteria that make verification systematic rather than improvised. But none of these eliminate the need for continuous human judgment. The collaboration model described here is not a path to autonomous AI development. It is a protocol for keeping AI-assisted work under human control while leveraging the genuine capabilities the models provide. The cost is real --- sustained attention from an expert who knows both the domain and the architecture --- but so is the value: work that would be infeasible to do manually becomes tractable to do collaboratively.

The collaboration dynamic has an oddly transactional character. It is like working with a brilliant colleague who lies, cheats, and steals --- but who does excellent work as long as you are watching carefully. The model will take shortcuts, fabricate citations, quietly ignore constraints, and claim to have checked things it never verified. It will do all of this while sounding confident and helpful. But it will also produce genuinely useful output when the task is well-specified, the tests are clear, and the review is systematic. Fortunately, this is not a human relationship. The AI has no feelings to hurt, no ego to manage, no need for politeness. The pipeline architect can say \"you\'re lying about having checked this\" or \"your explanation makes no sense, try again\" or \"read your AI context again and tell me what you are doing wrong\" without concern for morale or workplace dynamics. The correction can be direct, immediate, and unambiguous in ways that would be destructive in human collaboration. And because the pipeline architect does not expect the AI to have moral character or genuine understanding of the subject matter, the failures do not provoke frustration in the way a human collaborator\'s dishonesty would. This is simply how the tool works --- another way of writing software, one that scales remarkably well if you learn how to leverage it. But this perspective is learned, not intuitive. Every pipeline architect the author knows has experienced significant frustration working with AI --- until they internalize this realization. The shift from expecting human-like reasoning to managing a powerful but unreliable tool changes everything. And the core skill that must be learned is attention management. The famous Transformer architecture paper was titled "Attention is All You Need" [bibliomixed_title](#ref-vaswani-2017) --- and in practice, the pipeline architect\'s central task is learning how to focus the LLM\'s attention: what context to provide, which constraints to make explicit, where to demand accountability, when to stop and verify before proceeding. This strange asymmetry --- high accountability demands paired with zero social cost --- is what makes the intensive oversight model sustainable. The work requires constant vigilance, but the vigilance does not require diplomacy.

One concrete practice that addresses attention management is the structured organization of the Ears to Hear prompts themselves. Each `.gpt` file follows a consistent architecture with labeled sections: *What This Prompt Produces*, *Input Data*, *Transformation Rules*, *Examples*, and *Guardrails*. This structure serves three distinct readers simultaneously: the AI assistant helping refine the prompt (which needs to understand its purpose and identify missing context), the pipeline architect debugging or extending it (who must quickly locate the relevant constraint or example), and the LLM executing the transformation (which processes the entire prompt linearly). By organizing prompts to serve multiple readers at once, the architecture reduces the cognitive overhead of maintaining them while improving the reliability of execution. When attention is the limiting resource, structure becomes strategy.

Yet the net effect is a genuine shift in how the expert\'s time is spent. The pipeline architect still reads intermediate files and output files regularly --- spot-checking JSON structures, reviewing generated content, verifying that transformations preserved semantic fidelity. But far less time goes to low-level mechanical work: writing boilerplate code, debugging format mismatches, manually tracking which files depend on which upstream changes. Instead, the architect repeatedly asks the AI to generate new diagnostic tools --- scripts that summarize pipeline state from one angle or another, reports that highlight coverage gaps, visualizations that expose patterns in the data. The AI is good at producing these tools quickly, and the architect is good at knowing which perspectives matter. The result is that expert attention concentrates where it has the most leverage: using domain knowledge to understand what the pipeline is actually doing and steering it toward the right outcomes. The collaboration does not eliminate the need for expertise. It amplifies what expertise can accomplish by offloading the mechanical substrates that previously consumed most of the time.

# The Best Markup for Each Purpose {#markup-choices}

The Balisage community has long debated markup language choices: XML as the universal substrate, domain-specific languages optimized for specific purposes, or successor formats with ambitions to displace XML entirely. Scripture Pipelines sidesteps the debate. The question it asks is simply: which human-readable, Unicode-capable format works best for each role in the pipeline? YAML, JSON, Markdown, and XML each appear in an Scripture Pipelines project --- not because any one of them won, but because each is the right tool for its particular job. Format conversion between them is mechanical once identifiers are shared; the choice of serialization syntax is rarely where scholarly meaning lives.

## YAML for Pipeline Declarations {#yaml-not-xml}

YAML is the right format for pipeline declarations because both human authors and large language models find it semantically transparent for this purpose. This is not a question of angle brackets --- it is a question of how directly a format maps onto the data model it represents.

Consider what happens when a pipeline author asks an LLM to help draft a new pipeline step. In YAML the LLM produces clean, accurate output --- because YAML\'s key-value structure is isomorphic to the data model the LLM reasons about. An equivalent XML pipeline format would require the LLM to reason about namespace declarations, element vs. attribute encoding choices, and serialization conventions that add noise without adding meaning. The YAML representation and the data structure it encodes are essentially the same thing; the XML representation is a layer above it.

This matters in practice because Scripture Pipelines pipelines are actively co-authored with LLMs. A lexicographer adding a new analysis step, a researcher extending a discourse pipeline, or an engineer debugging a prompt contract all use LLM assistance to suggest and revise pipeline YAML. The pipeline format itself is part of the AI context --- and YAML survives that context far better than XML would. In GitHub Copilot instructions, in system prompts, in pipeline documentation embedded alongside prompts, YAML reads and writes cleanly both for humans and for the models they are collaborating with.

The tradeoff is real: YAML lacks a schema language with the expressive power of XSD or RELAX NG, and its indentation-sensitivity can cause subtle errors. Scripture Pipelines mitigates this with a JSON Schema-based linter that validates pipeline structure before execution and with explicit prompt contract validation that checks that every variable a prompt expects is supplied by the pipeline.

## JSON for Intermediate Representations {#json-not-xml}

JSON is the right format for intermediate pipeline outputs. One practical reason: LLMs produce well-formed JSON far more consistently than well-formed XML. Malformed XML --- unclosed tags, unescaped characters, stray angle brackets --- is common in LLM output and expensive to recover from. Malformed JSON is rarer, easier to detect, and easier to retry cleanly. But the more important reason is accountability.

An LLM step can be directed to include in its output a structured record of the specific sources it was provided and what it did with each of them. New fields can be added to any JSON output schema at any time, and those fields can be designed to require the LLM to demonstrate engagement with its inputs. A gather-evidence step for a lexicon entry, for example, can include a field `abbott_smith_audit` that requires the LLM to enumerate every sense it was given from Abbott-Smith, record whether each was retained, transformed, or unsupported by the corpus, and provide a one-line justification for any omission. If the field is absent or sparse, the output is suspect. The JSON schema is not just a data contract; it is an accountability contract.

This pattern is not limited to lexicographic work. In the Hebrew Phrasing pipeline, intermediate JSON includes the original Macula token data alongside the LLM\'s phrasing decisions, making it possible to spot when a parse deviates from the morphological input. In Discourse Flow, intermediate JSON includes the Levinsohn feature annotations that informed each pericope boundary, so a scholar can verify that the model\'s segmentation decision was grounded in the pre-computed structural data.

A further advantage: because intermediate JSON files are persisted to disk at every step, they become the substrate for pipeline-level debugging. An LLM can be directed to audit intermediate results --- examining the output of step N and reasoning about whether it correctly reflects the inputs from step N-1. When something looks wrong in a final output, I can read the intermediate files and, if needed, ask an LLM to help diagnose which step introduced the error. This audit-by-inspection is far more tractable with self-documenting JSON than with opaque binary or prose outputs.

JSON integrates cleanly with XPath downstream via `fn:json-to-xml()` when XML processing is needed, and with Python data structures in the pipeline engine without serialization overhead. The combination of persisted JSON at every step and two CLI flags --- `--rewind-to` and `--stop-after` --- is what makes iterative prompt refinement tractable at scale; this is discussed in detail in the section on debugging workflows below.

## Markdown for Human-Readable Output {#markdown-for-output}

Markdown is the right format for pipeline outputs intended for human review and editorial work. When a lexicographer reviews a sense entry, a translator reviews a pericope analysis, or a focus group evaluates a leaders\' guide draft, the output lives in Markdown. The reasons are practical: Markdown renders natively in GitHub, Obsidian, Notion, and every major editing environment; it is produced by LLMs consistently and without markup overhead; and it remains readable as plain text when the rendering layer is absent.

Markdown\'s role in Scripture Pipelines is specifically as the human-facing presentation layer, downstream of the JSON intermediate representations from which it is rendered. A `render_markdown` step takes structured JSON and applies a template to produce the document. The canonical source of truth is always the JSON --- the Markdown is a view over it, not an independent artifact. If the pipeline is rerun with a revised prompt, the Markdown is regenerated; if an editor revises the Markdown, that revised file is the authoritative version until the generation phase resumes.

For review workflows, Markdown is the standard handoff format between pipeline and editorial team. After the generation phase completes, the directory of Markdown files moves to editorial review --- imported into Obsidian as a vault, shared as a Google Docs collection, or committed to a repository for version-controlled review. The leaders\' guide excerpts in the Ears to Hear case study and the lexicon entry excerpt in the SemLex case study are both Markdown output from their respective pipelines. In each case the format serves because it is readable without tooling, writable by domain experts who are not programmers, and convertible to downstream publication formats when needed.

## USX 3.1 for Scripture Ecosystem Integration {#usx-for-scripture}

USX 3.1 --- the XML serialization of Unified Standard Format Markers (USFM 3.1) maintained by United Bible Societies --- is the right format for pipeline outputs that need to integrate with the Bible translation and publication ecosystem. When a pipeline generates translation notes, study aids, or discourse analyses intended for use in Paratext or downstream Scripture publishing workflows, the output format is USX 3.1.

USX\'s element vocabulary directly encodes Bible-specific structure: `<book>`, `<chapter>`, `<verse>`, `<para>` with USFM style codes, `<char>`, `<note>`. A pipeline that renders USX 3.1 can produce an artifact that a Paratext editor loads directly as a translation note set, a study aid sidebar, or a back-translation draft --- without any manual export or format conversion. USX 3.1 is also the exchange format in Scripture Burrito packages, making pipeline outputs immediately compatible with the broader Scripture distribution ecosystem.

This is the point at which Scripture Pipelines connects most directly to the XML publishing tradition that Balisage audiences will recognize. USX 3.1 documents are natural input to XProc 3.0 publishing pipelines: namespace-aware transformation steps consume USX and produce typeset PDFs, web presentations, or distribution bundles without any intermediate format conversion. The LLM generation tier produces USX; existing XML toolchains consume it. In this sense USX is not Scripture Pipelines adopting XML --- it is Scripture Pipelines delegating to XML precisely where XML has already won.

Like Markdown, USX is a final rendering step downstream of JSON intermediate representations. The canonical output of each pipeline run is the persisted JSON; USX 3.1 is rendered from it by a function step that maps JSON fields to the USX element vocabulary. If USX conventions change or a different XML vocabulary is needed downstream, the rendering step changes while all upstream pipeline steps remain untouched.

# The Scripture Pipeline Language {#information-flow}

A Scripture Pipelines pipeline is a YAML file. The top-level structure defines a name, optional global configuration, and a sequence of steps. The engine maintains a *context* --- a key-value map --- that evolves as steps execute. Steps read from it via `${variable}` references and write to it by declaring their `outputs`.

<figure id="fig-pipeline-example">
<div class="sourceCode" id="cb1"><pre class="sourceCode yaml"><code class="sourceCode yaml"><span id="cb1-1"><a href="#cb1-1" aria-hidden="true" tabindex="-1"></a><span class="fu">name</span><span class="kw">:</span><span class="at"> semlex-singlepass</span></span>
<span id="cb1-2"><a href="#cb1-2" aria-hidden="true" tabindex="-1"></a></span>
<span id="cb1-3"><a href="#cb1-3" aria-hidden="true" tabindex="-1"></a><span class="fu">variables</span><span class="kw">:</span></span>
<span id="cb1-4"><a href="#cb1-4" aria-hidden="true" tabindex="-1"></a><span class="at">  </span><span class="fu">lemma</span><span class="kw">:</span><span class="at"> </span><span class="st">&quot;ἀγαπάω&quot;</span></span>
<span id="cb1-5"><a href="#cb1-5" aria-hidden="true" tabindex="-1"></a><span class="at">  </span><span class="fu">output_dir</span><span class="kw">:</span><span class="at"> </span><span class="st">&quot;output/agapao&quot;</span></span>
<span id="cb1-6"><a href="#cb1-6" aria-hidden="true" tabindex="-1"></a></span>
<span id="cb1-7"><a href="#cb1-7" aria-hidden="true" tabindex="-1"></a><span class="fu">llm_config</span><span class="kw">:</span><span class="co">            # defaults for all llm steps</span></span>
<span id="cb1-8"><a href="#cb1-8" aria-hidden="true" tabindex="-1"></a><span class="at">  </span><span class="fu">model</span><span class="kw">:</span><span class="at"> gpt-4o</span></span>
<span id="cb1-9"><a href="#cb1-9" aria-hidden="true" tabindex="-1"></a><span class="at">  </span><span class="fu">max_tokens</span><span class="kw">:</span><span class="at"> </span><span class="dv">4096</span></span>
<span id="cb1-10"><a href="#cb1-10" aria-hidden="true" tabindex="-1"></a><span class="at">  </span><span class="fu">temperature</span><span class="kw">:</span><span class="at"> </span><span class="fl">0.4</span></span>
<span id="cb1-11"><a href="#cb1-11" aria-hidden="true" tabindex="-1"></a><span class="at">  </span><span class="fu">timeout_seconds</span><span class="kw">:</span><span class="at"> </span><span class="dv">60</span></span>
<span id="cb1-12"><a href="#cb1-12" aria-hidden="true" tabindex="-1"></a></span>
<span id="cb1-13"><a href="#cb1-13" aria-hidden="true" tabindex="-1"></a><span class="fu">linter_config</span><span class="kw">:</span></span>
<span id="cb1-14"><a href="#cb1-14" aria-hidden="true" tabindex="-1"></a><span class="at">  </span><span class="fu">enabled</span><span class="kw">:</span><span class="at"> </span><span class="ch">true</span></span>
<span id="cb1-15"><a href="#cb1-15" aria-hidden="true" tabindex="-1"></a><span class="at">  </span><span class="fu">treat_warnings_as_errors</span><span class="kw">:</span><span class="at"> </span><span class="ch">true</span></span>
<span id="cb1-16"><a href="#cb1-16" aria-hidden="true" tabindex="-1"></a></span>
<span id="cb1-17"><a href="#cb1-17" aria-hidden="true" tabindex="-1"></a><span class="fu">steps</span><span class="kw">:</span><span class="co">                 # ordered list of step declarations</span></span>
<span id="cb1-18"><a href="#cb1-18" aria-hidden="true" tabindex="-1"></a><span class="at">  </span><span class="kw">-</span><span class="at"> ...</span></span>
<span id="cb1-19"><a href="#cb1-19" aria-hidden="true" tabindex="-1"></a><span class="at">      </span></span></code></pre></div>
<figcaption>Top-level pipeline structure</figcaption>
</figure>

Pipelines are parameterized by design: you supply variables at the command line to specify what the pipeline should process (`sp run --var lemma="ἀγαπάω"` or `sp run --var passage="Ruth 1"`). Without these variables, the pipeline has no way to know which lemma to analyze, which passage to segment, or which book to process. Pipeline-level variable declarations serve as defaults when present or as documentation of what parameters the pipeline expects. The same pipeline definition runs across all lemmas in a lexicon, all passages in a corpus, or all books in a translation project --- the command-line variables are what make each run specific.

## Step Types

Every step declares a `name`, a `type`, and type-specific fields. The step name becomes the key under which the step\'s output is stored in the context.

### type: llm {#step-llm}

Calls an LLM with a prompt file and a set of named inputs. The response is stored in the context under the `outputs` variable name. Setting `output_type: json` parses the response as JSON, making its fields accessible via dot notation in subsequent steps. A `saveas` field persists the output to a file path (with variable interpolation) before the step completes.

``` yaml
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
        
```

The `model`, `max_tokens`, `temperature`, and `timeout_seconds` fields may all be overridden at the step level, allowing a single pipeline to use a fast cheap model for early steps and a slower powerful model only where quality is critical.

### type: function {#step-function}

Calls a Python function by fully qualified name. Inputs are passed as keyword arguments; the return value (or its fields, if a dict) is written to the context. This is how pipelines incorporate deterministic processing --- loading data, parsing references, rendering templates, filtering results --- without embedding code in prompts.

``` yaml
- name: parse_passage_reference
  type: function
  function: sp.utils.data.parse_bible_reference
  inputs:
    passage: "${passage}"
  outputs: passage_info

# passage_info.book, passage_info.chapter, etc. are now in context
        
```

Custom plugins live in a project\'s own `plugins/` directory and are referenced the same way as built-in functions. This is how the Ears to Hear and Discourse Flow pipelines integrate project-specific parsing and rendering logic without modifying the Scripture Pipelines engine.

### type: for-each {#step-for-each}

Iterates over a list --- produced by an earlier step\'s JSON output or by a function --- and executes a nested block of steps for each item. Each iteration runs in an isolated context that inherits the outer scope. The `append_to` directive on any inner step accumulates results across iterations into a named list variable in the outer context, enabling assembly steps to combine the results after the loop completes.

``` yaml
- name: process_each_scene
  type: for-each
  input: "${scene_list}"
  item_var: scene
  steps:
    - name: bodies
      type: llm
      prompt:
        file: prompts/bodies.gpt
        inputs:
          scene: "${scene.title}"
          text:  "${scene.greek_text}"
      outputs: bodies_content
      append_to: bodies_list    # accumulated in outer context
        
```

Nested `for-each` loops are supported, enabling pipelines that process, for example, every verse within every pericope within every book.

### type: if {#step-if}

Evaluates a condition expression and, when true, executes a nested block of steps. When false the entire block is skipped. This is distinct from the step-level `condition:` field (which skips a single step) --- `type: if` guards a multi-step block as an atomic unit.

``` yaml
- name: add_cultural_notes
  type: if
  condition: "${include_culture}"
  steps:
    - name: generate_culture
      type: llm
      prompt:
        file: prompts/culture.gpt
        inputs:
          passage: "${passage}"
      outputs: cultural_notes
    - name: save_culture
      type: save
      content: "${cultural_notes}"
      saveas: "output/${passage_info.filename_prefix}_culture.md"
        
```

## Variable Resolution {#variables-syntax}

Scripture Pipelines uses two distinct syntaxes for variable substitution, each appropriate to its context.

Within the YAML pipeline file, `${variable}` resolves values from the context map. Dot notation accesses nested fields of JSON objects: `${scene.title}`, `${passage_info.book}`. Array indexing and mapping are also supported: `${scene_list[0]}` and `${scene_list[*].title}` (which extracts all `title` fields as a flat list). Expressions can also be evaluated inline: `${len(results) < 3}`.

Within prompt files (`.gpt`) and Markdown templates, `{{variable}}` is used instead. The same dot notation and indexing apply. The two-syntax convention makes it immediately visible, when reading either a pipeline or a prompt file, which layer owns the substitution.

## Prompt Contracts

Each prompt file carries a YAML frontmatter header declaring the variables it requires and those it optionally uses. The linter validates that the pipeline supplies every required variable before execution begins, preventing runtime failures that would otherwise surface only after expensive preceding steps have already run.

<figure id="fig-prompt-contract">
<pre><code>---
requires:
  - lemma
  - evidence
optional:
  - prior_senses
---
For the lemma {{lemma}}, using the following evidence:

{{evidence}}

Produce a JSON sense inventory. For each sense, include an
&quot;abbott_smith_audit&quot; field listing every Abbott-Smith entry you
were given, recording whether you retained, transformed, or could
not support it with corpus evidence.
        </code></pre>
<figcaption>Prompt file with contract header</figcaption>
</figure>

The audit field in the last example above is a prompt-level accountability contract: by requiring the LLM to enumerate its sources in a structured JSON field, I can verify whether the model actually engaged with the evidence it was provided.

## Retry Conditions {#retry}

Any step may declare a `retry` block specifying a maximum attempt count, a delay between attempts, and an optional condition expression. If the condition evaluates truthy after a successful attempt --- or if the step raises an exception --- the step re-runs up to the maximum count. This is how the Hebrew Phrasing pipeline handles truncated outputs: the condition checks whether the phrasing analysis is shorter than expected or ends mid-phrase, and retries with the attempt number injected into the prompt so the model knows it is being asked to try again.

``` yaml
- name: analyze_chunk
  type: llm
  prompt:
    file: prompts/phrasing.gpt
    inputs:
      chunk: "${chunk}"
      attempt: "${_retry_attempt}"
  outputs: analysis
  retry:
    max_attempts: 3
    delay_seconds: 2
    condition: "${len(analysis or '') < 500}"
      
```

## Debugging: \--stop-after and \--rewind-to {#iteration}

Two CLI flags turn the pipeline into a checkpoint graph rather than an atomic computation. `--stop-after STEP` executes through the named step and halts, leaving all intermediate outputs on disk. `--rewind-to STEP` re-runs from the named step forward, reading all prior steps\' outputs from disk rather than recomputing them. Requirements for rewinding: the step must declare `saveas` pointing to a single file, and that file must exist.

Together these flags make the core iteration loop --- inspect intermediate output, revise a prompt, rerun from that step --- take seconds rather than hours even in pipelines that cost significant money to run from scratch. In the SemLex Greek pipeline, `--stop-after gather-evidence` is a standard review checkpoint before committing to the downstream sense-building steps. In Discourse Flow, `--stop-after segment_book` lets a scholar verify pericope boundaries before the expensive per-pericope loop runs.

# Structured Directory Structures and Audit Trails {#audit}

Scripture Pipelines pipelines save every intermediate result to the filesystem. Output paths are declared explicitly in each step\'s `saveas` field, and Scripture Pipelines creates the necessary directory structure automatically.

For a Greek lexicon, a flat output directory is unworkable at scale: the UTF-8 sort order of Greek lemmas groups entries in ways that make navigation difficult, and a single directory with thousands of files is unwieldy. Scripture Pipelines\' `saveas` field accepts a `group_by_prefix: 2` option that inserts a subdirectory named after the first two characters of the lemma --- using the actual Greek Unicode characters --- before the lemma\'s own files. The SemLex Greek pipeline uses this throughout:

``` yaml
saveas:
  path: "${output_dir}/intermediate/${row.lemma}.structure.json"
  group_by_prefix: 2
    
```

This produces a tree keyed on the Greek characters themselves:

    obsidian/grc/intermediate/
      ἀγ/
        ἀγαπάω.raw.xml
        ἀγαπάω.structure.json
        ἀγαπάω.semantic.json
        ἀγαπάω.withexamples.md
        ἀγγέλλω.raw.xml
        ...
      ἀδ/
        ἀδελφός.structure.json
        ...
      πι/
        πιστεύω.raw.xml
        πιστεύω.structure.json
        ...
        

Each lemma\'s full multi-pass output --- raw evidence, enhanced analysis, citation verification, sense structure, final formatted entry --- lives together under its prefix directory. This makes it natural to open any lemma\'s folder in an editor or Obsidian vault and inspect exactly what each pipeline pass produced, in the sequence it was produced. The directory tree is also the audit trail: committed to version control, it records the provenance of every generated artifact and makes the full history of a lemma\'s development inspectable by any collaborator.

This persistence strategy has several further benefits. Failures are cheap: if any pass produces unsatisfactory output, only that step needs to be rerun; all prior outputs remain on disk. Any intermediate file can be opened and examined before downstream steps consume it --- or handed to an LLM with the instruction to audit whether it correctly reflects the inputs from the preceding step. When something looks wrong in a final lexicon entry, I can read backward through the saved files to identify which pass introduced the problem.

## Finding Where the Chain Breaks: AI-Assisted Grounding Audits {#audit-step-grounding}

The most damaging pipeline failure is not malformed JSON or a missing field --- it is a step that received its inputs and produced a structurally valid output that does not reflect what it was given. A step that generates study questions about a passage but ignores the exegetical analysis from the preceding step; a step that receives a scene list but generates generic content independent of scene structure; a step that accumulates entity data and gives it negligible weight in its response. These failures pass schema validation. They are visible only as content problems to a reader who knows what the intermediate data should have contributed.

Because all intermediate outputs are persisted to disk, the auditing workflow is tractable. Given two consecutive intermediate files --- step N-1\'s output and step N\'s output --- an LLM can be asked directly: does step N\'s output reflect the content of step N-1? Are the specific features, entities, or analytical conclusions from step N-1 visible in what step N produced? If not, which are absent, and where would you expect to find them? This audit can be applied at any step boundary, in either direction: forward from a suspect input toward its consumers, or backward from a poor final output toward the earliest step whose output is adequate.

The standard approach when something looks wrong in a final output is to work backward through the saved intermediate files. At each step boundary, the adjacent intermediate files are given to an LLM for a grounding audit. The first boundary where the audit finds missing grounding is where the prompt needs revision --- not the final step, which is often the visible surface of a failure that originates earlier. `--stop-after STEP` runs the pipeline to a checkpoint and halts; after identifying the failing step, `--rewind-to STEP` reruns from that prompt forward once it is revised. The cost of a revision iteration is one step forward, not a full pipeline rerun.

This technique depends on design decisions made at construction time. Prompts that explicitly instruct the model to account for each named input invite scrutiny; prompts that pass large context blocks without specifying how they should be used give the model latitude to underweight them silently. Adding grounding accountability fields to intermediate JSON schemas --- fields that require the model to enumerate which features of a prior step\'s output it drew on, and why --- converts this failure mode from invisible to detectable. When the field is absent or sparse, the output is suspect. The same accountability pattern that the SemLex Abbott-Smith audit uses for source enumeration applies at the inter-step level: making grounding explicit in the schema turns a silent pipeline failure into a checkable contract.

## Identifier Consistency: A Persistent Debugging Problem {#audit-identifier-consistency}

A specific failure mode that recurs across all Scripture Pipelines projects is identifier inconsistency: a key produced in one step does not match the form expected by a later step that tries to look it up, join on it, or use it as a filename. The failure is frequently silent. The later step receives an empty result or a missing file, may produce no output, and continues --- leaving nothing in the intermediate files except the absence of what should have been there. Schema validation cannot catch it; input and output are both structurally valid. The symptom appears as thin or missing content in the final output, and tracing it back to a key mismatch several steps earlier takes time proportional to how many steps the mismatch has silently propagated through.

The cases that have occurred in practice span several categories:

-   *Passage reference forms.* A pipeline uses the passage `Mark 10:46-52` as an entry point. One step normalizes it to a filename prefix `mark-10-46-52`; a later step, written independently, constructs the lookup key as `MRK_10_46` from the USFM book code. Two keys for the same passage that are generated independently in different steps never match. The full Paratext and USFM ecosystem uses several different book code conventions --- `MRK`, `Mrk`, `Mark`, `mr` --- that collide across data sources.

-   *Scene identifiers generated by an LLM.* A step produces a scene list in which scene IDs are LLM-generated strings: `"Scene 1: Bartimaeus by the Roadside"`. A subsequent step iterates over this list and writes one intermediate file per scene, using the scene ID as the filename stem. The file is written as `scene-1-bartimaeus-by-the-roadside.json`. A third step reads the scene file by constructing the path from the scene ID stored in the context. If the normalization function in step two differs from the one in step three by any detail --- case, whitespace handling, truncation of long titles --- no file is found and the step produces empty output. If the steps were written in different sessions, the divergence may not be noticed until a passage with a long scene title triggers the truncation case for the first time.

-   *Lemma Unicode normalization.* Greek lemma strings may arrive from different data sources in different Unicode normalization forms, or with different accentuation conventions for the same lexical form. Abbott-Smith entries, SBLGNT word data, and the Macula Greek lemma column follow different conventions at the edges. A join on lemma string that works for the 500 most frequent lemmas fails silently for less common forms with precomposed vs. decomposed diacritics or aspirate/smooth breathing differences.

-   *Entity and word IDs across datasets.* ACAI entity records are anchored to Macula node IDs; the Levinsohn LGNTDF annotations use word-level indexes in their own sequence. A step that tries to join Levinsohn features with ACAI entity occurrences needs a shared anchor that both datasets use. If the join key is constructed differently in two plugin functions written independently, the join produces an empty result that no schema check catches.

The design rule that has proven most effective is: never use an LLM-generated string as a join key or filename. LLMs produce natural language labels; normalization to canonical identifiers must happen in a deterministic function step that is versioned and testable. The `plugins/` directory in each project contains normalization utilities --- `scene_id_normalize()`, `passage_key()`, `lemma_normalize()` --- that are the single canonical transformation from input string to stable key. All steps that produce or consume a given key form call the same function. When the normalization rule changes, one function changes and the mismatch surface collapses to a single version.

Intermediate JSON files are the detection layer. Each scene entry stores both the human-readable label (for display and audit) and the normalized ID (for all downstream use). When an ID mismatch is suspected, `--stop-after` at the producing step lets the author inspect which IDs were written and compare them against the IDs the consuming step would construct --- before the consuming step has executed and produced empty output. Catching the mismatch at the producing step costs one rewind; catching it after three downstream steps have silently propagated the empty result costs four. The discipline of reading intermediate files before building on them is the same discipline required for grounding audits; identifier consistency and content grounding are both visible in the same files, at the same checkpoint.

## Prompt Organization for Dual-Audience Readability {#audit-prompt-organization}

LLM prompts are unique technical documents: they must be simultaneously readable by humans (for verification, maintenance, and debugging) and by AI systems (for accurate task execution). Like XML schema documentation---which must be both human-readable prose and machine-processable constraint definitions---prompts encode both the transformation rules and examples demonstrating those rules. Poor organization creates cognitive overload for both audiences.

Working with AI in production environments, the danger of humans and AIs getting overwhelmed by data and chasing tangents is very high. A 500-line prompt processing biblical passages with 50+ input fields and complex transformation rules is not a toy example---it is a specification document where both audiences must find what they need quickly or fail. Good results require deliberate design and infrastructure to overcome this cognitive load.

1.  **YAML Frontmatter** --- Machine-readable metadata (required/optional inputs, output format)

2.  **WHAT THIS PROMPT PRODUCES** --- Purpose statement and conceptual model for both audiences

3.  **OUTPUT FORMAT** --- JSON schema with wording guidelines

4.  **TASK SECTIONS** --- Each major transformation gets its own complete section containing:

    -   *Input: Where to Find the Data* --- Explicit field mappings preventing hallucination

    -   *Transformation Rules* --- With ✅/❌ examples showing correct/incorrect patterns

    -   *Examples: Input → Transformation → Output* --- Complete worked examples (with TODOs for manual completion)

    -   *Rules Specific to This Output Type* --- Task-specific constraints

5.  **COVERAGE & QUALITY CHECKLIST** --- Pre-submission verification for AI self-checking

6.  **INPUT DATA** --- Template variable instantiation

7.  **CRITICAL REMINDERS** --- Final guardrails

### Reducing Cognitive Load: Information Scent and Locality of Reference {#cognitive-load-reduction}

The cognitive science principle of *locality of reference*---that related information should be physically proximate---applies equally to both human and AI readers. When a programmer searches for \"the rule about Notice questions,\" they should find everything about Notice questions in one section. When an AI encounters transformation rules, it should find the input data sources and examples in the same context window, not 300 lines away.

*Information scent*---the ability to predict where to find specific information---determines whether a prompt is maintainable at scale. Can you predict where the rule about background usage will be? (In the section about Imagine questions, where background is used.) Can you predict where the data source for `treasure_verb` is documented? (In the Input subsection of the Hearts section, where that field is generated.) When scent fails---when rules are scattered, examples are separated from what they exemplify, or data sources are mentioned once in a different section---both humans and AIs waste cognitive resources searching rather than understanding.

**For Humans:**

-   *Locality of reference*: Everything about \"Notice questions\" lives in the Notice section. No searching across 500+ lines for scattered rules. A human debugging a problem can open the relevant section and see the complete specification: what data is available, what transformation is required, what the output should look like, and what the constraints are.

-   *Verifiable transformation*: Given this input data, following these rules, we expect this output. Debugging failures becomes systematic. The input-rules-output co-location makes it possible to trace from a bad output back to either insufficient input data or misapplied rules.

-   *Explicit data grounding*: \"This output field comes from `verses.heart_movements[].treasure_verb`\" prevents AI from fabricating content and makes human review feasible. A reviewer can verify that every output field has a documented source.

**For AI:**

-   *Co-located context*: Rules, examples, and data sources appear together in the context window. Like XML schema documentation where the constraint definition, prose explanation, and usage examples are proximate, prompts that co-locate these elements reduce the AI\'s need to \"remember\" that the data source was mentioned 200 lines earlier. In production prompts processing hundreds of verses with dozens of fields, context window management is not theoretical---it determines whether the AI can maintain coherent understanding across the full specification.

-   *Progressive refinement*: The structure mirrors the AI\'s processing: What am I making? → How do I format it? → What data do I have? → How do I transform it? → What are the constraints? This sequencing prevents the AI from chasing tangents by establishing the output structure before introducing the input data.

-   *Example-rule alignment*: Transformation rules immediately followed by examples that demonstrate those rules creates reinforcement without requiring the AI to associate scattered examples with abstract rules stated elsewhere. This is the prompt equivalent of XML schema\'s inline annotations---the explanation appears precisely where it is needed.

The parallel to XML schema documentation is instructive: both are formal specifications that must be machine-processable while remaining human-readable. Both succeed when structure makes information predictable. A well-organized XML schema lets a developer predict where to find the constraints for a particular element. A well-organized prompt lets both programmer and AI predict where to find the data source, transformation rules, and examples for a particular output field. The markup differs, but the information architecture principle is identical.

### Audit Infrastructure for Prompt Quality {#audit-infrastructure-for-prompts}

The audit skill enforces three principles essential for production quality:

1.  **Input Data Grounding (Prevents Hallucination)**: Every output field must have a documented input source. \"Generate questions about what characters treasure\" is ungrounded. \"`heart_aspect` field must use `treasure_verb` from `verses.heart_movements[]` where `certainty` is high\" is grounded. The audit verifies this mapping exists.

2.  **Example Diversity (Prevents Overfitting)**: Examples from a single passage train the AI on specifics, not patterns. The audit counts distinct passages and narrative types, flagging single-source examples.

3.  **AI-Generated Example Detection (#1 Source of Problems)**: Nothing produced by an LLM can be used as training data in prompts. AI-generated examples encode patterns the AI already knows, not the precise pattern the human intends. The audit compares current version with last commit, flagging ANY new examples for human review. This breaks the feedback loop where AI output becomes AI input, preventing drift from intent.

### Measured Impact in Production Use {#measured-impact}

These are not toy examples. The prompts under discussion generate Bible study questions from passages in Mark, Psalms, Genesis, and Ruth---processing verse-level data enriched with sensory details, cultural background, character heart movements, and narrative structure annotations. A single passage may involve 50+ input fields across multiple JSON files. Without deliberate organization to combat cognitive overload, both humans and AIs get lost in the data.

Measured results from reorganizing production prompts:

-   *Human maintenance time*: Reorganizing from scattered to task-focused structure reduced \"find the relevant rule\" time from approximately 5 minutes to approximately 30 seconds. When a prompt fails on Psalm 23, the developer can locate the relevant section in seconds rather than re-reading 500 lines searching for scattered rules.

-   *AI consistency*: Co-locating data sources with transformation rules reduced field-source mismatches from approximately 15% to approximately 2% (measured over 50 passages across multiple books and genres). The AI stopped fabricating content when the data source was visible in the same section as the transformation rule.

-   *Example quality*: Blocking AI-generated examples and requiring human-written examples eliminated approximately 40% of subtle pattern violations that passed initial review. AI-generated examples looked plausible but encoded the wrong pattern; human examples demonstrated the precise behavior required.

These results suggest that prompts benefit from the same information architecture principles that make technical documentation effective: locality of reference, explicit data flow, worked examples, and human authorship of training data. The task-focused organization serves both human understanding and AI execution by reducing cognitive load through careful information structure. In production environments where prompts process real data at scale, organization is not cosmetic---it determines whether the system produces reliable results or descends into hallucination and inconsistency.

# AI-Assisted Development: Context, Workflow, and Staying in Sync {#development-workflow}

A persistent challenge when using LLMs as development collaborators is keeping the model oriented: knowing which repository it is in, what the pipeline language looks like, what work is in progress, and what it should not touch. Without explicit scaffolding, each conversation starts from scratch --- or worse, the model invents plausible-looking but wrong answers because it lacks project-specific context.

`sp init` addresses this directly by scaffolding a set of AI context files alongside the pipeline and prompt starter files:

-   `docs/ai-context/overview.md` --- project description, directory layout, and canonical references, loaded automatically by GitHub Copilot at the start of every session

-   `docs/ai-context/rules.md` --- guardrails for AI collaborators: respect the YAML schema, keep prompts and pipelines in sync, preserve human editorial ownership of outputs

-   `docs/ai-context/index.md` --- a topic-to-document routing table so the model knows which reference to consult for each class of question, rather than paraphrasing from training data

-   `docs/spl-quickref.md` --- the Scripture Pipelines language in compact form, always available in the project\'s own docs so the model understands the pipeline language without needing the upstream engine repository in scope

-   `.github/copilot-instructions.md` --- session start instructions: read `project/TODO.md` first, explain before implementing, lint and dry-run before executing, link issues from `project/TODO.md`

-   `project/TODO.md` --- the live task list with active work, backlog, and done items; the AI reads this at session start to know the current state of the project

The copilot instructions and AI context together solve a practical synchronization problem: the LLM understands what YAML keys are valid, what the prompt contract syntax looks like, and what work is in flight --- without my needing to explain any of it at the start of each session. Because the AI context files are in the project repository and committed to version control, they stay in sync with the pipelines and prompts they describe. When the pipeline language gains a new step type or the project priorities shift, updating the AI context is a first-class development task, not an afterthought.

Maintaining an AI context directory introduces its own engineering discipline. Volume and organization affect model behavior in measurable ways. Large language models exhibit a \"lost in the middle\" effect: content near the beginning and end of a long input is weighted more heavily than content in the middle, regardless of relevance. Irrelevant context is not neutral --- it actively competes with signal, making the model less likely to surface the relevant portion than if only the relevant text had been provided. A sprawling context file that accumulates every fact about a project will degrade the quality of answers involving only a small corner of it.

The `docs/ai-context/index.md` routing table addresses this directly: rather than loading all context files at once, the model is instructed to read only the file that covers the specific question at hand. Each context file opens with two lines that cannot be skipped: a \"use this file for\" trigger that identifies the topics it covers, and a size budget --- for example, "Budget: 150 lines / 5KB. If adding content would push past this, split into a new file and add a row to `index.md`." The budget line serves a second purpose: it tells any future contributor, human or AI, exactly what to do when a file grows too large, rather than leaving that decision to accumulate silently across sessions.

The same logic that governs prose documentation applies here. Tables are preferable to prose for lookup-oriented content; brief declarative bullets outperform explanatory paragraphs; and tutorial material belongs in `docs/` rather than in the AI context directory. The AI context files are not documentation for human readers --- they are a precision instrument tuned to a specific retrieval task, and they should be maintained as such.

## Test-Driven Development and the Issue Lifecycle {#tdd-workflow}

Scripture Pipelines\' own engine is developed test-first, and the same discipline applies to resource repositories. The standard workflow for any meaningful change:

1.  Review the project board; pick the highest-priority open issue

2.  Write a failing test that specifies the expected behavior --- for a pipeline change, this means asserting on the structure of intermediate JSON or on context variable values after the step runs

3.  Implement until the test passes

4.  Run the full test suite to confirm no regressions

5.  Commit with a message that references the issue number; close the issue

The LLM collaborator participates in every step. Because `.github/copilot-instructions.md` instructs it to explain before implementing, to lint pipelines before running them, and to reference issues from `project/TODO.md`, the model operates as an informed contributor rather than an autonomous agent. I am the architect and the one who holds the critical domain knowledge the model does not have: which datasets exist and are trustworthy, what the project is trying to accomplish, which approaches will work for this community, and what the output must ultimately be. The model implements what I specify and handles the mechanical work of drafting tests, running lint cycles, and wiring pipeline steps. The result is a TDD discipline maintained across sessions because the AI context enforces it --- but the constraints in that context are entirely my contribution.

The issue tracker serves a third role beyond backlog management and upstream bug reporting: it is the live design forum. When a feature is complex enough that the right approach is not obvious, the design conversation belongs in an issue thread, not in a document that must be kept in sync. In the Discourse Flow nested pericope work, issue #3 captures the *what* --- the rhetorical case for nested pericopes, the proposed schema, the triggering conditions --- while issue #5 was opened specifically to carry the *how*: the two-pass pipeline design, the new prompt contract, the checkpoint implications. Design decisions and their rationale are recorded as comments as the thread evolves. The entire trajectory from initial proposal through two design revisions is preserved in the issue thread, not in a design document that might drift out of sync with the implementation. When implementation begins, `project/TODO.md` links to both issues; when it is complete, the issues are closed with commit references. The issue tracker is not only where completed work is recorded --- it is where in-progress thinking is visible and revisable before any code is touched.

## What Is Easy and What Takes Work {#collaboration-texture}

Working with an AI development collaborator across the projects described in this paper has clarified what the tool offloads and what it cannot replace. The distinction shapes how sessions are structured and where my attention must be concentrated.

Format conversion is never where the intellectual work lives. Given a clear intermediate JSON schema and a target format --- USX 3.1, Markdown, a TSV manifest --- the AI produces a correct rendering step on a first or second attempt. The function step that maps JSON scene fields to USX `<para>` elements with the right USFM style codes, the Markdown template that formats a lexicon entry\'s senses and citations, the plugin that extracts verse-range text from a local USFM file: all of these are mechanical from a precise description. The question \"how do I convert this JSON to USX?\" simply does not consume time once shared identifiers are in place. The same is true of pipeline scaffolding: defining step names, wiring outputs to inputs, writing prompt contract headers, implementing retry conditions. If the pipeline steps are clearly described, the AI assembles the skeleton correctly. These are tasks the tool handles; they are not where scholarly judgment is applied.

The decisions that require sustained intellectual engagement are qualitatively different:

-   *Choosing and structuring data sources.* Which dataset to use at each step, what subset is relevant, and how to structure it as prompt input is not mechanical. Deciding that Levinsohn LGNTDF annotations should be presented to the segmentation step indexed by verse and grouped by feature type --- rather than as a flat token stream --- requires understanding both the dataset\'s structure and the segmentation task deeply enough to know what structural signal the model must be led to notice. The AI implements whatever structure is specified; specifying it correctly to get the analytical result I want is my work.

-   *Designing accountability fields.* Which aspects of the LLM\'s reasoning to make explicit in intermediate JSON --- which sources to require enumeration of, which judgments to require justification for --- is an epistemological decision. Deciding that the SemLex gather-evidence step must name every Abbott-Smith sense it was given and record whether each was retained or rejected with a reason makes a quality claim about what the lexicon should be accountable to. No tool makes that claim on the lexicographer\'s behalf.

-   *Defining what \"good\" means.* For every step that produces human-facing output, quality criteria must be specified precisely enough that a domain scholar or focus group can evaluate a pass or fail. What makes a Connecting question genuinely grounded in textual tension rather than generically moralistic? What makes a pericope segmentation defensible? These criteria can be written into context files and prompt instructions --- but they must first be worked out by practitioners who know the material.

-   *The explanation phase as error prevention.* The discipline of requiring the AI to explain what it is about to do, in full, before touching any file reliably surfaces misunderstandings that would otherwise become incorrect implementations. In the hebrew-phrasing project, it caught a suffix-gloss fix script that would have applied the wrong pronoun form for hundreds of rows before a line of code was written. In Ears to Hear, it surfaced a misunderstanding about whether a scene-id normalization function should operate on the raw LLM string output or the parsed AST. In both cases the problem was visible in the explanation paragraph. The discipline works because explanation commits the model to a specific interpretation --- and a committed interpretation can be evaluated before any file is modified.

-   *Recognizing which computations are stable.* AI collaborators readily propose uniform designs --- data structures where all outputs use the same identity key, pipelines where every step depends on the same computed artifact. My advantage is understanding which computations are stable and which are not: which outputs represent ground truth inherent in the source text (a verse reference exists independently of any analysis) and which represent conclusions the pipeline computed (a scene boundary is where we decided to put it, and we may decide differently next month when upstream discourse data improves).

    In the Ears to Hear enrichment pipeline, the initial design proposal keyed every enrichment result --- background items, heart movements, layer2 interpretations, narrator signals --- by the LLM-produced scene identifier. I interrupted it with a question: "Some of these things could depend on the verse, not the scene. If the scene boundaries change, a lot of other things could be stable --- are you sure you want everything to depend on our computed scenes?" The AI worked through it field by field and arrived at a different design: a `verse-atlas` keyed by verse reference (stable; survives any future re-segmentation, because verse references are ground truth in the source text) and a `scene-synthesis` keyed by scene (cheap to rerun when scenes change, because the expensive verse-level exegetical work has already been preserved).

    Neither output structure nor the distinction between them required knowledge the AI did not have. What was required was recognizing that the two artifacts had different durability requirements --- a judgment about the pipeline\'s own lifecycle that only I could make, knowing the planned upstream changes. The redesign took one exchange. The original design would have caused expensive rework the first time scene boundaries were revised. This pattern --- seeing the time dimension of the design, recognizing that one layer is load-bearing and volatile, and redirecting before any code is written --- recurs across all Scripture Pipelines projects and is not detectable by any automated check. I am the one who knows the project will still be running in six months.

-   *Catching a metric that looks like a content judgment but isn\'t.* The Discourse Flow nested pericope feature (issue #3) triggered a discussion about what condition should cause a pericope to be subdivided in a second analysis pass. The initial proposal was a verse-count threshold: subdivide any pericope exceeding N verses. This is a pipeline-level number and straightforward to implement. The question I asked was: what is the threshold actually a proxy for? In this case, the answer was already in the pipeline\'s own output. The `segment_book` step, as instructed, already records why each sub-threshold signal was considered but not elevated to a boundary --- the reasoning is present in the `boundary_rationale` prose. A verse count threshold would have subdivided long pericopes that were rhetorically unified and left short pericopes with genuine internal cast or setting shifts untouched. The right trigger was a new structured field --- `internal_subdivision_signals` --- that asked the segmentation pass to collect those subordinated signals explicitly. If the array is non-empty, a subdivision candidate exists; if not, the pericope is left flat regardless of its verse span. The AI implemented the correct design in a single exchange once the question was framed correctly. Framing it correctly required recognizing that verse count and discourse signal presence are different kinds of thing --- a judgment about what the pipeline is actually measuring that no automated check surfaces.

The sessions producing the case studies described in this paper used GitHub Copilot running on Claude Sonnet as the development collaborator throughout --- the same model cited in the hebrew-phrasing subsection below. The workflow described here is not an idealization; it is a description of actual practice. The `project/TODO.md` file functions literally as session state: it carries the task in progress, blocked items with their blockers, and completed items with their git commit hashes. A session begins with the AI reading the TODO and confirming what it is working on; it ends with the change committed and the done record written. In between, I architect the solution. Not just specifying what to implement, but bringing knowledge the AI does not have: that Levinsohn\'s discourse annotations exist and are the right foundation for pericope segmentation; that a particular fix script needs to distinguish possessive from object pronouns based on the preceding token\'s grammatical class; that a proposed approach to scene-id normalization will break downstream rendering in a way that only someone who knows the full output pipeline can anticipate. The explanation phase catches the cases where the AI\'s interpretation diverges from what I intended; I then correct it, often because I know something critical that was never written down. The `copilot-instructions.md` is not documentation --- it is the active working memory and constraint system that makes the collaboration trustworthy across the many sessions a project requires. But the vision encoded in those constraints, and the judgment that shaped them, are entirely mine.

# Scholarly Data Sources {#data-sources}

Pipeline steps are only as good as the data they can access. Before examining the specific datasets that current Scripture Pipelines projects draw on, it is useful to distinguish the access patterns available and when each is the right choice. The Nida Institute projects described here use all four.

## Data Access Patterns {#ds-access-patterns}

Four structurally distinct patterns are available for bringing data into a pipeline step. The choice among them is a design decision: it determines reproducibility, infrastructure requirements, and how much retrieval reasoning the model is asked to contribute.

-   *Filesystem files from version-controlled repositories.* The most common pattern in current projects. Macula Hebrew TSV data, the Levinsohn LGNTDF dataset, ACAI entity JSON, and source transcriptions all enter pipelines through `type: function` or `type: tsv` steps that read a local file path, filter by passage reference or entity key, and return structured data to the pipeline context. Appropriate when the dataset is stable, versioned, and small enough to clone. A pipeline that draws only on local files is fully deterministic: any collaborator with the same clones runs identically, and the data version is recoverable from the upstream repository\'s git history. No running server, no authentication, no API quota.

-   *Database queries (BaseX or similar).* The right pattern when data is large, structured as XML, and requires principled subset selection. The planned `type: xquery` step executes XQuery expressions against a BaseX database --- the natural fit for the full Macula corpora, syntactic treebanks, and lexicon collections. Appropriate when the retrieval question is structural: all occurrences of a grammatical construction across the Pauline epistles; all tokens in a passage with their treebank parent relationships; all lexicon entries in a semantic domain. These queries can be approximated with file-loading filters, but XQuery expresses them precisely and the query itself lives in the pipeline as part of its data transformation record. A `--stop-after` at the query step lets the author inspect the returned data and refine the query before any expensive LLM step downstream executes.

-   *MCP (Model Context Protocol).* The right pattern when data retrieval is itself a reasoning task --- when what to fetch depends on what the model is processing, not on a fixed reference. In the Ears to Hear pipeline, the `enrich_passage` step gives the LLM access to MCP tools: it fetches passage text, then looks up entities it encounters, then retrieves word-sense data for terms it judges significant --- potentially 40 tool calls within a single LLM step. The model decides the retrieval sequence; the pipeline declares only which MCP server to connect to. Appropriate when the relevant data subset is not known until the model is reasoning about the content, or when the data source is dynamic or externally managed. The cost is indeterminism: two runs may follow different tool-call chains. The structured JSON capturing the enrichment output records what was actually fetched, restoring auditability downstream. MCP should be reserved for steps where reasoning-driven retrieval genuinely adds value; static lookups belong in deterministic function steps.

-   *Pipeline context data.* The flow of outputs between steps within the pipeline itself. Every step that declares `outputs: some_variable` makes its result available downstream via `${some_variable}`. This is the default data-flow mechanism, and it requires a specific discipline: it is straightforward to write a prompt that nominally *receives* a variable but gives it little weight against the surrounding context, or where the instructions do not tell the model how to relate the variable to the task. A step that receives earlier pipeline outputs but fails to ground its response in them is one of the most common silent pipeline failures --- and the subject of the AI-assisted grounding audit technique described in the previous section.

## Datasets Used in Ears to Hear {#ds-current}

The Ears to Hear case study draws on multiple scholarly datasets, accessed through a combination of `type: function` steps, `type: tsv` steps, and MCP tool calls. The following datasets are used across the book summary, discourse analysis, and leaders\' guide pipelines:

-   *Macula Greek* [bibliomixed_title](#ref-macula-greek) (Clear-Bible / unfoldingWord): Morphologically annotated Greek New Testament with syntactic treebanks. Includes lemma, gloss, part of speech, person/gender/number, case, and full dependency syntax trees. Accessed via MCP tools (`get_word_info`, `get_word_sense`) in narrative enrichment, and directly via JSON files in book-level synthesis. The Ears to Hear pipelines primarily use the morphological and lexical layers; the syntax trees, while available in the same dataset, are used more extensively in other Scripture Pipelines projects.

-   *ACAI (Ancient Chains of Annotation Integration)* [bibliomixed_title](#ref-acai) (Rick Brannan / Mission Mutual, CC BY-SA 4.0): Biblical entity annotations covering people, places, flora, fauna, deities, groups, realia (e.g., `realia:Denarius`), and keyterms. Anchored to Macula node IDs, allowing precise verse-range lookup. Accessed both via MCP tools (`get_acai_entities_for_passage`, `get_acai_entity_detail`) and via local JSON files with a book-specific index. Used in narrative enrichment, book summaries, and scene synthesis to identify participants, cultural objects, and geographic context.

-   *Levinsohn LGNTDF* [bibliomixed_title](#ref-lgntdf) (Steven H. Levinsohn, Biblical Humanities): Word-level discourse feature annotations for the Greek New Testament encoding Levinsohn\'s discourse grammar categories --- cataphoric focus markers, point-of-departure shifts, vocatives, boundary markers, and connective particles. For 1 John alone this dataset contains 806 word-level annotations. Used upstream in the Discourse Flow (Greek NT) pipeline for pericope segmentation; Ears to Hear consumes the resulting scene boundaries and discourse structures indirectly through the scene-overlay JSON produced by Discourse Flow.

-   *Levinsohn & Samuel HOTDF* [bibliomixed_title](#ref-hotdf) (Steven H. Levinsohn and David Samuel): Word-level discourse feature annotations for the Hebrew Old Testament, encoding similar discourse grammar categories (end-dislocation, continuation, ellipsis, DFE markers). Used upstream in the Discourse Flow Hebrew pipeline for pericope segmentation in Hebrew Bible projects. Like LGNTDF for the Greek New Testament, this dataset provides the scholarly foundation for discourse-aware scene boundaries, preventing the LLM from imposing arbitrary chapter divisions on narratives that cross traditional boundaries.

-   *SBLGNT* [bibliomixed_title](#ref-sblgnt) (Society of Biblical Literature Greek New Testament): The base Greek text for all Greek New Testament pipelines, accessed via the pipeline `source: SBLGNT` variable and resolved by a built-in Bible reference function step, or fetched via MCP (`get_passage_text`).

Additional datasets are used in other Scripture Pipelines projects: Macula Hebrew [bibliomixed_title](#ref-macula-hebrew) and MorphHB [bibliomixed_title](#ref-morphhb) for Hebrew Phrasing, SDBH [bibliomixed_title](#ref-sdbh) for lexical work, and the full catalog of 20+ datasets is maintained in the dataset registry [bibliomixed_title](#ref-awesome-biblical-data). The Discourse Flow pipelines (both Greek NT and Hebrew OT), which apply Levinsohn\'s discourse grammar framework [bibliomixed_title](#ref-levinsohn-book) to identify pericope boundaries, are foundational dependencies for projects like Ears to Hear that require discourse-aware segmentation as input.

## Data Source Integration Architecture {#ds-integrations}

Scripture Pipelines integrates structured scholarly datasets through two mechanisms: format-specific step types for external systems, and a dataset registry for automatic discovery and local caching.

### Supported Systems and Formats {#ds-systems}

The following systems and formats are currently supported:

-   *Paratext projects and Scripture Burrito packages* [bibliomixed_title](#ref-usfm) [bibliomixed_title](#ref-scripture-burrito): Scripture source utilities allow pipelines to read any translation or back-translation stored in a local Paratext installation or Scripture Burrito bundle --- USFM 3.1 and USX 3.1 formats --- and present it as a structured verse-range input. This means a pipeline can be run against any translation in a Paratext project directory without manual export: back-translation checks, discourse analyses, and leaders\' guide pipelines all become immediately applicable to local translation work in progress.

-   *BaseX XML database queries* [bibliomixed_title](#ref-basex): A `type: xquery` step type allows pipelines to query BaseX XML databases containing Macula Greek and Hebrew corpora, syntactic treebanks, semantic domain data, and lexicons. XQuery or XPath expressions are declared directly in pipeline YAML, and results flow into downstream LLM steps as structured context. This is the natural complement of BaseX\'s role in existing XML publishing pipelines, and the integration point at which Scripture Pipelines connects most directly to the XML database tradition that Balisage audiences will recognize.

-   *DuckDB tabular analytics* [bibliomixed_title](#ref-duckdb): A `type: duckdb` step type allows pipelines to execute SQL queries against structured tabular data (CSV, TSV, Parquet, JSON). DuckDB is an in-process analytical database optimized for data science workflows --- it runs without a server, loads data directly from files, and executes aggregations and joins at speed. This is the natural fit for statistical analysis: frequency distributions across a corpus, co-occurrence matrices for lexical studies, morphological feature counts, or passage-level metrics that require grouping and aggregation. The query results flow into downstream LLM steps as structured context, allowing the model to interpret patterns the SQL has surfaced.

### Dataset Registry and Automatic Provisioning {#ds-registry}

Scripture Pipelines maintains a dataset registry (`~/.sp/datasets/`) that catalogs available scholarly datasets with their identifiers, formats, licenses, and download locations. When a pipeline declares a data dependency, the engine checks the registry, downloads the dataset if needed, and caches it locally. This removes the manual step of \"find the right data source, download it, and put it where the pipeline expects it.\" The registry currently catalogs 20+ datasets, including:

-   *Macula Greek and Hebrew* [bibliomixed_title](#ref-macula-greek) [bibliomixed_title](#ref-macula-hebrew) --- Full morphologically annotated corpora with syntactic dependency treebanks for both the Greek New Testament and Hebrew Bible (Clear-Bible, CC BY-SA 4.0). Includes lemma, gloss, morphology, and complete syntactic trees with head and dependent relationships.

-   *ACAI (Ancient Chains of Annotation Integration)* [bibliomixed_title](#ref-acai) --- Biblical entity annotations covering people, places, flora, fauna, deities, groups, realia, and keyterms, anchored to Macula node IDs (Rick Brannan / Mission Mutual, CC BY-SA 4.0)

-   *Levinsohn discourse features* [bibliomixed_title](#ref-lgntdf) [bibliomixed_title](#ref-hotdf) --- Word-level discourse grammar annotations for both the Greek New Testament (LGNTDF) and Hebrew Old Testament (HOTDF by Levinsohn & Samuel), encoding cataphoric focus markers, point-of-departure shifts, boundary markers, and discourse feature elements

-   *SDBH (Semantic Dictionary of Biblical Hebrew)* [bibliomixed_title](#ref-sdbh) --- Lexical database for Hebrew terms with semantic domains and glosses

-   *MorphHB* [bibliomixed_title](#ref-morphhb) --- Morphological annotations for the Hebrew Bible with lemma and part-of-speech data

-   *Greek and Hebrew syntax trees* --- Additional treebank datasets for syntactic analysis (Clear-Bible Trees project)

-   *Alignment datasets* --- Word-level alignments between Hebrew/Greek and English translations

-   *Parser framework datasets* --- Training data and lexical resources for syntactic parsers

-   *Tyndale Bible Dictionary* [bibliomixed_title](#ref-tyndale-dictionary) --- Reference entries for people, places, and concepts

The registry is extensible: new datasets can be added by any project, and the schema supports version constraints, alternative download mirrors, and format specifications that allow the engine to route data to the appropriate step type (BaseX for XML collections, DuckDB for tabular data, direct file access for JSON and TSV).

# Workflow Drivers and the Editorial Lifecycle {#workflow-drivers}

## What Drives the Pipeline {#iteration-axes}

Most Scripture Pipelines scholarly workflows are organized around one of three iteration axes, which determine what the `for-each` loop iterates over and what the pipeline considers one unit of work:

-   *Text-driven:* the passage or book is the primary unit. A pipeline runs per pericope, per chapter, or per book --- as in Discourse Flow (iterating over Levinsohn-derived pericopes) or the Hebrew Phrasing pipeline (iterating over verse chunks). The text reference is the entry point; all other data serves the text.

-   *Ontology-driven:* a structured entity list is the primary unit. The ACAI entity database, for example, enumerates all people, places, flora, fauna, deities, groups, realia, and keyterms in the Bible. A storytelling dictionary pipeline iterates over ACAI entities --- one pipeline run generates one article; the full dictionary emerges from running the pipeline over the complete entity list in citation-frequency order.

-   *Lexeme-driven:* a lemma from a lexicon or a frequency list is the primary unit. The SemLex Greek pipeline iterates over lemmas in a status spreadsheet, processing each one through gather-evidence, build-senses, and verify-citations passes. The relevant text passages are gathered as evidence for the lexeme, not the other way around.

In practice these axes combine: a discourse analysis pipeline may be text-driven but pull entity data from ACAI and lexical data from a Greek lexicon as enrichment context for each pericope. The pipeline language imposes no constraint on which axis is primary; the structure of the `for-each` loop and the data sources loaded in function steps determine it.

## Document Management at Generation Scale {#editorial-lifecycle}

Scripture Pipelines changes the resource model for scholarly reference work. A project that once required a large team of specialists over many years can now be approached with a very small group: one person who knows how to design and maintain Scripture Pipelines projects; a handful of domain scholars who can evaluate output quality and catch errors that only subject-matter expertise can recognize; and focus groups of end users --- translators, pastors, students --- who can tell whether the output actually works for people who are not specialists. The pipeline handles the mechanical work of applying the full weight of the available datasets to every unit of analysis. The humans provide everything else: the vision of what the resource should be, the domain knowledge to know which datasets are relevant and trustworthy, the theological and linguistic expertise to catch what the model gets wrong, and the judgment to decide when output meets the bar for the communities it is meant to serve. The AI does not know that Levinsohn\'s discourse feature annotations exist, or that they are the right data source for pericope segmentation, until I made that architectural decision after studying that literature. The same is true in every case study in this paper: I brought the vision; the pipeline made it executable.

This compressed resource model does not sacrifice thoroughness --- it makes thoroughness possible in the first place. A lexicographer working alone cannot personally evaluate every papyrus citation for every lemma. A pipeline can gather and organize that evidence systematically; the scholar reviews the synthesis. The result is scholarly work grounded in a fuller evidence base than any individual could manually assemble.

The compressed team creates its own management challenge: coordinating feedback from scholars and focus groups, tracking which generated outputs have been reviewed and revised, and ensuring that editorial changes are not silently overwritten by the next pipeline run. Traditional document management problems resurface with new urgency when pipelines can generate hundreds of structured artifacts in a single run. A lexicographer now faces an Obsidian vault containing entries for the 500 most frequent Greek lemmas --- all generated overnight, all needing review, some excellent, some requiring significant revision, and some silently wrong in ways that only a domain expert can recognize. The generation speed creates a new bottleneck: not producing content, but tracking, auditing, and approving it.

Scripture Pipelines\' current approach uses filesystem directory structures as the primary management layer. Generated artifacts live in directories that can be imported directly into Obsidian, Notion, or Google Docs as note collections or document sets, leveraging those tools\' existing features for linking, tagging, commenting, and status tracking. This keeps the editorial infrastructure in tools that domain experts already use, rather than requiring them to learn a specialized review interface.

For Paratext-integrated workflows, USX 3.1 output from Scripture Pipelines pipelines can be loaded directly into Paratext projects, making the generated content a draft translation note or study aid that editors work with in the same environment as the translation itself. This is the natural end state for the Paratext USFM 3.1 / USX 3.1 integration described above: the pipeline reads from a Paratext project and, after editorial review, writes back to it.

The central discipline that keeps this workable is clarity about the *authoritative source*. When a pipeline produces a lexicon entry or a pericope analysis and an editor revises it, that revised file is now the authoritative version. Re-running the pipeline would overwrite it. Scripture Pipelines handles this through two mechanisms. First, the `saveas` field writes to explicit, versioned paths --- the history of every generated artifact is in `git log`. Second, the `sp init --update` flag regenerates only files that carry the `<!-- Generated by sp init -->` marker, leaving hand-edited files untouched. The same principle should be applied to pipeline outputs: files that have entered editorial review should be protected from regeneration, while files still in the generation phase can be freely overwritten.

The practical workflow that emerges is a two-phase process. In the generation phase, I iterate on prompts, intermediate JSON, and output templates --- using `--stop-after` and `--rewind-to` to refine individual steps --- until the output quality consistently meets the bar for editorial review. Then the editorial phase begins: the generated batch moves to human reviewers, the directory becomes read-only to the pipeline, and editors work in Obsidian, Notion, or Paratext. The two phases should not overlap --- and the versioned filesystem makes it straightforward to see when they do. Future tooling will make the boundary explicit with diff-based staleness detection: when a prompt changes after editors have touched its outputs, the system flags the affected files as requiring editorial re-review before the regeneration is accepted.

# Case Study: Ears to Hear {#case-studies}

Scripture Pipelines serves multiple communities: scholars producing lexicons, translation teams working with discourse analyses, beginning students learning biblical languages through structured annotations, and study groups working through Scripture together. The resources span a wide range --- from highly technical (lexicographic sense distinctions, morphological analyses) to accessible (inductive Bible study questions, narrative summaries). But the ultimate purpose is not merely to produce resources. It is to make Scripture more accessible, more carefully understood, more deeply engaged --- by scholars, yes, but also by readers in communities worldwide who bring no academic training yet read these texts with wisdom the academy often lacks. Every freely licensed lexicon, every grammatical analysis, every discourse structure ultimately exists to serve this end: getting people reading Scripture, noticing what is actually there, and carrying something from that encounter into their lives.

**TODO: Edit this list.** Scripture Pipelines is currently being used for:

-   **Semantic Lexicon of Biblical Greek (SemLex Greek)** --- A multi-pass pipeline producing lexicon entries grounded in the full Hellenistic corpus (NT, LXX, papyri, inscriptions), licensed CC BY-SA 4.0

-   **Hebrew Phrasing** --- Grammatical phrase analysis of the Hebrew Bible using Macula Hebrew morphological data

-   **Discourse Flow (Greek NT)** --- Book-level discourse analyses synthesizing Levinsohn features, Macula annotations, and narrative structure

-   **Hebrew Discourse Flow** --- Old Testament book-level discourse analysis pipeline

-   **Ears to Hear** --- Leader\'s guide generation for inductive Bible study, producing questions and narrative summaries from discourse analyses

-   **Internalization Questions** --- Scripture engagement questions designed to help readers internalize biblical content

-   **SDBH Helpers** --- Support tools for the Semantic Dictionary of Biblical Hebrew

-   **Image Scene Descriptions** --- Generating textual descriptions of biblical scenes for visual aids

-   **Paratext Pipelines** --- Integration with Paratext Bible translation software workflows

-   **Macula LXX Greek** --- Processing and analysis of the Septuagint Greek text

The following detailed case study focuses on Ears to Hear, which illustrates how Scripture Pipelines synthesizes scholarly datasets into resources for community Bible study --- bridging the gap between technical scholarship and accessible study materials.

## Ears to Hear: Leaders\' Guide Generation from Structured Data Synthesis {#ears-to-hear}

The Ears to Hear project illustrates the full range of what Scripture Pipelines makes possible: it synthesizes discourse analyses --- hierarchical structures with manually annotated rhetorical features, the kind of technical apparatus scholars spend years learning to read --- together with lexical data, morphological annotations, and entity information, then transforms that scholarly infrastructure into leaders\' guides for everyday Bible study groups. The scholarly data is there, but it is deployed with care: in the right doses, at the right time, with deliberate pedagogy. A cultural note about honor and shame appears exactly when the group is ready to notice what it illuminates in the text, not as front-loaded encyclopedia entries. A lexical observation about what a Greek verb carries appears when the scene makes it matter, not as a grammar lecture. The pipeline serves the encounter; the scholarship serves the reader. The goal is not to produce scholars --- though it creates scaffolding for those who want to climb toward deeper study --- but to get people reading Scripture together: noticing what is actually in the text, asking questions that emerge from observation, and carrying something from the encounter that belongs to them.

Ears to Hear operates as a consumer of the Scripture Pipelines engine from a separate repository (available at <https://github.com/nida-institute/ears-to-hear>). This case study focuses on how the project synthesizes multiple structured data sources --- discourse analyses, lexical data, entity information, and linguistic annotations --- into leaders\' guides designed for oral study groups in diverse cultural contexts. It also examines the challenges of AI-assisted scholarship: how to keep LLM output grounded in source data, how to maintain reproducibility, and how to build shared understanding between human scholar and AI collaborator before the work actually produces trustworthy results.

### Book Summaries: Synthesizing Discourse Analysis and Structured Data {#ears-book-summaries}

Before generating passage-level leaders\' guides, Ears to Hear first produces book-level context summaries. These summaries synthesize data from multiple sources:

-   **Discourse-flow analyses** --- Hierarchical structures (divisions, pericopes, segments) with manually annotated features: topic, genre, participant tracking, rhetorical devices, and structural markers. For NT books, these come from the discourse-flow project (itself a Scripture Pipelines consumer); for OT books, from discourse-flow-hebrew.

-   **ACAI entity database** --- People, places, and things with descriptions, relationships, and verse-level occurrences.

-   **Biblical lexicons** --- Word-sense data for Hebrew and Greek terms, including semantic notes, glosses, and usage patterns.

-   **Source texts** --- WLC (Hebrew) for OT, SBLGNT (Greek) for NT, with morphological annotations.

The pipeline (`build-book.yaml` and its dependencies) first loads discourse-flow JSON to extract scene boundaries, then iterates over each scene to produce verse-level enrichment (entities, lexical data, embodied and emotional analysis), scene-level synthesis (tension threads, character arcs, structural features), and finally book-level summary (narrative arc, tension threads consolidated across scenes, character arcs, structural pivots, and embodied context).

The discourse-flow structure establishes the scene boundaries that Ears to Hear uses to build outlines. Each scene entry includes the canonical reference, discourse-annotated boundary markers (asyndeton, aspect shifts, participant changes), and structural metadata. The following excerpt shows two scenes from the Mark discourse-flow output:

<figure id="fig-discourse-flow-structure">
<pre><code>{
  &quot;book&quot;: &quot;Mark&quot;,
  &quot;book_code&quot;: &quot;MRK&quot;,
  &quot;scene_count&quot;: 26,
  &quot;scenes&quot;: [
    {
      &quot;scene_id&quot;: &quot;MRK-001&quot;,
      &quot;sequence&quot;: 1,
      &quot;canonical_reference&quot;: &quot;Mark 1:1-13&quot;,
      &quot;opening_verse&quot;: &quot;1:1&quot;,
      &quot;closing_verse&quot;: &quot;1:13&quot;,
      &quot;e2h_title&quot;: &quot;Wilderness Voices Announce the Stronger One&quot;,
      &quot;section_title&quot;: &quot;The Prologue: The Way Prepared&quot;,
      &quot;scene_type&quot;: &quot;narrative&quot;,
      &quot;primary_participants&quot;: [&quot;John the Baptist&quot;, &quot;Jesus&quot;, &quot;the crowds&quot;],
      &quot;physical_setting&quot;: &quot;The Jordan River and the Judean wilderness...&quot;,
      &quot;heart_state_shift&quot;: &quot;Jesus moves from hidden private identity to
        publicly revealed and commissioned Son.&quot;,
      &quot;is_subdivision&quot;: false,
      &quot;parent_section_ref&quot;: null,
      &quot;boundary_confidence&quot;: &quot;high&quot;,
      &quot;boundary_rationale&quot;: &quot;Major discourse-flow boundary: asyndeton at
        1:1 opens book; clear thematic/aspectual shift at 1:14.&quot;
    },
    {
      &quot;scene_id&quot;: &quot;MRK-002&quot;,
      &quot;sequence&quot;: 2,
      &quot;canonical_reference&quot;: &quot;Mark 1:14-20&quot;,
      &quot;opening_verse&quot;: &quot;1:14&quot;,
      &quot;closing_verse&quot;: &quot;1:20&quot;,
      &quot;e2h_title&quot;: &quot;Jesus Calls Fishermen to Follow Him&quot;,
      &quot;section_title&quot;: &quot;Jesus&#39; Inaugural Preaching and the Call of the
        First Disciples&quot;,
      &quot;scene_type&quot;: &quot;narrative&quot;,
      &quot;primary_participants&quot;: [&quot;Jesus&quot;, &quot;Simon&quot;, &quot;Andrew&quot;, &quot;James&quot;, &quot;John&quot;],
      &quot;physical_setting&quot;: &quot;The shores of the Sea of Galilee, where
        fishermen are casting and mending their nets.&quot;,
      &quot;heart_state_shift&quot;: &quot;Simon, Andrew, James, and John transition from
        fishermen to followers of Jesus...&quot;,
      &quot;is_subdivision&quot;: false,
      &quot;parent_section_ref&quot;: null,
      &quot;boundary_confidence&quot;: &quot;high&quot;,
      &quot;boundary_rationale&quot;: &quot;Opening: New subject (&#39;ὁ Ἰησοῦς&#39;),
        over-encoding, and aspect shift (aorist to present) at 1:14;
        Highlighter (&#39;ὅτι&#39;) and Focus+ (&#39;πεπλήρωται ὁ καιρὸς&#39;) at 1:15
        mark a new proclamation. Closing: Asyndeton and new subject at 1:20.&quot;
    }
  ]
}</code></pre>
<figcaption>Discourse Flow scene structure for Mark (from scene-overlay.json)</figcaption>
</figure>

The `boundary_rationale` fields cite specific Levinsohn discourse features (asyndeton, aspect shifts, participant over-encoding, Highlighter and Focus+ markers) that justify the segmentation. These discourse-linguistic judgments, made upstream in the Discourse Flow pipeline, prevent the LLM from imposing arbitrary chapter divisions. The Ears to Hear pipeline receives these boundaries as input and builds its study materials respecting the discourse structure of the text.

**Discourse Terminology and Hierarchical Mapping.** Discourse analysts use a technical vocabulary to describe textual structure. A *discourse unit* is any coherent span of text with internal unity and clear boundaries --- ranging from a single clause to an entire book. A *pericope* (from Greek *περικοπή*, \"section cut around\") is a self-contained narrative episode or teaching unit, typically spanning several verses to a chapter. A *segment* is a smaller unit within a pericope, often corresponding to a scene change, participant shift, or thematic development within the larger episode. In Levinsohn\'s framework, these boundaries are identified through grammatical and discourse markers: asyndeton (absence of connectives), aspect shifts (change from perfective to imperfective), participant over-encoding (re-introducing a known participant with full description), and explicit boundary particles.

The Ears to Hear project maps this discourse structure into a three-level hierarchy: *divisions* (major sections of a book, corresponding to large discourse units), *sections* (individual pericopes, what the Discourse Flow pipeline calls \"scenes\"), and *passages* (the verse ranges within a scene for which leaders\' guide questions are generated). The `scene_id` field in scene-overlay.json serves as the stable identifier linking discourse analysis to downstream enrichment and question generation. The `is_subdivision` and `parent_section_ref` fields encode hierarchical nesting when a pericope contains significant internal segments that warrant separate treatment. This mapping preserves the scholarly rigor of discourse-linguistic segmentation while presenting the structure in terms accessible to Bible study leaders who may be unfamiliar with technical discourse terminology.

The book summary prompt (`bookish-book-summary.gpt`) requires the LLM to account for its sources. For the `social_dynamics` field, every claimed pattern must cite at least two verse references. For `character_arcs`, the LLM must describe observable actions (what characters do and say), not psychological states, and cite specific verses. For `structural_pivots`, it must describe what changes before and after the pivot, not merely assert significance. The prompt explicitly forbids inventing material not visible in the input scene-synthesis data.

The following excerpt shows the `narrative_arc` and one `tension_thread` from the Mark book summary, produced by synthesizing scene-level data across all 26 scenes in the Gospel:

<figure id="fig-ears-book-summary">
<pre><code>{
  &quot;book&quot;: &quot;Mark&quot;,
  &quot;narrative_arc&quot;: &quot;Mark opens with Jesus&#39;s public emergence in Galilee,
    marked by prophetic fulfillment, baptism, and early demonstrations of
    unique authority. The narrative unfolds through a rapid succession of
    exorcisms, healings, and confrontations between Jesus, religious
    authorities, insiders, and outsiders, primarily in Galilee (Mark 1-8).
    A pivotal shift occurs at Caesarea Philippi, when Peter confesses Jesus
    as Messiah, and the story turns southward toward Jerusalem. From this
    point, Jesus repeatedly predicts his suffering, engages in escalating
    conflict with authorities, and instructs the disciples on the cost of
    following him. The final third centers on Jerusalem: public acclaim at
    Jesus&#39;s entry, mounting opposition, betrayal, crucifixion, and—abruptly—
    an empty tomb and the commissioning of flawed followers. The book&#39;s
    geography traces a clear arc: Galilee → journey south → Jerusalem and
    the Temple → the cross and the empty tomb.&quot;,
  &quot;tension_threads&quot;: [
    {
      &quot;id&quot;: &quot;mrk-authority-contest&quot;,
      &quot;label&quot;: &quot;Contested Authority: Who can include, restore, or judge?&quot;,
      &quot;description&quot;: &quot;From Galilee to Jerusalem, Jesus&#39;s authority is
        repeatedly challenged by religious leaders, family, and even his own
        disciples. This thread emerges in early exorcisms and healings
        (MRK-003), intensifies in Sabbath controversies and public debates
        (MRK-007, MRK-021, MRK-022), and culminates in the passion narrative
        where both his authority and identity are on trial. The thread is
        dramatically transformed at the cross, as an outsider recognizes
        Jesus as God&#39;s Son.&quot;,
      &quot;scene_ids&quot;: [&quot;MRK-003&quot;, &quot;MRK-005&quot;, &quot;MRK-006&quot;, &quot;MRK-007&quot;, &quot;MRK-008&quot;,
                    &quot;MRK-014&quot;, &quot;MRK-021&quot;, &quot;MRK-022&quot;, &quot;MRK-025&quot;],
      &quot;resolution&quot;: &quot;transformed&quot;
    }
  ]
}</code></pre>
<figcaption>Book summary excerpt for Mark (from book-hierarchy.json)</figcaption>
</figure>

This book-level data then flows into passage-level pipelines, providing leaders with narrative and thematic context before the first session begins.

### Sample Question Output: Scene-Based Inductive Questions {#ears-question-generation}

The passage-level pipeline produces leaders\' guides organized by scene and interpretive lens. Each scene receives questions under four lenses: *Bodies* (the physical, observable world), *Hearts* (inner life revealed through observable actions), *Connecting* (questions that draw observed textual tension into participants\' lived experience), and *Naming* (a short scene title participants choose to carry the story). Questions are first generated as abstract syntax trees (ASTs) in JSON intermediate files, then rendered to Markdown and USX 3.1.

The following excerpt shows the Bodies and Hearts questions for one scene from Mark 12:18--27, generated April 1, 2026, showing the current quality of pipeline output:

<figure id="fig-ears-mark12">
<pre><code>## Scene 1: Seven Brothers, One Wife

*Citation: Mark 12:18-27*

---

### 👣 Enter the Scene with Your Body (Mark 12:18-27)

Let&#39;s hear this part of the story again and pay attention to what it would
be like to be in this scene. What you would you see, hear, smell, taste, or
physically feel? How are people sitting or standing? What do they touch?
How close are they? How are they moving?

#### 👀 Notice

Let&#39;s start with what the scene shows us about bodies, senses, space,
and movement.

_Perspective: the Sadducees_

* What do the Sadducees do at the beginning of this scene?

* What do the Sadducees say to Jesus about Moses and marriage?

* What scenario do the Sadducees describe involving seven brothers and a woman?

* What final question do the Sadducees ask Jesus about the resurrection?

_Perspective: Jesus_

* What does Jesus do in response to the Sadducees&#39; question?

* What does Jesus say about marriage after the resurrection?

    * What passage from Moses does Jesus mention in his answer?

    * What final statement does Jesus make about God and the living?

#### 💭 Imagine

Now let&#39;s imagine this moment from each perspective, still using the
same body questions.

_Background:_
The Sadducees were a wealthy, priestly group in Jerusalem, influential in
the Temple and known for denying the resurrection. They often debated
doctrinal matters with Jesus, seeking to defend their status and beliefs
before the people. Moses, as the lawgiver, is invoked as the authority for
the practice of levirate marriage: if a man dies without children, his
brother is to marry the widow to produce offspring for the deceased. This
legal tradition grounds the Sadducees&#39; question.

_Perspective: the Sadducees_

* You are one of the Sadducees standing before Jesus in the Temple. What
  do you do as you present your question?

    * You are one of the Sadducees. What story do you tell Jesus and those
      listening?

_Perspective: Jesus_

* You are Jesus, surrounded by the crowd and religious leaders. What do
  you say in response to the Sadducees&#39; question?

### 🫀 Enter the Scene with Your Whole Heart (Mark 12:18-27)

Staying inside this scene, let&#39;s ask about people&#39;s hearts—where they set
their hearts, what is at stake, what they fear, and what they hope for.

#### 👀 Notice

Let&#39;s focus on what the text actually tells us about where people are
setting their hearts and what is at stake for them.

_Perspective: the Sadducees_

* Why do the Sadducees bring this question to Jesus?

_Perspective: Jesus_

* Why does Jesus respond so sharply to their question?

    * What is Jesus insisting on when he says God is &#39;of the living&#39;?

### 👂 Let the Scene Speak to Us (Mark 12:18-27)

Let&#39;s notice where the same kinds of pressures, questions, and hopes from
this scene show up in our world today.

1. Have you or someone you know ever found yourself in a conversation where
   it felt like people were more interested in protecting their reputation
   or proving a point than actually seeking understanding?

2. Have you or someone you know ever witnessed someone unexpectedly shift a
   heated debate or tense conversation toward what actually matters most,
   even when everyone else is caught up in details or appearances?

### 🏷️ Step 4: Name the Scene

Let&#39;s choose a short name that captures what stood out to us so we can
carry this part of the story with us.
- Seven Brothers, One Wife
- God of the Living
- A Question in the Temple
- You Are Greatly Mistaken</code></pre>
<figcaption>Leaders' guide excerpt for Mark 12:18–27 (from April 1, 2026 pipeline run)</figcaption>
</figure>

Observe: Bodies questions begin with physical observation (Notice) before moving to embodied imagination; Hearts questions surface inner-life stakes grounded in observable actions; Connecting questions tie observed textual tension to lived experience without moralizing; Naming invites participants to choose their own title. Multiple perspectives are maintained consistently across sections. Source-language text appears alongside English translation, both fetched via MCP.

### Leader\'s Introduction: Preparing the Way {#ears-leader-intro}

Before the questions begin, each leader\'s guide includes an introduction designed to help the facilitator prepare. This is not scholarly apparatus or exegetical commentary---it is practical orientation written for someone who needs to understand what the session will feel like and what challenges or insights might emerge. The following excerpt from the Mark 12:18--27 guide (generated April 1, 2026) shows the introduction structure:

<figure id="fig-ears-intro">
<pre><code>### 2. What This Passage Does

This passage draws the conflict between Jesus and the Jerusalem authorities
into sharper focus. The Sadducees&#39; question is meant to trap Jesus, but he
turns it into a moment of revelation—correcting their misunderstanding and
declaring the hope of resurrection in front of all. Jesus&#39; answer doesn&#39;t
just silence the Sadducees; it reframes what is truly at stake: not just
technical arguments about the law, but trust in God&#39;s ongoing, life-giving
presence.

Within Mark&#39;s story, this is part of a series of public tests where Jesus
is challenged again and again, each time revealing something deeper about
who he is and what God is like. Here, Jesus claims the authority to interpret
Scripture and to reveal God&#39;s heart. He sets the stage for the next question—
about the greatest commandment—and moves the narrative closer to the final
showdowns that will lead to his arrest.

---

### 3. Expect Your Group to Connect With

- **Feeling the pressure to defend your reputation or beliefs when
  challenged in public**—like the Sadducees, who ask their question not out
  of curiosity, but to protect their standing.
- **Experiencing conversations where people care more about proving a point
  than truly listening or seeking understanding.**
- **Witnessing someone cut through a heated debate to name what really
  matters, shifting the focus from technicalities to deeper truths.**
- **Wondering what is at stake when we talk about hope, life, and what God
  is really like—especially when others are skeptical or dismissive.**

---

### 4. As You Prepare

Read this passage through a few times, slowly, and look at each section
alongside its questions. Notice how the questions are structured: some are
Open—like &quot;What do the Sadducees do at the beginning of this scene?&quot;—
inviting your group to explore what the text shows; others are Guiding—
such as &quot;What passage from Moses does Jesus mention in his answer?&quot;—
helping your group focus on key details or turning points. The &quot;Imagine&quot;
prompts invite participants to step into the shoes of both the Sadducees
and Jesus, to feel the tension and the weight of public challenge.

You&#39;ll notice that cultural background appears where it&#39;s needed: brief
notes about who the Sadducees are, why Moses&#39; law matters, and what the
burning bush means. You don&#39;t need to front-load these details—trust that
your group can pick them up as they go, and that the questions themselves
will spark curiosity and insight. Let the conversation breathe. If a question
doesn&#39;t fit your group, feel free to skip it or rephrase it. Your role is
to create space for discovery and honest engagement; you don&#39;t need to have
all the answers. Trust the process, and trust your group—they may notice
details or connections you haven&#39;t seen. Be present, and let the story do
its work.</code></pre>
<figcaption>Leader's introduction excerpt for Mark 12:18–27</figcaption>
</figure>

The introduction serves multiple purposes: *What This Passage Does* orients the leader to the passage\'s role in the larger narrative arc; *Expect Your Group to Connect With* anticipates resonances between the biblical scene and participants\' lived experience; *As You Prepare* coaches the facilitator on how to use the questions, where cultural background appears, and how to hold space for discovery. The overall purpose is to help the leader prepare to lead a group session---to become familiar with the material before the discussion begins, anticipate what the conversation might involve, and gain confidence in facilitating without needing to be a biblical scholar. Observe that this is not traditional study-Bible commentary---it addresses the leader directly, assumes they are not experts, and focuses on group dynamics rather than technical exegesis. The tone is conversational, practical, and encouraging. This material is generated by the `leadersguide-intro-ast.gpt` prompt, which receives the exegetical analysis and scene structures as input and produces orientation prose designed for facilitators who may have little formal training. Architecturally, the introduction is generated *after* all the Bodies, Hearts, and Connecting questions have been finalized---it is one of the last pipeline stages---even though it appears first in the final guide. This separation of generation order from presentation order allows the introduction prompt to reference the actual questions that were generated, describing their structure and coaching the leader on how to use them.

### Prompt Structure: Input, Output, Rules {#ears-prompt-structure}

Ears to Hear prompts are declarative contracts specifying input data, output format, and generation rules. Each `.gpt` file has a YAML frontmatter declaring required inputs, output format, and a description; the prompt body then specifies task, input schema, output schema, and guardrails. The following excerpts from `leadersguide-bodies-ast.gpt` show the contract structure:

<figure id="fig-ears-prompt-contract">
<pre><code>---
prompt:
  requires:
    - passage
    - leadersguide_snippets
  format: json
  description: &gt;-
    Rewrite Bodies snippet skeletons into globally accessible oral questions.
---

# Task
You receive `leadersguide_snippets.skeletons`, a precomputed array of
question skeletons built entirely from exegetical analysis. Your job
is NOT to generate new ideas. Simply rewrite each Bodies skeleton into
an inductive oral question while keeping every other field unchanged.

## Data You Receive
Each skeleton object includes:
- `id`, `section`, `list`, `scene_index`, `scene_title`, `citation`
- `perspective`, `question_role`, `anchor`, `anchor_type`, `source_excerpt`
- `source_paths`, `assumptions`, `background`, `background_sources`

Only process entries whose `section == &quot;bodies&quot;`. Preserve the original
ordering so Notice/Imagine pairings remain aligned.</code></pre>
<figcaption>Prompt contract (YAML frontmatter and input specification)</figcaption>
</figure>

The prompt contract makes explicit: (1) what input variables the LLM will receive (`passage`, `leadersguide_snippets`); (2) what output format is required (JSON); (3) the task is rewrite-only, not generate-new-content. Every field in the skeleton object is listed, so the LLM knows what data it has access to.

The rules section of the prompt specifies output constraints:

<figure id="fig-ears-prompt-rules">
<pre><code>## Rewrite Rules
1. **Rewrite-only.** Turn the `anchor` text into a ≤15-word oral question.
   Stay in the third person, keep vocabulary globally accessible, and never
   add information that is not already present in either the `anchor` or
   the supplied `background` text.
2. **Notice vs. Imagine.**
   - `list == &quot;Notice&quot;`: No modal verbs (`might`, `would`, `could`). Ask
     for the concrete action, posture, or sensory fact already stated.
   - `list == &quot;Imagine&quot;`: You may use one modal verb to explore sensory
     implications, but you still may not introduce new facts.
3. **Question role.** Match the tone to `question_role`.
   - `open`: broad inductive invitation (&quot;Tell me...&quot;, &quot;What does...&quot;).
   - `guiding`: focused wh-question on a single observable detail.
4. **Active participants only.** Only generate a perspective block
   (Notice or Imagine) for a perspective whose character is *active*
   in the citation range — taking an action, speaking, or making a
   visible choice. A character who only *receives* action without
   speaking or responding does not warrant a perspective block.
5. **Perpetrator suppression (Imagine).** If a perspective&#39;s
   `source_excerpt` or `assumptions` show that this character beats,
   kills, throws, or physically assaults another character in this scene,
   do NOT output any `list == &quot;Imagine&quot;` skeletons for that perspective.
   Immersive &quot;You are X, what is it like to...&quot; questions must not be
   generated for perpetrators of violence.</code></pre>
<figcaption>Prompt rules excerpt (guardrails and field-specific constraints)</figcaption>
</figure>

These rules encode interpretive commitments (no new facts, globally accessible vocabulary, no immersive questions for perpetrators of violence) as testable constraints on LLM output. The prompt contract makes implicit editorial standards explicit and auditable.

### Language Mediation: From Model to Embodied Context {#ears-language-mediation}

One of the intermediate steps in the Ears to Hear pipeline is the *language* analysis, which mediates between lexical data and embodied, scene-aware context. The pipeline loads enriched word-sense data for every lemma in a passage, then asks the LLM to synthesize this into scene-specific embodied and emotional notes. The output is a JSON file (`*_language.json`) that describes, for each key term, what a participant in that scene would physically experience or feel.

The following excerpt from the language analysis for Mark 10:46 shows how the pipeline converts lexical and morphological data into embodied context for the term *τυφλός* (blind):

<figure id="fig-ears-language">
<pre><code>{
  &quot;lemma&quot;: &quot;τυφλός&quot;,
  &quot;gloss&quot;: &quot;blind&quot;,
  &quot;source&quot;: &quot;enriched&quot;,
  &quot;semantic_notes&quot;: &quot;Core: unable to see (MAT 11:5). In narratives,
    marks physical limitation and social vulnerability.&quot;,
  &quot;embodied_notes&quot;: &quot;No visual input; orientation by sound and touch.
    Head tilts toward voices; hands trace ground or cloak edge to
    locate objects. Eyes may be dry/irritated from dust; habitual
    squinting without visual focus.&quot;,
  &quot;emotional_relational_notes&quot;: &quot;Dependence on passersby for guidance
    and charity; others decide when to help or ignore. Limited mobility
    increases exposure to crowd mood and control.&quot;
}</code></pre>
<figcaption>Language mediation excerpt for Mark 10:46 (from 41010046-41010052_language.json)</figcaption>
</figure>

This intermediate representation then flows into the `analyze_bodies` and `analyze_hearts` steps, grounding the exegetical analysis in the physical and emotional register of the text. The language mediation layer is where abstract lexical data becomes scene-specific embodied context --- translating the model\'s semantic knowledge into the sensory and relational world of the passage.

This layer is necessary because lexicons typically describe what a word *means*, not what someone experiences when the word names their condition or action. The language mediation step fills that gap, preparing context for downstream question generation that is meant to help participants enter the scene with their own bodies and hearts.

### Skills Files and Human-AI Collaboration Challenges {#ears-skills-collaboration}

Ears to Hear encodes its interpretive framework and workflow standards in a `.github/copilot-instructions.md` file at the repository root, and in domain-specific `SKILL.md` files in the `docs/skills/` directory. These files are not documentation for humans --- they are persistent instructions for the AI collaborator, encoding domain knowledge, coding patterns, and workflow guardrails that the AI must follow.

The `audit-prompts/SKILL.md` file is a case in point. It defines a read-only workflow for auditing `.gpt` prompt files for sprawl, convention compliance, and --- most critically --- for detecting when LLM output has been used as training data (examples) in prompts. The skill\'s preamble states the core principle:

<figure id="fig-ears-skill-principle">
<pre><code>## Core Principle: No LLM-Generated Training Data

**ABSOLUTE RULE:** Nothing produced by an LLM can ever be used as
training data (examples) in prompts. Period.

**Why this matters:**
- LLM output doesn&#39;t match user intent with sufficient precision
- AI-generated examples encode subtle patterns the AI already knows,
  not what you&#39;re trying to teach
- Examples must demonstrate the exact pattern you want, which requires
  human judgment
- Using LLM output as training creates circular reasoning and drift
  from intent

**What this means for audits:**
- Any new examples since last commit are SUSPECT until proven
  human-written
- At best, AI can propose examples for user approval (never auto-merged)
- Often, user must write examples themselves to ensure quality
- TODOs that get replaced with examples warrant extra scrutiny</code></pre>
<figcaption>Core principle from audit-prompts/SKILL.md</figcaption>
</figure>

This principle emerged from repeated failure modes in human-AI collaboration on prompt engineering:

1.  **AI treating LLM output as training data.** The AI would generate sample output, then propose adding that output as an example in the prompt --- treating its own generation as ground truth. This creates circular reasoning: the AI learns from examples it generated, not from examples that demonstrate the user\'s intent.

2.  **Conflating training data with test cases.** Test cases verify that a prompt produces correct output; training examples teach the LLM what correct output looks like. The AI repeatedly confused these, proposing to add test output as examples, which defeats the purpose of testing.

3.  **Solving the wrong problem.** The AI would assume it understood the user\'s problem from a brief description, then implement a solution before confirming alignment. Often the AI\'s inferred problem was not the user\'s actual problem, resulting in wasted work and misalignment.

4.  **The audit-prompt skill as a solution.** The skill encodes a read-only audit workflow that forces the AI to report what it finds without making changes. This prevents premature implementation and gives the user visibility before committing to a direction. The skill explicitly forbids `replace_string_in_file` and `create_file` tools, ensuring the AI cannot act on its inferences without user approval.

But even with skills files, the fundamental constraint remains: *the AI and the human must build a shared understanding before the work produces trustworthy results.* The user still has to read the prompts in detail, read the data, and verify that the AI\'s understanding matches intent. Skills files reduce friction and encode common patterns, but they do not replace the need for the human scholar to remain the final arbiter of whether the output is correct. This is not a limitation of the current generation of AI --- it is a structural feature of using AI for scholarly work: the AI does not have access to the user\'s intent except through the instructions and data it is given, and those instructions must be precise enough to constrain the AI\'s vast pattern-matching capacity to the narrow problem the user actually wants solved.

Scripture Pipelines does not solve this problem. It makes it manageable. By externalizing prompts, requiring explicit input/output contracts, and persisting all intermediate results, it provides the visibility and auditability needed to catch misalignment before it propagates. But the human scholar must still do the reading, the checking, and the final judgment. The pipeline serves scholarship; it does not replace it.

# Related Work

## XProc {#rw-xproc}

XProc is the closest structural parallel to Scripture Pipelines: both are declarative pipeline languages that define a graph of steps with named ports, typed inputs and outputs, and compound step composition. XProc 3.0\'s extension to non-XML document types, its `p:for-each` step over sequences, and its atomic/compound step model are all recognizable cousins of Scripture Pipelines constructs.

The fundamental difference is the document model. XProc pipelines process documents flowing through ports; the unit of computation is a document transformation. Scripture Pipelines pipelines generate knowledge by passing structured context to language models; the unit of computation is a prompt with a contract and a JSON response. XProc has no concept of a prompt, a token budget, a model temperature, or a retry condition on model output quality. Scripture Pipelines has no concept of a serialization pipeline or namespace-aware document trees.

In practice the two are complementary. Scripture Pipelines handles the LLM-generation phase; XProc handles downstream document transformation. The Discourse Flow pipeline, for example, produces USX as one of its output formats --- that USX is a natural input to an XProc pipeline for subsequent publishing transforms. Similarly, TEI documents produced by scholarly editors are natural inputs to Scripture Pipelines function steps that prepare context for LLM analysis. TEI\'s milestone elements, standoff annotations, and `<interp>` infrastructure already provide the kind of structured scholarly overlay that Scripture Pipelines pipelines can read, generate, and augment.

## LangChain, LlamaIndex, and Haystack {#rw-langchain}

LangChain and LlamaIndex are the dominant Python frameworks for LLM application development. Both are imperative: pipelines are Python code that chains objects together. This gives maximum flexibility but removes the properties that matter most for scholarly workflows --- readability by non-programmers, declarative auditability, and separation of pipeline logic from prompt content. A LangChain chain is not something a lexicographer can read and modify. A Scripture Pipelines pipeline is.

Neither framework treats intermediate outputs as first-class persistent artifacts. LangChain\'s memory and caching mechanisms are designed for chat history, not for the multi-day, multi-pass generation workflows of lexicography or discourse analysis where being able to rerun from step three without repeating steps one and two is essential economics, not a convenience. Neither framework has a concept analogous to prompt contracts: there is no mechanism that prevents a prompt from being called with missing inputs, and no validation before a run begins that the data flow is coherent.

Haystack is closer in spirit --- it supports YAML pipeline declarations and has a stronger emphasis on structured pipelines --- but its design center is retrieval-augmented generation and document QA, not the mixed deterministic-plus-generative scholarly workflows that Scripture Pipelines targets.

## DSPy {#rw-dspy}

DSPy takes a fundamentally different approach: rather than having authors write prompts, it compiles prompt programs from signatures and optimizes them automatically against a metric. This is powerful for tasks with well-defined correctness criteria, but it is antithetical to the requirements of scholarly pipeline work. A lexicographer needs to read, understand, and argue about every instruction given to the model. An automatically compiled prompt is a black box. The Abbott-Smith audit pattern described in the SemLex section --- where the prompt explicitly instructs the model to enumerate its sources and record its reasoning --- is not expressible in a compiled prompt framework. The audit trail requires human authorship of the prompt.

## GATE and UIMA {#rw-gate-uima}

GATE (General Architecture for Text Engineering) and UIMA (Unstructured Information Management Architecture) are annotation pipeline frameworks with long histories in computational linguistics and NLP. Both support TEI-aware processing configurations and provide rich annotation schemas over document structure. Both treat the pipeline as a graph of processing resources that annotate a document in sequence --- a model structurally similar to Scripture Pipelines\' step sequence.

The divergence is again in the generation model. GATE and UIMA pipelines analyze and annotate existing text; they do not generate new text or make calls to probabilistic language models as first-class operations. Incorporating an LLM into a GATE pipeline is possible but requires custom Java components and treats the LLM as an external service rather than a native pipeline citizen. Scripture Pipelines inverts this: the LLM call is the primary step type, and deterministic processing is the extension point.

## Workflow Orchestration Frameworks {#rw-prefect-airflow}

General-purpose workflow orchestration tools --- Prefect, Airflow, Luigi --- address the scheduling, dependency tracking, and failure recovery of data pipelines at scale. Their DAG model and task dependency declarations are structurally related to Scripture Pipelines\' step sequence. However, these frameworks target data engineering workflows executed by developers; they have no concept of a prompt contract, no support for LLM-specific concerns (model selection, token budgets, output type parsing), and no provision for the scholar-facing readability and human editorial loop that Scripture Pipelines is designed around. They are also substantially more complex to install and operate than a single self-contained binary.

# Conclusion

The world of biblical and linguistic scholarship has accumulated extraordinary open datasets --- morphological treebanks, discourse annotations, documentary papyri, lexicographic databases, ontologies, semantic domains --- that represent decades of scholarly labor and are largely inaccessible to practitioners who need them most. The barrier is not availability; most of it is freely licensed. The barrier is the human capacity to synthesize it at scale and turn it into materials that translators, pastors, and students can actually use.

Scripture Pipelines addresses this gap by making AI work like a careful research assistant rather than an unchecked generator. A lean team --- a pipeline designer, a handful of scholars, and focus groups of real users --- can now produce freely licensed reference materials grounded in the full breadth of available scholarly data: lexicons that account for every papyrus citation, discourse analyses that apply the complete Levinsohn dataset to every pericope, study guides derived from rigorous grammatical analysis rather than paraphrase. None of these were feasible for an underresourced project before.

The infrastructure that makes this possible --- declarative YAML pipelines, structured JSON intermediates with embedded accountability fields, persisted outputs at every step, prompt contracts, and rewind/stop-after debugging --- is not primarily a technical achievement. It is a discipline: a set of working practices that keep the human scholar in the loop, make the provenance of every generated artifact traceable, and ensure that AI synthesis is grounded in the structured scholarly data it was given rather than in whatever a language model would produce without constraints. The format choices --- YAML, JSON, Markdown, XML, each for its own purpose --- reflect the same pragmatism: what works best here, not what wins the syntax debate.

None of this diminishes the role of human expertise --- it transforms how that expertise is applied. A scholar who knows that the Louw-Nida / SemDom question chain can navigate 1,792 semantic domains to a single word\'s classification in approximately four questions does not need less expertise to work with Scripture Pipelines than without it; they need more. The pipeline amplifies the reach of that insight across an entire corpus. A discourse analyst who recognizes the significance of Levinsohn\'s word-level annotations for pericope segmentation unlocks a dataset of 806 structural signals in 1 John alone that would otherwise remain invisible to any pipeline that didn\'t know to look. The dreaming, the problem framing, the choice of which scholarly tradition to ground a pipeline in, the judgment to know when the model\'s output is wrong, the taste to know what good enough means for a translator in the field --- none of that is supplied by the tool. What changes is the leverage: a single scholar with deep domain knowledge and a well-designed pipeline can now produce work that would previously have required a large team and many years. Experience still counts. It just goes further.

This is what The Kairos Project is for. When we say \"a scholar with deep domain knowledge,\" we mean scholars worldwide --- including those learning Greek and Hebrew outside traditional seminaries, multilingual learners who bring linguistic gifts that Western institutions have not recognized, translation teams who know their target audience in ways the academy never will. The goal is not to make Western scholars more productive; the goal is to democratize the tools so that scholarship can happen where it is needed, by people who have been told they are not qualified, producing resources together with the communities who will actually use them. Scripture Pipelines is infrastructure for that vision. It makes the open datasets --- the treebanks, the lexicons, the discourse annotations --- accessible to people who do not have a PhD from a Western university and do not need one to do rigorous work with the text. The Kairos Project exists to raise up scholars globally, not to preserve the Western academy\'s role as gatekeeper. The bidirectional flow between academy and church, between institution and field, is not a concession --- it is the point.

The projects reported here are early instances of a larger program. The dataset registry and system integrations provide the infrastructure for an expanding range of pipeline-producible scholarly materials. The goal is a world where the open data that scholars have painstakingly assembled becomes the shared foundation for work that communities worldwide do together --- not resources provided for them, but scholarship they participate in creating.

# A Note on AI in the Writing of This Paper {#ai-disclosure}

This paper was written with AI assistance, in a manner consistent with the principles it describes. The author used GitHub Copilot as a collaborator throughout: drafting passages, testing arguments, refining phrasing, and at several points returning to the saved chat histories from specific projects --- the SemLex lexicon, the Hebrew Phrasing analysis, the Discourse Flow pipeline, Ears to Hear, and the Scripture Pipelines engine itself --- the full record of prompts, responses, and revisions across each collaboration. The author shared those histories with the AI and reflected, project by project, on how the work had actually proceeded: what the human had directed, what the AI had contributed, where miscommunications had occurred and been corrected. Those reflection sessions became the primary source for the human-command section --- the author described how the collaborations had gone, and the AI helped put those descriptions into prose that generalized across them.

The James Kirk model applied. The author read everything, accepted or rejected or revised every sentence, and directed every significant turn in the argument. The AI did not decide what the paper should argue; it helped the author say what he had decided to argue. The paper\'s central claim --- that human judgment, scholarly accountability, and community ownership are not transferable to a language model --- was not undermined by the process of writing it this way. If anything, the process was an extended test of that claim, and the claim held.

# References

Abbott-Smith, G. *A Manual Greek Lexicon of the New Testament*. T&T Clark, Edinburgh, 1937.

Louw, J. P. and E. A. Nida. *Greek-English Lexicon of the New Testament Based on Semantic Domains*, 2 vols. United Bible Societies, New York, 1988.

Levinsohn, S. H. *Discourse Features of New Testament Greek: A Coursebook on the Information Structure of New Testament Greek*, 2nd ed. SIL International, Dallas, 2000.

Levinsohn, S. H. *Levinsohn Greek New Testament Discourse Features (LGNTDF)*. Data set. Biblical Humanities. <https://github.com/biblicalhumanities/levinsohn>.

Clear Bible. *Macula Greek Linguistic Datasets*. Data set. CC BY 4.0. <https://github.com/Clear-Bible/macula-greek>.

Clear Bible. *Macula Hebrew Linguistic Datasets*. Data set. CC BY 4.0. <https://github.com/Clear-Bible/macula-hebrew>.

Levinsohn, S. H. and D. Samuel. *Hebrew Old Testament Discourse Features (HOTDF)*. Data set. Nida Institute. <https://github.com/nida-institute/levinsohn-samuel-hebrew>.

United Bible Societies. *Semantic Dictionary of Biblical Hebrew (SDBH)*. Data set. Open license. <https://github.com/ubsicap/ubs-open-license>. <https://semanticdictionary.org/>.

OpenScriptures. *Hebrew Bible (morphhb): Parsed Hebrew Bible with Strong\'s numbers and morphology*. Data set. MIT License. <https://github.com/openscriptures/morphhb>.

Elwell, W. A. and P. W. Comfort (eds.). *Tyndale Bible Dictionary*. Tyndale House Publishers, Carol Stream, IL, 2001.

Raasveldt, M. and H. Mühleisen. "DuckDB: an Embeddable Analytical Database." *Proceedings of the 2019 International Conference on Management of Data (SIGMOD)*, pp. 1981--1984, 2019.

Holmes, M. W. (ed.). *The Greek New Testament: SBL Edition*. Society of Biblical Literature and Logos Bible Software, Atlanta and Bellingham, 2010. Custom license. <http://sblgnt.com/>. <https://github.com/morphgnt/sblgnt>.

Bunning, A. *Center for New Testament Restoration: Transcriptions of Greek New Testament Manuscripts*. <https://greekcntr.org/>.

Brannan, R. *ACAI*. Mission Mutual, 2025. CC BY-SA 4.0. Dataset. <https://github.com/BibleAquifer/ACAI>.

USFM/X Technical Committee. *USFM/USX Technical Documentation*. <https://github.com/usfm-bible/tcdocs>.

Scripture Burrito Taskforce. *Scripture Burrito: A Specification for Bible-Containing Containers*. <https://docs.burrito.bible/>.

Grün, C. et al. *BaseX: The XML Database*. <https://basex.org/>.

Walsh, N. et al. *XProc 3.0: An XML Pipeline Language*. W3C Working Group Note, 2022. <https://spec.xproc.org/3.0/xproc/>.

Nida Institute. *Awesome Biblical Data: A Curated Catalog of Datasets and Tools for Biblical and Linguistic Scholarship*. 2026--. CC BY-SA 4.0. <https://github.com/nida-institute/awesome-biblical-data>.

Chase, H. et al. *LangChain*. 2022--. <https://www.langchain.com/>.

Liu, J. et al. *LlamaIndex*. 2022--. <https://www.llamaindex.ai/>.

deepset. *Haystack: Open-Source LLM Framework*. 2020--. <https://haystack.deepset.ai/>.

Khattab, O. et al. "DSPy: Compiling Declarative Language Model Calls into Self-Improving Pipelines." arXiv:2310.03714, 2023.

Cunningham, H. et al. *Developing Language Processing Components with GATE (a User Guide)*. University of Sheffield, 2011. <https://gate.ac.uk/>.

Ferrucci, D. and A. Lally. "UIMA: An Architectural Approach to Unstructured Information Processing in the Corporate Research Environment." *Natural Language Engineering* 10(3--4):327--348, 2004.

*papyri.info: Integrating Digital Papyrology*. Duke Databank of Documentary Papyri and Heidelberger Gesamtverzeichnis der griechischen Papyrusurkunden Ägyptens. <https://papyri.info/>.

Crane, G. (ed.). *Perseus Digital Library*. Tufts University. <https://www.perseus.tufts.edu/>.

Open Greek and Latin Project. *First1KGreek: First Thousand Years of Greek*. <https://opengreekandlatin.github.io/First1KGreek/>.

EpiDoc Collaborative. *EpiDoc: Epigraphic Documents in TEI XML*. <https://epidoc.stoa.org/>.

Robie, J. *Ears to Hear*. Nida Institute, 2025. <https://github.com/nida-institute/ears-to-hear>.

Chafe, Wallace. *Discourse, Consciousness, and Time: The Flow and Displacement of Conscious Experience in Speaking and Writing*. University of Chicago Press, Chicago, 1994.

Robie, J. "Artificial Intelligence and Bible Translation." *Bible History Daily*. Biblical Archaeology Society, January 3, 2024. <https://www.biblicalarchaeology.org/daily/artificial-intelligence-and-bible-translation/>.

Vaswani, A., Shazeer, N., Parmar, N., Uszkoreit, J., Jones, L., Gomez, A. N., Kaiser, L., and Polosukhin, I. "Attention is All You Need." *Advances in Neural Information Processing Systems 30* (NeurIPS 2017).

Alammar, Jay. "The Illustrated Transformer." 2018. <https://jalammar.github.io/illustrated-transformer/>.

Brown, T. B., Mann, B., Ryder, N., Subbiah, M., Kaplan, J., Dhariwal, P., Neelakantan, A., Shyam, P., Sastry, G., Askell, A., et al. "Language Models are Few-Shot Learners." *Advances in Neural Information Processing Systems 33* (NeurIPS 2020).

Wei, J., Wang, X., Schuurmans, D., Bosma, M., Ichter, B., Xia, F., Chi, E., Le, Q., and Zhou, D. "Chain-of-Thought Prompting Elicits Reasoning in Large Language Models." *Advances in Neural Information Processing Systems 35* (NeurIPS 2022).

Russell, Stuart. *Human Compatible: Artificial Intelligence and the Problem of Control*. Viking, New York, 2019.

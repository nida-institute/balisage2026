#!/usr/bin/env python3
"""Extract DocBook frontmatter and prepend to markdown."""

import sys
import xml.etree.ElementTree as ET

def extract_frontmatter(xml_file):
    """Extract title, subtitle, author, abstract from DocBook XML."""
    ns = {'db': 'http://docbook.org/ns/docbook'}
    tree = ET.parse(xml_file)
    root = tree.getroot()

    lines = []

    # Title
    title = root.find('.//db:title', ns)
    if title is not None and title.text:
        lines.append(f"# {title.text}\n")

    # Subtitle
    subtitle = root.find('.//db:subtitle', ns)
    if subtitle is not None and subtitle.text:
        lines.append(f"## _{subtitle.text}_\n")

    # Author
    author_first = root.find('.//db:author/db:personname/db:firstname', ns)
    author_last = root.find('.//db:author/db:personname/db:surname', ns)
    if author_first is not None and author_last is not None:
        lines.append(f"\n**{author_first.text} {author_last.text}**\n")

    # Email
    email = root.find('.//db:author/db:email', ns)
    if email is not None and email.text:
        lines.append(f"{email.text}\n")

    # Affiliation
    affiliations = root.findall('.//db:author/db:affiliation/db:orgname', ns)
    if affiliations:
        orgs = [org.text for org in affiliations if org.text]
        if orgs:
            lines.append(f"_{', '.join(orgs)}_\n")

    # Bio (personblurb)
    bio_paras = root.findall('.//db:author/db:personblurb/db:para', ns)
    if bio_paras:
        lines.append("\n")
        for para in bio_paras:
            if para.text:
                text = ''.join(para.itertext())
                lines.append(f"_{text}_\n")

    # Abstract
    abstract_paras = root.findall('.//db:abstract/db:para', ns)
    if abstract_paras:
        lines.append("\n## Abstract\n\n")
        for para in abstract_paras:
            if para.text:
                # Simple text extraction (doesn't handle nested elements perfectly)
                text = ''.join(para.itertext())
                lines.append(f"{text}\n\n")

    # Keywords
    keywords = root.findall('.//db:keywordset/db:keyword', ns)
    if keywords:
        kw_list = [kw.text for kw in keywords if kw.text]
        if kw_list:
            lines.append(f"\n**Keywords:** {', '.join(kw_list)}\n")

    lines.append("\n---\n\n")

    return ''.join(lines)

if __name__ == '__main__':
    if len(sys.argv) != 3:
        print("Usage: extract_frontmatter.py input.xml output.md", file=sys.stderr)
        sys.exit(1)

    xml_file = sys.argv[1]
    md_file = sys.argv[2]

    frontmatter = extract_frontmatter(xml_file)

    # Read existing markdown (from pandoc)
    with open(md_file, 'r') as f:
        body = f.read()

    # Write frontmatter + body
    with open(md_file, 'w') as f:
        f.write(frontmatter)
        f.write(body)

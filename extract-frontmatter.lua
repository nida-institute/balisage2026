-- Extract DocBook <info> frontmatter and render as markdown header
-- This captures title, subtitle, author, abstract, keywords

function Meta(meta)
  local blocks = {}

  -- Title
  if meta.title then
    local title = pandoc.utils.stringify(meta.title)
    table.insert(blocks, pandoc.Header(1, title))
  end

  -- Subtitle
  if meta.subtitle then
    local subtitle = pandoc.utils.stringify(meta.subtitle)
    table.insert(blocks, pandoc.Header(2, pandoc.Emph(subtitle)))
  end

  -- Author
  if meta.author then
    local author_blocks = {}
    for _, author in ipairs(meta.author) do
      local name = pandoc.utils.stringify(author)
      table.insert(author_blocks, pandoc.Plain({pandoc.Strong({pandoc.Str(name)})}))
    end
    if #author_blocks > 0 then
      table.insert(blocks, pandoc.Para(author_blocks[1].content))
    end
  end

  -- Email (if available)
  if meta.email then
    local email = pandoc.utils.stringify(meta.email)
    table.insert(blocks, pandoc.Para({pandoc.Str("Email: "), pandoc.Code(email)}))
  end

  -- Abstract
  if meta.abstract then
    table.insert(blocks, pandoc.Header(2, "Abstract"))
    if type(meta.abstract) == "table" and meta.abstract.t == "MetaBlocks" then
      for _, block in ipairs(meta.abstract) do
        table.insert(blocks, block)
      end
    end
  end

  -- Keywords
  if meta.keywords then
    table.insert(blocks, pandoc.Header(2, "Keywords"))
    local kw_list = {}
    if type(meta.keywords) == "table" then
      for _, kw in ipairs(meta.keywords) do
        local kw_str = pandoc.utils.stringify(kw)
        table.insert(kw_list, kw_str)
      end
      local kw_text = table.concat(kw_list, ", ")
      table.insert(blocks, pandoc.Para({pandoc.Str(kw_text)}))
    end
  end

  table.insert(blocks, pandoc.HorizontalRule())

  return blocks
end

-- Process document to inject frontmatter at the start
function Pandoc(doc)
  local frontmatter = Meta(doc.meta)
  if frontmatter and #frontmatter > 0 then
    -- Prepend frontmatter blocks to document body
    for i = #frontmatter, 1, -1 do
      table.insert(doc.blocks, 1, frontmatter[i])
    end
  end
  return doc
end

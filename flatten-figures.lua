-- Flatten DocBook <figure> elements into caption + code block
function Figure(el)
  local result = {}
  -- Add caption as a paragraph of italic text
  if el.caption and el.caption.long and #el.caption.long > 0 then
    for _, b in ipairs(el.caption.long) do
      -- wrap paragraph inlines in Emph to distinguish caption
      if b.t == "Para" then
        table.insert(result, pandoc.Para({pandoc.Emph(b.content)}))
      else
        table.insert(result, b)
      end
    end
  end
  -- Add the body blocks (code blocks, etc.)
  for _, b in ipairs(el.content) do
    table.insert(result, b)
  end
  return result
end

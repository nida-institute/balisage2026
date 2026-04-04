-- Fix personblurb rendering in PDF by converting it to regular paragraphs
-- This preserves the correct DocBook structure while ensuring proper wrapping

function Div(el)
  -- Check if this is a personblurb div
  if el.classes:includes('personblurb') then
    -- Extract the paragraph blocks and return them directly
    -- This unwraps the personblurb container that was preventing wrapping
    return el.content
  end
  return el
end

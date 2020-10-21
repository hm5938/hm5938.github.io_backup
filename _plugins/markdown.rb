# Jekyll - Easy Youtube Embed
#
# https://jekyllrb-ko.github.io/docs/upgrading/3-to-4/
#
#   Input:
#     {% youtube Al9FOtZcadQ %}
#   Output:
#   <div class="video">
#     <figure>
#       <iframe width="640" height="480" src="//www.youtube.com/embed/Al9FOtZcadQ" allowfullscreen></iframe>
#     </figure>
#   </div>

module Jekyll
  External.require_with_graceful_fail "kramdown-converter-pdf"

  class Markdown2PDF < Converter
    safe true
    priority :low

    def matches(ext)
      # match only files that have an extension exactly ".markdown"
      ext =~ /^\.markdown$/
    end

    def convert(content)
      Kramdown::Document.new(content).to_pdf
    end

    def output_ext
      ".pdf"
    end
  end
end
Liquid::Template.register_tag('markdown2pdf', Jekyll::Converter)

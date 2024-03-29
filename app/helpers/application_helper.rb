module ApplicationHelper
  def link_to_add_ingredients(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, child_index: "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end
  
  def nl_to_br(text)
    text.gsub(/\n/, '<br />')
  end
  
  def br_to_nl(text)
    text.gsub(/<br ?\/?>/, "\n")
  end
end

class Class
  def extend?(_class)
    not superclass.nil? and ( superclass == _class or superclass.extend? _class )
  end
end
# encoding: UTF-8

module PrependAndAppend
  def append *methods, &block
    self.caller :append, *methods, &block
    nil
  end

  def prepend *methods, &block
    self.caller :prepend, *methods, &block
    nil
  end

  def caller method, *methods, &block
    methods.each do |m|
      m = m.to_sym

      if defined? m
        singleton_class.send :alias_method, "old_#{m.to_s}".to_sym, m

        self.define_singleton_method m do
          block.call if block_given? && method == :prepend
          self.send "old_#{m.to_s}".to_sym
          block.call if block_given? && method == :append
        end
      end
    end
  end
end

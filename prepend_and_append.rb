# encoding: UTF-8

module PrependAndAppend
  def self.append *methods, &block
    self.caller :append, *methods, &block
  end

  def self.prepend *methods, &block
    self.caller :prepend, *methods, &block
  end

  private
  def self.caller method, *methods, &block
    methods.each do |m|
      m = m.to_sym

      if self.method_defined? m
        self.send :alias_method, "old_#{m.to_s}".to_sym, m

        define_method m do
          block.call if block_given? && method == :prepend
          self.send "old_#{m.to_s}".to_sym
          block.call if block_given? && method == :append
        end
      end
    end
  end
end

module MicropostsHelper
  def wrap(content)
    sanitize(raw(content.split.map { |s| wrap_long_string(s, 30) }.join(' ')))
  end

  private
  def wrap_long_string(text, max_width)
    zero_width_space = '&#8203;'
    regx = /.{1,#{max_width}}/
    text.length <= max_width ? text : text.scan(regx).join(zero_width_space)
  end
end

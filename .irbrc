require 'irb/completion'

IRB.conf[:AUTO_INDENT] = true

dark = "31;35;53"
blue = "122;162;247"
red = "247;118;142"
grey = "84;92;126"
white = "192;202;245"
outer_bg_color = blue

if defined?(Rails)
  outer_text = Rails.application.class.module_parent.name
  env_name = Rails.env
  case env_name
  when "development"
    middle_text = "dev"
  when "production"
    middle_text = "prod"
    outer_bg_color = red
  else
    middle_text = env_name
  end
else
  outer_text = "irb"

  if IRB.conf[:PROMPT].key? :RVM  # requires RVM
    version = IRB.conf[:PROMPT][:RVM][:PROMPT_I].split(" ")[0]
    middle_text = "v#{version}"
  end
end

outer_color = "\e[38;2;#{dark};48;2;#{outer_bg_color}m"
outer_divider = "\e[0m\033[38;2;#{outer_bg_color};48;2;#{grey}m\uE0B0"
outer_prompt = "#{outer_color} #{outer_text} #{outer_divider}"

middle_color = "\033[38;2;#{white};48;2;#{grey}m"
middle_divider = "\e[0m\033[38;2;#{grey}m\uE0B0\e[0m"
middle_prompt = "#{middle_color}#{middle_text} #{middle_divider}"

prompt_length = outer_text.length + middle_text.length + 1

IRB.conf[:PROMPT][:CUSTOM] = {
  PROMPT_I: "#{outer_prompt} #{middle_prompt} ",
  PROMPT_N: "#{' ' * prompt_length} >    ",
  PROMPT_S: "#{' ' * prompt_length} *    ",
  PROMPT_C: "#{' ' * prompt_length} ?    ",
  RETURN: " => %s\n"
}

IRB.conf[:PROMPT_MODE] = :CUSTOM

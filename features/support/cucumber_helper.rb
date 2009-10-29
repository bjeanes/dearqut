module CucumberHelper
  def Cucumber(steps)
    steps.strip.split(/(?=^\s*(?:When|Then|Given|And|But))/).map { |step| step.strip }.each do |step|
      output = step.match(/^\s*(When|Then|Given|And|But) ([^\n]+)(\n.*)?$/m)
      
      action, step, table_or_string = output[1], output[2], output[3]
      table_or_string = table(table_or_string) if table_or_string.to_s.strip[0..1] == "|"
      args = [step, table_or_string].compact
      
      send(action, *args)
    end
  end
end
World(CucumberHelper)
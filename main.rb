require_relative './menu'

def main
  app = App.new
  menu = Menu.new(app)
  menu.run
end

main

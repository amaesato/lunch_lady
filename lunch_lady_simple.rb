require 'pry'
# BASIC LUNCH ORDER
# Greeting
# Lunch Special: Main Dish + two sides + addons
# Choose from a list of main dishes
# Choose 2 side dishes
# Show order
# Displays lunch total


# Different menus
  MAIN = {
    1 => {name:'Greek Salad', description:
      'Roasted garbanzo beans Greek olives, Basil Chimichurri', price: '7.50', nutrition:{
      calories: '350g', fat: '30g', carbs: '50g'}},

    2 => {name:'Herbed Chicken Salad', description:
      'Herb roasted chicken over mixed greens and veggies', price: '8.50', nutrition:{
    calories: '300g', fat: '25g', carbs: '40g'}},

    3 => {name:'Sundried Tomato Turkey Wrap', description:
      'Turkey, mozzarella, sundried tomato Chimichurri wrap', price: '8.50', nutrition:{
    calories: '200g', fat: '5g', carbs: '25g'}}}


  SIDE = {
    1 => {name:'Watermelon Bowl', description:
      'Watermelon sprinkled with feta, basil, and balsamic', price: '3.75',
    nutrition: {calories: '0g', fat: '0g', carbs: '1g'}},

    2 => {name:'Sweet Potato Fries', description:
      'Thin sliced sweet potatoes, baked in coconut oil', price: '4.50',
    nutrition: {calories: '2g', fat: 'nada', carbs: '200g'}},

    3 => {name:'Chips', description: 'All natural organic potato chips',  price: '1.50',
    nutrition: {calories: '500g', fat: '200g', carbs: '150g'}}}

  ADD_ON = {
    1 => {name:'Cookie', description: 'Chocolate Chip Cookie', price: '1.25',
    nutrition: {calories: "You don't want to know",
    fat: "Don't look at fat", carbs: "This number doesn't mean anything"}},

    2 => {name:'Chocolate Covered Strawberry', description: 'No description needed',
    price: '1.25', nutrition: {calories: "Strawberries are healthy",
    fat: "No fat here", carbs: "nope"}},

    3 => {name:'Oatmeal Energy Bite', description: 'Oatmeal, peanut butter, coconut, honey bites',
    price: '1.00', nutrition: {calories: "These are healthy enough",
    fat: "what fat", carbs: "Carbs? never"}}}


class Order
  attr_accessor :my_order, :choice, :menu_pick, :wallet

# creates array for new order
  def initialize
    @my_order = Array.new
    @my_total = Array.new
    puts "\n\tWelcome to LUNCH LADY"
    print "\nYou have a Wallet ballance of $16.50, would you like to use it? "
    @wallet = gets.strip.downcase
    if @wallet == 'yes' || wallet == 'y'
      @wallet = 16.50
    end
  end

  # menu to choose meal
  def pick_meal(menu, wallet)
    puts "1.#{menu[1][:name]}  $#{menu[1][:price]}"
    puts "2.#{menu[2][:name]}  $#{menu[2][:price]}"
    puts "3.#{menu[3][:name]}  $#{menu[3][:price]}"
    puts "4.See Descriptions"
    puts "5.Clear order OR '0' to quit"
    print "> "
    @menu_pick = gets.to_i
    wallet
    case @menu_pick
      when 0
        puts "Goodbye"
        exit(0)
      when 4
        description(menu)
      when 5
        clear_order
      else
        order_meal(menu)
    end
  end



  def order_meal(menu)
    @choice = menu[@menu_pick][:name]
    price = menu[@menu_pick][:price]
    @my_order << @choice

    @my_total << price.to_f
    puts "\nYour current order:\n#{@my_order.join("\n")}"

    sum = 0
    @wallet = 16.50
    @my_total.each do |i|
      sum += i
    end

    puts "\tYour total is: $#{'%.2f' % sum}"
  end

  def checkout
    puts "\nThank you for your order!"
    puts "\n\tYou are now making a new order:"
    @my_order = Array.new
    pick_meal(MAIN)
  end



  def clear_order
    @my_order = Array.new
    puts "\n Your order has been cleared"
    puts "\n Start new order: Pick Main Dish"
    pick_meal(MAIN)
  end

# menu_input is the menu hash
  def description(menu)
    puts "\nPLEASE CHOOSE:"
    puts "1.#{menu[1][:name]} - #{menu[1][:description]}"
    puts "2.#{menu[2][:name]} - #{menu[2][:description]}"
    puts "3.#{menu[3][:name]} - #{menu[3][:description]}"
    puts "4.See Nutritional Facts" # Finish nutrition_facts method
    @menu_pick = gets.to_i

    if @menu_pick == 4
      nutrition_facts(menu)
    elsif @menu_pick == 5 # Add a 5. Clear order
      clear_order
    else
      order_meal(menu)
    end
  end

  def nutrition_facts(menu)
    puts "\n Nutritional Facts:"
    print "#{menu[1][:name]} - "
    menu[1][:nutrition].each {|key, value| print "#{key}: #{value}  " }
    print "\n#{menu[2][:name]} - "
    menu[2][:nutrition].each {|key, value| print "#{key}: #{value}  " }
    print "\n#{menu[3][:name]} - "
    menu[3][:nutrition].each {|key, value| print "#{key}: #{value}  " }
    puts "\n1.Back to menu"
    puts "2.Clear order OR '0' to quit"
    menu_back = gets.to_i

    case menu_back
      when 0
        puts "Goodbye"
        exit(0)
      when 1
        pick_meal(menu)
      when 2
        clear_order
    end

  end


  def addons(menu)
    puts "How many add-on's would you like?"
    number_to_add = gets.to_i

    number_to_add.times do
      puts "Choose more Add-on items:"
      puts "1.#{ADD_ON[1][:name]}  $#{ADD_ON[1][:price]}"
      puts "2.#{ADD_ON[2][:name]}  $#{ADD_ON[2][:price]}"
      puts "3.#{ADD_ON[3][:name]}  $#{ADD_ON[3][:price]}"
      puts "5. Checkout"
      print "> "
      @menu_pick = gets.to_i
      if @menu_pick == 5
        checkout
      else
        order_meal(menu)
      end
    end

    if number_to_add == 0
      order_meal(menu)
    elsif number_to_add > 10
      puts "You cannot order more than 10"
      add(menu)
    else
      checkout
    end

  end


end
# End of class


new_order = Order.new

while true
  puts "\n CHOOSE MAIN DISH:"
    new_order.pick_meal(MAIN, @wallet)

  2.times do
  puts "\n CHOOSE SIDE DISH:"
    new_order.pick_meal(SIDE, @wallet)
  end

  new_order.addons(ADD_ON)
  if @choice == '0' || @choice == 'quit'
    exit(0)
  end

end

require 'json'

class CardSearch

  def initialize
    @cardArray = JSON.parse(File.read("cards.collectible.json"))
    @nameToCardHash = Hash.new
    @cardArray.each {|card| @nameToCardHash[card["name"]] = card}
  end

  def handleInput
    puts "Hearthstone card search!\n\n"\
    "Narrow your search with the following options:\n"\
    "cost|c *\n"\
    "attack|a *\n"\
    "health|h *\n"\
    "set [basic, classic, nax, gvg, tgt, oldgods, kara]\n"\
    "rarity [common|c, rare|r, epic|e, legendary|l]\n"\
    "class [warrior, mage, druid, shaman, rogue, paladin, priest, hunter, warlock, neutral]\n"\
    "reset \n"\
    "quit \n\n"\

    newSearch(true)

    while (true)
      print ">"
      input = gets.chomp.split(" ")
      if input[0] == "reset" then newSearch(true); next
      elsif input[0] == "quit" then exit
      elsif input.length != 2 then puts "Invalid option."; next
      elsif input[0] == "set"
        case input[1]
          when "basic"
            imposeCondition("set", "CORE")
          when "classic"
            imposeCondition("set", "EXPERT1")
          when "gvg"
            imposeCondition("set", "GVG")
          when "oldgods"
            imposeCondition("set", "OG")
          when "tgt"
            imposeCondition("set", "TGT")
          when "nax"
            imposeCondition("set", "NAXX")
          when "kara"
            imposeCondition("set", "KARA")
          else
            puts "That's not a set :/"; next
        end
      elsif input[0] == "rarity"
        case input[1]
          when "common", "c"
            imposeCondition("rarity", "COMMON")
          when "rare", "r"
            imposeCondition("rarity", "RARE")
          when "epic", "e"
            imposeCondition("rarity", "EPIC")
          when "legendary", "l"
            imposeCondition("rarity", "LEGENDARY")
          else
            puts "That's not a rarity :/"; next
        end
      elsif input[0] == "class"
        case input[1]
          when "warrior"
            imposeCondition("playerClass", "WARRIOR")
          when "druid"
            imposeCondition("playerClass", "DRUID")
          when "mage"
            imposeCondition("playerClass", "MAGE")
          when "shaman"
            imposeCondition("playerClass", "SHAMAN")
          when "warlock"
            imposeCondition("playerClass", "WARLOCK")
          when "hunter"
            imposeCondition("playerClass", "HUNTER")
          when "rogue"
            imposeCondition("playerClass", "ROGUE")
          when "priest"
            imposeCondition("playerClass", "PRIEST")
          when "paladin"
            imposeCondition("playerClass", "PALADIN")
          when "neutral"
            imposeCondition("playerClass", "NEUTRAL")
          else
            puts "That's not a class :/"; next
        end
      elsif input[1].to_i.to_s != input[1] then puts "Needs to be an integer."; next
      elsif input[0] == "cost" || input[0] == "c" then imposeCondition("cost", input[1].to_i)
      elsif input[0] == "attack" || input[0] == "a" then imposeCondition("attack", input[1].to_i)
      elsif input[0] == "health" || input[0] == "h" then imposeCondition("health", input[1].to_i)
      else puts "Invalid option."; next
      end
    end
  end

  def newSearch(onlyMinions)
    @searchSet = @nameToCardHash.keys
    if onlyMinions
      @searchSet.delete_if {|cardName| @nameToCardHash[cardName]["type"] != "MINION"}
    end
  end

  def imposeCondition(key, value)
    @searchSet.delete_if {|cardName| @nameToCardHash[cardName][key] != value}
    printCards
  end

  def printCards
    if @searchSet.empty?
      puts "Empty :(\nI'll reset the search for you."
      newSearch(true)
      return
    end
    maxNameLength = @searchSet.max {|a,b| a.length <=> b.length}.length
    @searchSet.each do |cardName|
      printf "%-#{maxNameLength+1}s", cardName
      printf "%-4s", "#{@nameToCardHash[cardName]["cost"]}c"
      printf "%-4s", "#{@nameToCardHash[cardName]["attack"]}a"
      printf "%-4s", "#{@nameToCardHash[cardName]["health"]}h"
      printf "%-8s", @nameToCardHash[cardName]["playerClass"]
      printf "%-10s", @nameToCardHash[cardName]["rarity"]
      puts
    end
  end
end

cardSearch = CardSearch.new
cardSearch.handleInput

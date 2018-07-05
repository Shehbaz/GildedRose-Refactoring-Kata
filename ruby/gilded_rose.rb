require 'byebug'
class GildedRose

  def initialize(items)
    @items = items
  end
  def update_quality()
    #todo (if time permits) create a function to get updater based on item name
    @items.each do |item|
      if item.name == 'Aged Brie'
        AgedBrieUpdater.new(item).update  
      elsif item.name == 'Sulfuras, Hand of Ragnaros'
        SulfurasUpdater.new(item).update                
      elsif item.name == 'Backstage passes to a TAFKAL80ETC concert'
        BackstagePassUpdater.new(item).update  
      elsif item.name == 'Conjured'
        ConjuredUpdater.new(item).update
      else
        DefaultUpdater.new(item).update               
      end             
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end

class DefaultUpdater
  attr_accessor :item

  def initialize(item)
    @item = item
  end

  def update
    #call quality first before changing the sell in date
    change_quality
    change_sell_in
  end

  def change_sell_in
    item.sell_in = item.sell_in - 1
  end
  
  def change_quality
    if item.sell_in > 0
      quality = item.quality - 1
    else
      quality = item.quality - 2
    end

    if quality >= 0
      item.quality = quality 
    end
  end
end

class AgedBrieUpdater < DefaultUpdater

  def change_quality
    if item.sell_in > 0
      quality = item.quality + 1
    else
      quality = item.quality + 2
    end  
    item.quality = 50 if quality > 50
    item.quality = quality if quality <= 50
  end
end

class SulfurasUpdater < DefaultUpdater
   #do nothing as we dont want to change quality or sell in
  def change_quality; end
   
  def change_sell_in; end

end

class BackstagePassUpdater < DefaultUpdater

  def change_quality  
    quality = 0
    if item.sell_in > 10
      quality = item.quality + 1
    elsif item.sell_in > 5
     quality = item.quality + 2
    elsif item.sell_in > 0
      quality = item.quality + 3
    end
    item.quality = 50 if quality > 50
    item.quality = quality if quality <= 50
  end 
end

class ConjuredUpdater < DefaultUpdater

  def change_quality  
    #twice the speed of normal item
    if item.sell_in > 0
      item.quality = item.quality - 2
    else
      item.quality = item.quality - 4
    end
    item.quality = 0 if item.quality < 0
  end 
end






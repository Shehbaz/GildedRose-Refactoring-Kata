class GildedRose

  def initialize(items)
    @items = items
  end
  def update_quality()
    @items.each do |item|
      if item.name == 'Aged Brie'
        AgedBrieUpdater.new(item).update       
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
    item.sell_in = item.sell_in - 1
    change_quality
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
    if quality <= 50 
      item.quality = quality 
    end
  end
end
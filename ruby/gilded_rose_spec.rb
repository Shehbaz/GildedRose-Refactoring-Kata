require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  describe '#update' do
    context 'Normal Item' do
      it 'does not change the name' do
        item = Item.new('foo', 5, 5)
        gilded_rose = GildedRose.new([item])
        gilded_rose.update_quality
        expect(item.name).to eq 'foo'
      end

      it 'lowers sell_in value by 1' do
        item = Item.new('normal', 10, 6)
        gilded_rose = GildedRose.new([item])
        gilded_rose.update_quality
        expect(item.sell_in).to eq 9
      end

      it 'degardes quality by 1 when sell by date not passed' do
        item = Item.new('normal', 20, 11)
        gilded_rose = described_class.new([item])
        gilded_rose.update_quality
        expect(item.quality).to eq 10
      end

      it 'degrades quality by 2 when sell by date has passed' do
        item = Item.new('normal', 0, 12)
        gilded_rose = GildedRose.new([item])
        gilded_rose.update_quality
        expect(item.quality).to eq 10
      end

      it 'does not change quality to negative' do
        item = Item.new('normal', 10, 0)
        gilded_rose = GildedRose.new([item])
        gilded_rose.update_quality
        expect(item.quality).to eq 0
      end
    end

    context 'Aged Brie item' do
      it 'quality increases by 1 when sell by date not passed' do
        item = Item.new('Aged Brie', 10, 10)
        gilded_rose = GildedRose.new([item])
        gilded_rose.update_quality
        expect(item.quality).to eq 11
      end
      it 'does not increase quality above 50' do
        item = Item.new('Aged Brie', 10, 50)
        gilded_rose = GildedRose.new([item])
        gilded_rose.update_quality
        expect(item.quality).to eq 50
      end
    end

    context 'Sulfuras item' do
      it 'does not change the sell by date' do
        item = Item.new('Sulfuras, Hand of Ragnaros', 0, 80)
        gilded_rose = GildedRose.new([item])
        gilded_rose.update_quality
        expect(item.sell_in).to eq 0
      end

      it 'does not change the quality' do
        item = Item.new('Sulfuras, Hand of Ragnaros', 0, 80)
        gilded_rose = GildedRose.new([item])
        gilded_rose.update_quality
        expect(item.quality).to eq 80
      end
    end

    context 'Backstage passes item' do
      it 'does not increase quality above 50' do
        item = Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 50)
        gilded_rose = GildedRose.new([item])
        gilded_rose.update_quality
        expect(item.quality).to eq 50
      end

      context 'when more than 10 days left for sell by' do
        it ' increases quality by 1' do
          item = Item.new('Backstage passes to a TAFKAL80ETC concert', 12, 9)
          gilded_rose = GildedRose.new([item])
          gilded_rose.update_quality
          expect(item.quality).to eq 10
        end
      end

      context 'when more than 5 days and less than 10 days for sell by' do
        it 'increases quality by 2' do
          item = Item.new('Backstage passes to a TAFKAL80ETC concert', 7, 9)
          gilded_rose = GildedRose.new([item])
          gilded_rose.update_quality
          expect(item.quality).to eq 11
        end
      end

      context 'when 5 days or less for sell by' do
        it 'increases quality by 3' do
          item = Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 9)
          gilded_rose = GildedRose.new([item])
          gilded_rose.update_quality
          expect(item.quality).to eq 12
        end
      end

      context 'when sell by passed' do
        it 'set quality to 0' do
          item = Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 9)
          gilded_rose = GildedRose.new([item])
          gilded_rose.update_quality
          expect(item.quality).to eq 0
        end
      end
    end
    context 'Conjured Item' do
      context 'when sell in date has not passed' do
        it 'degardes quality by 2' do
          item = Item.new('Conjured', 1, 2)
          gilded_rose = GildedRose.new([item])
          gilded_rose.update_quality
          expect(item.quality).to eq 0
        end
        it 'degardes quality twice the speed with odd value' do
          item = Item.new('Conjured', 5, 3)
          gilded_rose = GildedRose.new([item])
          gilded_rose.update_quality
          gilded_rose.update_quality
          expect(item.quality).to eq 0
        end
      end

      context 'when sell in date has passed' do
        it 'degardes quality by 4' do
          item = Item.new('Conjured', 0, 4)
          gilded_rose = GildedRose.new([item])
          gilded_rose.update_quality
          expect(item.quality).to eq 0
        end
      end

      it 'lowers sell_in value by 1' do
        item = Item.new('Conjured', 10, 6)
        gilded_rose = GildedRose.new([item])
        gilded_rose.update_quality
        expect(item.sell_in).to eq 9
      end
    end
  end
end

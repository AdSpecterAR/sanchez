require 'rails_helper'

describe AdUnit, type: :model do
  let!(:ad_unit) do
    create :ad_unit,
           ad_format: AdUnit::FORMAT_IMAGE,
           dimensions: AdUnit::DIMENSIONS_16_BY_9,
           last_served_at: Time.current,
           active: true
  end
  let!(:older_ad_unit) do
    create :ad_unit,
           ad_format: AdUnit::FORMAT_IMAGE,
           dimensions: AdUnit::DIMENSIONS_16_BY_9,
           last_served_at: 1.day.ago,
           active: true
  end
  let!(:unserved_ad_unit) do
    create :ad_unit,
           ad_format: AdUnit::FORMAT_IMAGE,
           dimensions: AdUnit::DIMENSIONS_16_BY_9,
           last_served_at: nil,
           active: true
  end
  let!(:inactive_ad_unit) { create(:ad_unit, active: false) }

  describe "scopes" do
    it "should return only active ad units" do
      active_ad_units = AdUnit.active

      expect(active_ad_units).to match_array [ad_unit, older_ad_unit, unserved_ad_unit]
    end
  end

  describe "validations" do
    it "should return a valid ad unit" do
      expect(ad_unit).to be_valid
    end

    it "should not return a valid ad unit without dimensions" do
      ad_unit.update(dimensions: '3:2')

      expect(ad_unit).not_to be_valid
    end

    it "should not return a valid ad unit without format" do
      ad_unit.update(ad_format: 'GIF')

      expect(ad_unit).not_to be_valid
    end
  end

  describe "#fetch" do
    it "should return a valid ad unit" do
      ad_unit = AdUnit.fetch(ad_format: AdUnit::FORMAT_IMAGE, dimensions: AdUnit::DIMENSIONS_16_BY_9)

      expect(ad_unit).to be_valid
    end

    it "should return least recently served ad given no unserved ads" do
      unserved_ad_unit.update(last_served_at: Time.current)
      ad_unit = AdUnit.fetch(ad_format: AdUnit::FORMAT_IMAGE, dimensions: AdUnit::DIMENSIONS_16_BY_9)

      expect(ad_unit).to eql older_ad_unit
    end

    it "should not return an ad unit without corresponding format or dimension" do
      ad_unit = AdUnit.fetch(ad_format: AdUnit::FORMAT_IMAGE, dimensions: AdUnit::DIMENSIONS_1_BY_1)

      expect(ad_unit).to be_nil
    end

    it "should fetch all corresponding ad unit entries" do
      ad_units = AdUnit.fetch_all(ad_format: AdUnit::FORMAT_IMAGE, dimensions: AdUnit::DIMENSIONS_16_BY_9)

      expect(ad_units).to match_array [unserved_ad_unit, older_ad_unit, ad_unit]
    end

    it "should fetch all corresponding ad unit entries in order" do
      ad_units = AdUnit.fetch_all(ad_format: AdUnit::FORMAT_IMAGE, dimensions: AdUnit::DIMENSIONS_16_BY_9)

      expect(ad_units[0][:id]).to eql unserved_ad_unit.id
      expect(ad_units[1][:id]).to eql older_ad_unit.id
      expect(ad_units[2][:id]).to eql ad_unit.id
    end
  end
end

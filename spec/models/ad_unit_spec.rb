require 'rails_helper'

describe AdUnit, type: :model do
  let!(:ad_unit) do
    create :ad_unit,
           :wide,
           ad_format: AdUnit::FORMAT_IMAGE,
           last_served_at: Time.current,
           active: true,
           rewarded: false
  end
  let!(:older_ad_unit) do
    create :ad_unit,
           :wide,
           ad_format: AdUnit::FORMAT_IMAGE,
           last_served_at: 1.day.ago,
           active: true,
           rewarded: false
  end
  let!(:unserved_ad_unit) do
    create :ad_unit,
           :wide,
           ad_format: AdUnit::FORMAT_IMAGE,
           last_served_at: nil,
           active: true,
           rewarded: false
  end
  let!(:inactive_ad_unit) { create(:ad_unit, active: false, rewarded: false) }
  let!(:inactive_rewarded_ad_unit) do
    create :ad_unit,
           ad_format: AdUnit::FORMAT_VIDEO,
           last_served_at: Time.current,
           active: false,
           rewarded: true
  end
  let!(:interstitial_ad_unit) do
    create :ad_unit,
           ad_format: AdUnit::FORMAT_VIDEO,
           last_served_at: Time.current,
           interstitial: true
  end
  let(:aspect_ratio_width) { 16 }
  let(:aspect_ratio_height) { 9 }
  let!(:rewarded_ad_unit) do
    create :ad_unit,
           ad_format: AdUnit::FORMAT_VIDEO,
           last_served_at: Time.current,
           active: false,
           rewarded: true
  end

  describe "scopes" do
    it "should return only active ad units" do
      active_ad_units = AdUnit.active

      expect(active_ad_units).to match_array [ad_unit, older_ad_unit, unserved_ad_unit, interstitial_ad_unit]
    end

    it "should return only inactive ad units" do
      inactive_ad_units = AdUnit.inactive

      expect(inactive_ad_units).to match_array [inactive_ad_unit, inactive_rewarded_ad_unit, rewarded_ad_unit]
    end

    it "should return only rewarded ad units" do
      rewarded_ad_units = AdUnit.rewarded

      expect(rewarded_ad_units).to match_array [inactive_rewarded_ad_unit, rewarded_ad_unit]
    end

    it "should return only unrewarded ad units" do
      unrewarded_ad_units = AdUnit.unrewarded

      expect(unrewarded_ad_units).to match_array [ad_unit, older_ad_unit, unserved_ad_unit, inactive_ad_unit, interstitial_ad_unit]
    end

    it "should return only interstitial ad units" do
      interstitial_ad_units = AdUnit.interstitial

      expect(interstitial_ad_units).to match_array [interstitial_ad_unit]
    end

    it "should return all noninterstitial ad units" do
      noninterstitial_ad_units = AdUnit.noninterstitial

      expect(noninterstitial_ad_units).to match_array [ad_unit, older_ad_unit, unserved_ad_unit, inactive_ad_unit, inactive_rewarded_ad_unit, rewarded_ad_unit]
    end
  end

  describe "validations" do
    it "should return a valid ad unit" do
      expect(ad_unit).to be_valid
    end

    it "should not return a valid ad unit without format" do
      ad_unit.update(ad_format: 'GIF')

      expect(ad_unit).not_to be_valid
    end

    it "should return a valid rewarded ad unit" do
      expect(rewarded_ad_unit).to be_valid
    end

    it "should not return a valid rewarded ad unit without video format" do
      rewarded_ad_unit.update(ad_format: AdUnit::FORMAT_IMAGE)

      expect(rewarded_ad_unit).not_to be_valid
    end

    it "should not return a valid ad unit without a valid call to action" do
      ad_unit.update(call_to_action: '')

      expect(ad_unit).not_to be_valid
    end
  end

  describe "#fetch" do
    it "should return a valid ad unit" do
      ad_unit = AdUnit.fetch(
        ad_format: AdUnit::FORMAT_IMAGE,
        aspect_ratio_width: aspect_ratio_width,
        aspect_ratio_height: aspect_ratio_height
      )

      expect(ad_unit).to be_valid
    end

    it "should return least recently served ad given no unserved ads" do
      unserved_ad_unit.update(last_served_at: Time.current)
      ad_unit = AdUnit.fetch(
        ad_format: AdUnit::FORMAT_IMAGE,
        aspect_ratio_width: aspect_ratio_width,
        aspect_ratio_height: aspect_ratio_height
      )

      expect(ad_unit).to eql older_ad_unit
    end

    it "should not return an ad unit without corresponding format or aspect ratio" do
      ad_unit = AdUnit.fetch(
        ad_format: AdUnit::FORMAT_IMAGE,
        aspect_ratio_width: aspect_ratio_width + 1,
        aspect_ratio_height: aspect_ratio_height
      )

      expect(ad_unit).to be_nil
    end

    it "should fetch all corresponding ad unit entries" do
      ad_units = AdUnit.fetch_all(
        ad_format: AdUnit::FORMAT_IMAGE,
        aspect_ratio_width: aspect_ratio_width,
        aspect_ratio_height: aspect_ratio_height
      )

      expect(ad_units).to match_array [unserved_ad_unit, older_ad_unit, ad_unit]
    end

    it "should fetch all corresponding ad unit entries in order" do
      ad_units = AdUnit.fetch_all(
        ad_format: AdUnit::FORMAT_IMAGE,
        aspect_ratio_width: aspect_ratio_width,
        aspect_ratio_height: aspect_ratio_height
      )

      expect(ad_units[0][:id]).to eql unserved_ad_unit.id
      expect(ad_units[1][:id]).to eql older_ad_unit.id
      expect(ad_units[2][:id]).to eql ad_unit.id
    end
  end
end

require 'spec_helper'

describe Postcodesio do

  context 'requesting information on a single postcode works correctly' do

    before(:all) do
      @postcodesio = Postcodesio.new
      @response = @postcodesio.single_postcode_response("TW76XG") #input a postcode
    end

    it "should respond with a status message of 200" do
        expect(@response["status"]).to eq 200
    end

    it "should have a results hash" do
        expect(@response).to be_a Hash
    end

    it "should return a postcode between 5-7 in length"  do
        expect(@response["result"]["postcode"].length).to be_between(5, 8)
    end

    it "should return an quality key integer between 1-9" do
        expect(@response["result"]["quality"]).to be_a Integer
        expect(@response["result"]["quality"]).to be_between(1, 10)
    end

    it "should return an ordnance survey eastings value as integer" do
        expect(@response["result"]["eastings"]).to be_a Integer
    end

    it "should return an ordnance survey eastings value as integer" do
        expect(@response["result"]["eastings"]).to be_a Integer
    end

    it "should return a country which is one of the four constituent countries of the UK" do
        expect(@response["result"]["country"]).to eq('England').or(eq('Wales')).or(eq('Scotland')).or(eq('Northern Ireland'))
    end

    it "should return a string value for NHS authority " do
        expect(@response["result"]["nhs_ha"]).to be_a String

    end

    it "should return a longitude float value" do
        expect(@response["result"]["longitude"]).to be_a Float
    end

    it "should return a latitude float value" do
        expect(@response["result"]["latitude"]).to be_a Float
    end

    it "should return a parliamentary constituency string" do
        expect(@response["result"]["longitude"]).to be_a Float
    end

    it "should return a european_electoral_region string" do
        expect(@response["result"]["parliamentary_constituency"]).to be_a String
    end

    it "should return a primary_care_trust string" do
        expect(@response["result"]["primary_care_trust"]).to be_a String
    end

    it "should return a region string" do
        expect(@response["result"]["region"]).to be_a String
    end

    it "should return a parish string" do
        expect(@response["result"]["parish"]).to be_a String
    end

    it "should return a lsoa string" do
        expect(@response["result"]["lsoa"]).to be_a String
    end

    it "should return a msoa string" do
        expect(@response["result"]["msoa"]).to be_a String
    end
    # admin ward and county are not documented however tested below

    it "should return a admin_district string" do
        expect(@response["result"]["codes"]["admin_district"]).to be_a String
    end

    it "should return a incode string of three characters" do
        expect(@response["result"]["incode"]).to be_a String
        expect(@response["result"]["incode"].length).to eq 3

    end

    it "should return a msoa string" do
         expect(@response["result"]["msoa"]).to be_a String
    end

    it "should return a incode string of 3-4 characters" do
        expect(@response["result"]["incode"]).to be_a String
        expect(@response["result"]["incode"].length).to eq(3).or(eq(4))
    end
  end

  context "multiple postcodes validation" do

    before(:all) do
      @postcodesio = Postcodesio.new
      @response = @postcodesio.multiple_postcodes_response(["SE184HR", "W52NU"])
      @first_result = @response["result"][0]
      @second_result = @response["result"][1]

      puts @response
     

    
  
    end

    it "should respond with a status message of 200" do
        expect(@response["status"]).to eq 200
    end

    it "should return the first query as the first postcode in the response" do
        expect(@first_result["query"]).to eq "SE184HR"

    end

    it "should return the second query as the second postcode in the response" do
        expect(@second_result["query"]).to eq "W52NU"
    end

    it "should have a results hash" do
        @response["result"].each do |i|
            expect(i["result"]).to be_a Hash
        end
    end

    it "should return a postcode between 5-7 in length"  do
        @response["result"].each do |i|
            expect(i["query"].length).to be_between(5,8)
        end
    end

    it "should return an quality key integer between 1-9" do

        #checking for all postcodes
        @response["result"].each do |i|
            expect(i["result"]["quality"]).to be_a Integer
            expect(i["result"]["quality"]).to be_between(1, 9)
        end

        #checking for each postcodes separately
        # expect(@first_result["result"]["quality"]).to be_a Integer
        # expect(@first_result["result"]["quality"]).to be_between(1, 9)


    end

    it "should return an ordnance survey eastings value as integer" do
        @response["result"].each do |i|
            expect(i["result"]["eastings"]).to be_a Integer
        end

    end

    it "should return an ordnance survey eastings value as integer" do
        @response["result"].each do |i|
            expect(i["result"]["eastings"]).to be_a Integer
        end
    end

    it "should return a country which is one of the four constituent countries of the UK" do
        @response["result"].each do |i|
            expect(i["result"]["country"]).to eq('England').or(eq('Wales')).or(eq('Scotland')).or(eq('Northern Ireland'))
        end
    end

    it "should return a string value for NHS authority " do
        @response["result"].each do |i|
            expect(i["result"]["nhs_ha"]).to be_a String
        end
    end

    it "should return a longitude float value" do
        @response["result"].each do |i|
            expect(i["result"]["longitude"]).to be_a Float
        end
    end

    it "should return a latitude float value" do
        @response["result"].each do |i|
            expect(i["result"]["latitude"]).to be_a Float
        end
    end

    it "should return a parliamentary constituency string" do
        @response["result"].each do |i|
            expect(i["result"]["parliamentary_constituency"]).to be_a String
        end
    end

    it "should return a european_electoral_region string" do
        @response["result"].each do |i|
            expect(i["result"]["european_electoral_region"]).to be_a String
        end
    end

    it "should return a primary_care_trust string" do
        @response["result"].each do |i|
            expect(i["result"]["primary_care_trust"]).to be_a String
        end
    end

    it "should return a region string" do
        @response["result"].each do |i|
            expect(i["result"]["region"]).to be_a String
        end
    end

    it "should return a parish string" do
        @response["result"].each do |i|
            expect(i["result"]["parish"]).to be_a String
        end
    end

    it "should return a lsoa string" do
        @response["result"].each do |i|
            expect(i["result"]["lsoa"]).to be_a String
        end
    end

    it "should return a msoa string" do
        @response["result"].each do |i|
            expect(i["result"]["msoa"]).to be_a String
        end
    end
    # admin ward and county are not documented however tested below

    it "should return a admin_district string" do
        @response["result"].each do |i|
            expect(i["result"]["admin_district"]).to be_a String
        end
    end

    it "should return a incode string of three characters" do
        @response["result"].each do |i|
            expect(i["result"]["incode"]).to be_a String
            expect(i["result"]["incode"].length).to eq 3
        end
    end

    it "should return a msoa string" do
        @response["result"].each do |i|
            expect(i["result"]["msoa"]).to be_a String
        end
    end

    it "should return a incode string of 3-4 characters" do
        @response["result"].each do |i|
            expect(i["result"]["incode"]).to be_a String
            expect(i["result"]["incode"].length).to be_between(3, 4)
        end
    end

    it "should have a results hash" do
         @response["result"].each do |i|
            expect(i["result"]).to be_a Hash
        end
    end

    it "should return a postcode between 5-7 in length"  do
        @response["result"].each do |i|
            expect(i["query"].length).to be_between(5,8)
        end
    end

    it "should return an quality key integer between 1-9" do
        @response["result"].each do |i|
            expect(i["result"]["quality"]).to be_a Integer
            expect(i["result"]["quality"]).to be_between(1, 9)
        end
    end

    it "should return an ordnance survey eastings value as integer" do
         @response["result"].each do |i|
            expect(i["result"]["eastings"]).to be_a Integer
        end
    end

    it "should return an ordnance survey eastings value as integer" do
         @response["result"].each do |i|
            expect(i["result"]["eastings"]).to be_a Integer
        end
    end

    it "should return a country which is one of the four constituent countries of the UK" do
        @response["result"].each do |i|
            expect(i["result"]["country"]).to eq('England').or(eq('Wales')).or(eq('Scotland')).or(eq('Northern Ireland'))
        end
    end

    it "should return a string value for NHS authority " do
        @response["result"].each do |i|
            expect(i["result"]["nhs_ha"]).to be_a String
        end
    end

    it "should return a longitude float value" do
        @response["result"].each do |i|
            expect(i["result"]["longitude"]).to be_a Float
        end
    end

    it "should return a latitude float value" do
        @response["result"].each do |i|
            expect(i["result"]["latitude"]).to be_a Float
        end
    end

    it "should return a parliamentary constituency string" do
        @response["result"].each do |i|
            expect(i["result"]["parliamentary_constituency"]).to be_a String
        end
    end

    it "should return a european_electoral_region string" do
        @response["result"].each do |i|
            expect(i["result"]["european_electoral_region"]).to be_a String
        end
    end

    it "should return a primary_care_trust string" do
        @response["result"].each do |i|
            expect(i["result"]["primary_care_trust"]).to be_a String
        end
    end

    it "should return a region string" do
        @response["result"].each do |i|
            expect(i["result"]["region"]).to be_a String
        end
    end

    it "should return a parish string" do
        @response["result"].each do |i|
            expect(i["result"]["parish"]).to be_a String
        end
    end

    it "should return a lsoa string" do
        @response["result"].each do |i|
            expect(i["result"]["lsoa"]).to be_a String
        end
    end

    it "should return a msoa string" do
        @response["result"].each do |i|
            expect(i["result"]["msoa"]).to be_a String
        end
    end
    # admin ward and county are not documented however tested below

    it "should return a admin_district string" do
        @response["result"].each do |i|
            expect(i["result"]["admin_district"]).to be_a String
        end
    end

    it "should return a incode string of three characters" do
        @response["result"].each do |i|
            expect(i["result"]["incode"]).to be_a String
            expect(i["result"]["incode"].length).to eq 3
        end
    end

    it "should return a msoa string" do
        @response["result"].each do |i|
            expect(i["result"]["msoa"]).to be_a String
        end
    end

    it "should return a incode string of 3-4 characters" do
        @response["result"].each do |i|
            expect(i["result"]["incode"]).to be_a String
            expect(i["result"]["incode"].length).to be_between(3, 4)
        end
    end

  end


end

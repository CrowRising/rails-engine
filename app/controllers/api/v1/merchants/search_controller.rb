# frozen_string_literal: true

module Api
  module V1
    module Merchants
      class SearchController < ApplicationController

        def search
          if !params[:name] || params[:name].empty?
            render json: { error: 'Bad Request' }, status: 404
          elseif Merchant.find_by_name_fragment(params[:name]) == []
            render json: { data: [] }, status: 200
          elsif Merchant.find_by_name_fragment(params[:name])
            render json: MerchantSerializer.new(Merchant.find_by_name_fragment(params[:name]).first)
          end
        end
      end
    end
  end
end

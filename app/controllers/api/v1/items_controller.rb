# frozen_string_literal: true

module Api
  module V1
    class ItemsController < ApplicationController
      def index
        render json: ItemSerializer.new(Item.all)
      end

      def show
        render json: ItemSerializer.new(Item.find(params[:id]))
      end

      def create
        render(status: 201, json: ItemSerializer.new(Item.create(item_params)))
      end

      def update
        item = Item.find(params[:id])
        item.update!(item_params)
        render json: ItemSerializer.new(item)
      end

      def destroy
        item = Item.find(params[:id])
        item.destroy
        item.invoice_delete
      end

      private

      def item_params
        params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
      end
    end
  end
end

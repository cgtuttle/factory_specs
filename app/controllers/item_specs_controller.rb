class ItemSpecsController < ApplicationController

include ApplicationHelper
require 'will_paginate/array' 
	
  def index
		@history = params[:history]
		@future = params[:future]
		set_scope
		@title = "Specifications for Item"
		@item_specs = ItemSpec.by_status(@item_id, @history, @future)
		@specs = Spec.order(:display_order)
		@items = Item.order(:code)
		@span = 10
		@is_index_table = true
  end
	
	def edit
		@item_spec = ItemSpec.find(params[:id])
		@new_item_spec = @item_spec.dup
	end
	
	def create
		logger.debug "Running create"
		@new_item_spec = ItemSpec.new(params[:item_spec])
		@new_item_spec.save
		redirect_to item_specs_path :item_id => params[:item_spec][:item_id]
	end
	
	def set_scope
		if params[:item] && !params[:item].blank?
			@item_id = params[:item]
			logger.debug "params has key :item - #{params[:item]}"			
		elsif params.has_key?(:item_spec)
			logger.debug "params has key :item_spec - #{params[:item_spec]}"
			@item_id = params[:item_spec][:item_id]
		else
			@item_id = get_item_id
			logger.debug "No params - @item_id = #{@item_id}"
		end

		@item = Item.exists?(@item_id) ? Item.find(@item_id) : nil

		cookies[:item_id] = @item_id		
		@history = (params[:include_history] && !params[:include_history].blank?) || (@history && !@history.blank?)
		@future = (params[:include_future] && !params[:include_future].blank?) || (@future && !@future.blank?)
	end
end

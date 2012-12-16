class ItemSpecsController < ApplicationController

include ApplicationHelper
require 'will_paginate/array' 
	
  def index
  	@new_item_spec = ItemSpec.new
		@history = params[:history]
		@future = params[:future]
		set_scope
		@title = "Specifications for Item"
		@item_specs = ItemSpec.by_status(@item_id, @history, @future)
		@specs = Spec.order(:display_order)
		@items = Item.order(:code)
		@available_specs = @item.available_specs
		@span = 12
		@is_index_table = true
  end
	
	def edit
		@item_spec = ItemSpec.find(params[:id])
		@new_item_spec = @item_spec.dup
		@is_edit_form = true
		@title = "#{@new_item_spec.spec.name} Specification"
	end
	
	def create
		if params[:commit] != 'Cancel'
			@new_item_spec = ItemSpec.new(params[:item_spec])
			@new_item_spec.item = @item
			if @new_item_spec.save
				flash[:success] = "Item Spec added/changed"
				redirect_to item_specs_path :item_id => params[:item_spec][:item_id]
			else
				redirect_to item_specs_path :item_id => params[:item_spec][:item_id]
			end
		else
			redirect_to item_specs_path :item_id => params[:item_spec][:item_id]
		end
	end

	def destroy
logger.debug "destroy params: #{params.inspect}"
		@item_spec = ItemSpec.find(params[:id])
		@delete_item_spec = @item_spec.dup
		@delete_item_spec.deleted = true
		@delete_item_spec.save
		redirect_to item_specs_path :item_id => @item_spec.item_id
	end
	
	def set_scope
		if params[:item] && !params[:item].blank?
			@item_id = params[:item]	
		elsif params.has_key?(:item_spec)
			@item_id = params[:item_spec][:item_id]
		else
			@item_id = get_item_id
		end

		@item = Item.exists?(@item_id) ? Item.find(@item_id) : nil

		cookies[:item_id] = @item_id		
		@history = (params[:include_history] && !params[:include_history].blank?) || (@history && !@history.blank?)
		@future = (params[:include_future] && !params[:include_future].blank?) || (@future && !@future.blank?)
	end
end

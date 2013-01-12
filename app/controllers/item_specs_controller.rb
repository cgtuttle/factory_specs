class ItemSpecsController < ApplicationController

include ApplicationHelper
require 'will_paginate/array' 
	
  def index
		@history = params[:history]
		@pending = params[:pending]
		@specs = Spec.order(:display_order)
		set_scope
  	if @item
	  	@new_item_spec = ItemSpec.new
			@title = "Specifications for Item"
			@item_specs = ItemSpec.by_status(@item_id).paginate(:page => params[:page], :per_page => 20)
			@index = @item_specs
			@items = Item.order(:code)
			@available_specs = @item.available_specs
			@span = 12
			@is_index_table = true
		else
			flash[:alert] = "There are no items yet - please add at least one"
			redirect_to items_path
		end
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
			@new_item_spec.set_eff_date
			@new_item_spec.set_version
			@new_item_spec.set_editor(current_user.email)
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
		@item_spec = ItemSpec.find(params[:id])
		@delete_item_spec = @item_spec.dup
		@delete_item_spec.deleted = true
		if @delete_item_spec.save
			flash[:success] = "Item Spec deleted"
			redirect_to item_specs_path :item_id => @item_spec.item_id
		else
			redirect_to item_specs_path :item_id => @item_spec.item_id
		end
	end

	def copy
		@item_spec = ItemSpec.find(params[:id])
	end

	def cancel
		@item_spec = ItemSpec.find(params[:id])
		@item_spec.canceled = true
		@item_spec.set_eff_date
		@item_spec.set_version
		if @item_spec.save
			flash[:success] = "Future Item Spec canceled"
			redirect_to item_specs_path :item_id => @item_spec.item_id
		else
			redirect_to item_specs_path :item_id => @item_spec.item_id
		end
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
		@pending = (params[:include_pending] && !params[:include_pending].blank?) || (@pending && !@pending.blank?)
	end
end

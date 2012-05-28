class ItemSpecsController < ApplicationController

require 'will_paginate/array' 
	
  def index
		logger.debug "Running index"
		@history = params[:history]
		@future = params[:future]
		logger.debug "@history -> #{@history}, @future -> #{@future}"
		set_scope
		@title = "Specifications for #{@item.code}"
		@item_specs = ItemSpec.by_status(@item.id, @history, @future).paginate(:page => params[:page], :per_page => 30)
		@specs = Spec.order(:code)
		@items = Item.order(:code)
  end
	
	def edit
		logger.debug "Running edit"
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
		logger.debug "Running set_scope"
		if params[:item] && !params[:item].blank?
			@item = Item.find(params[:item])
		elsif params.has_key?(:item_spec)
			@item = Item.find(params[:item_spec][:item_id])
		else
			@item = Item.order(:code).first
		end
		logger.debug "@history -> #{@history}, @future -> #{@future}"
		logger.debug "params -> #{params[:include_future]}"
		
		@history = (params[:include_history] && !params[:include_history].blank?) || (@history && !@history.blank?)
		@future = (params[:include_future] && !params[:include_future].blank?) || (@future && !@future.blank?)
		logger.debug "@history -> #{@history}, @future -> #{@future}"
	end
end

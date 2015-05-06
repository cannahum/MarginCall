class CollectionsController < ApplicationController
  before_action :set_collection, only: [:show, :edit, :update, :destroy]
  require 'collections_helper'

  # GET /collections
  # GET /collections.json
  def index
    @collections = Collection.all
  end

  # GET /collections/1
  # GET /collections/1.json
  def show
  end

  # GET /collections/new
  def new
    @collection = Collection.new
  end

  # GET /collections/1/edit
  def edit
  end

  # POST /collections
  # POST /collections.json
  def create
    ticker = ""
    quantity = ""
    params.each do |vn| 
      name = eval(vn.to_s)
      if name[0].include? "tick"
        ticker.concat(name[1] + "+")
      elsif name[0].include? "quan"
        quantity.concat(name[1] + "+")
      end 
    end
    @collection = Collection.new(user_id: session[:user_id], stock_id: ticker.chomp!("+"), quantity: quantity.chomp!("+"), nickname: params.fetch(:nickname) )
    @collection = reorganize_params(@collection)

    respond_to do |format|
      if @collection.save
        Stock.create(ticker:"#{collection.user_id},#{@collection.nickname}", current_price: 100, collection: true)
        format.html { redirect_to user_path(current_user), notice: 'Collection was successfully created.' }
        format.json { render :show, status: :created, location: @collection }
      else
        format.html { render :new }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /collections/1
  # PATCH/PUT /collections/1.json
  def update
    respond_to do |format|
      if @collection.update(collection_params)
        format.html { redirect_to @collection, notice: 'Collection was successfully updated.' }
        format.json { render :show, status: :ok, location: @collection }
      else
        format.html { render :edit }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collections/1
  # DELETE /collections/1.json
  def destroy
    @collection.destroy
    respond_to do |format|
      format.html { redirect_to collections_url, notice: 'Collection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collection
      @collection = Collection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def collection_params
      params.require(:collection).permit(:id, :user_id, :ticker0, :quantity0)
    end
end

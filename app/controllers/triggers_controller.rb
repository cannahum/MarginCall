require 'pry'
require 'pry-byebug'

class TriggersController < ApplicationController
  require 'trigger_service'
  before_action :set_trigger, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:index, :destroy]

  # GET /triggers
  # GET /triggers.json
  def index
    @triggers = Trigger.all
  end

  # GET /triggers/1
  # GET /triggers/1.json
  def show
  end

  # GET /triggers/new
  def new
    @trigger = Trigger.new
  end

  # GET /triggers/1/edit
  def edit
  end

  # POST /triggers
  # POST /triggers.json
  def create
    @trigger = Trigger.new(trigger_params)
    #add new stock here
    #checks if logged in and takes in form submittion to set a Trigger
    if logged_in?
      respond_to do |format|
        if @trigger.save
          @trigger.userEmail = current_user.email1
          @trigger.active = true
          @trigger.triggertype = params.fetch(:triggertype)
          @trigger.comparison = params.fetch(:comparison)
          @trigger.save
          TriggerService.unique_stock @trigger.ticker
          format.html { redirect_to @trigger, notice: 'Trigger was successfully created.' }
          format.json { render :show, status: :created, location: @trigger }         
        else
          format.html { render :new }
          format.json { render json: @trigger.errors, status: :unprocessable_entity }
        end
      end
    #if not logged in it redirects you to login page
    else
      flash[:danger] = 'Please log in to set a new trigger.'
      redirect_to login_path
    end
  end

  # PATCH/PUT /triggers/1
  # PATCH/PUT /triggers/1.json
  def update
    respond_to do |format|
      if @trigger.update(trigger_params)
        format.html { redirect_to @trigger, notice: 'Trigger was successfully updated.' }
        format.json { render :show, status: :ok, location: @trigger }
      else
        format.html { render :edit }
        format.json { render json: @trigger.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /triggers/1
  # DELETE /triggers/1.json
  def destroy
    @trigger.destroy
    respond_to do |format|
      format.html { redirect_to user_path(current_user), notice: 'Trigger was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trigger
      @trigger = Trigger.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trigger_params
      params.require(:trigger).permit(:userEmail, :ticker, :trigger_price)
    end

end

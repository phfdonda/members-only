class MembersController < ApplicationController
  before_action :set_member, only: %i[show edit update destroy]
  before_action :authenticate_member!, except: %i[index show]

  # GET /members
  # GET /members.json
  def index
    @members = Member.member_list
    @member = Member.new
  end

  # GET /members/new
  def new
    @member = current_user.members.build
  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.new(member_params)

    respond_to do |format|
      if @member.save
        format.html { redirect_to root_path, notice: 'member was successfully created.' }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { render :new }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to @member, notice: 'member was successfully updated.' }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url, notice: 'member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_member
    @member = member.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def member_params
    params.require(:member).permit(:name, :email, :password, :password_confirmation)
  end
end

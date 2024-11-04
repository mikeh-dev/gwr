class RepairCasesController < ApplicationController

  def new
    @repair_case = RepairCase.new
  end

  def create
    @repair_case = RepairCase.new(repair_case_params)
  end

  def show
    @repair_case = RepairCase.find(params[:id])
  end

  def index
    @repair_cases = RepairCase.all
  end

  def edit
    @repair_case = RepairCase.find(params[:id])
  end

  def update
    @repair_case = RepairCase.find(params[:id])
    @repair_case.update(repair_case_params)
  end

  def destroy
    @repair_case = RepairCase.find(params[:id])
    @repair_case.destroy
  end

  private

  def case_params
    params.require(:repair_case).permit(:title, :description, :status)
  end
end
class JobsController < ApplicationController
  before_action :authenticated?
  before_action :own_job?, only: %i[ show update destroy ]

  def index
    @jobs = @user.jobs
    render json: JobSerializer.new(@jobs)
  end

  def show
    render json: JobSerializer.new(@job)
  end

  def create
    @job = Job.new(job_params)
    @job.user = @user
    if @job.save
      render json: JobSerializer.new(@job), status: :created
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  def update
    if @job.update(job_params)
      render json: JobSerializer.new(@job)
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @job.destroy
    render json: {message: "Job was successfully destroyed."}
  end

  private

  #explicit bool returns since this method is evaluated in own_job?
  def set_job
    @job = Job.find_by(id: params[:id])
    if !@job
      render json: {message: "not found"}, status: :not_found
      false
    else
      true
    end
  end

  def own_job?
    if set_job
      if current_user != @job.user
        render json: {message: "You are not authorized to access jobs that you did not create"}, status: :forbidden
      end
    end
  end

  def job_params
    params.require(:job).permit(:title, :job_type, :company, :location, :is_remote, :status, :posting_url, :logo_url, :date_posted, :description, :user_id, :contact_id)
  end
end

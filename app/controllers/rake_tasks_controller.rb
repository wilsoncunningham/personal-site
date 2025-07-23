class RakeTasksController < ApplicationController
  http_basic_authenticate_with name: ENV.fetch("RAKE_TASK_USERNAME"), password: ENV.fetch("RAKE_TASK_PASSWORD")

  require "rake"
  Rails.application.load_tasks

  def show
    render({ :template => "rake_tasks/show" })
  end

  def run_task
    task_name = params[:task] || "notebook:seed_sample"

    # Re-enable the task if it has already been executed
    Rake::Task[task_name].reenable

    # Run the specified rake task
    Rake::Task[task_name].invoke

    redirect_to("/rake_tasks", notice: "Rake task '#{task_name}' has been run.")
  rescue RuntimeError => e
    redirect_to("/rake_tasks", alert: "Failed to run task: #{e.message}")
  end
end

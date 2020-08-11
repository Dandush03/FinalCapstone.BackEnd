# frozen_string_literal: true

module Api
  # Api Task Controller
  class TasksController < ApplicationController
    def index
      tasks = current_user.tasks.order('start DESC').all
      remove_values = %i[created_at updated_at user_id]
      render json: tasks.except(remove_values), status: :ok
    end

    def create
      search_active = current_user.tasks.where(end: nil).first
      task = current_user.tasks.new(permitted_create_params)
      task.save if search_active.nil?
      render json: nil, status: :ok
    end

    def update
      task = current_user.tasks.find(params[:id])
      task.end = Time.at(permitted_update_params[:end].to_i / 1000)
      task.save
    end

    def search_by_category
      tasks = current_user.tasks.where(search_params_scope)
      remove_values = %i[created_at updated_at user_id]
      puts 'tests'
      puts 'tests'
      puts 'tests'
      puts 'tests'
      puts 'tests'
      puts 'tests'
      puts 'tests'
      render json: tasks.except(remove_values), status: :ok
    end

    def searcher
      tasks = current_user.tasks.where(end: nil).first
      render json: tasks, status: :ok
    end

    private

    def permitted_update_params
      att_update = %i[end]
      params.require(:task).permit(att_update)
    end

    def search_params_scope
      range = case params[:range].to_i
              when 7 then Date.today.all_week
              when 30 then Date.today.all_month
              else Time.now.all_day
              end
      { start: range, category_id: params[:category_id] }
    end

    def permitted_create_params
      att_create = %i[name description category_id]
      params.require(:tasks).permit(att_create)
    end
  end
end

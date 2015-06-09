class TodosController < ApplicationController
  def index
    all_todos = Todo.all
     respond_to do |format|
      format.html do
        render 'index.html.erb', locals: { todos: all_todos }
      end
      format.json do
        render json: all_todos
      end
    end
  end

  def show
    begin
      found_todo = Todo.find(params[:id])
      respond_to do |format|
        format.html do
          render 'show.html.erb', locals: { todo: found_todo }
        end
        format.json do
          render json: found_todo
        end
      end
    rescue ActiveRecord::RecordNotFound => error
    render json: { error: error.message }, status: 404

    rescue StandardError => error
    render json: { error: error.message }, status: 422
    end
  end

  def get_completed
    complete_todos = Todo.where(complete: true)
    respond_to do |format|
      format.html do
        render 'complete.html.erb', locals: { complete_todo: complete_todos }
      end
      format.json do
        render json: complete_todo
      end
    end
  end

def get_uncompleted
  uncomplete_todos = Todo.where(complete: false)
    respond_to do |format|
      format.html do
        render 'uncomplete.html.erb', locals: { uncomplete_todo: uncomplete_todos }
      end
      format.json do
        render json: uncomplete_todo
      end
    end
end

  # def new
  #   render json: "There is nothing here."
  # end

  # def create
  #   begin
  #     todo = Todo.create(todo: params[:todo])
  #     render json: todo
  #     rescue ActionController::ParameterMissing => error
  #     render json: { error: error.message }, status: 422
  #   end
  # end

  def destroy
    if Todo.exists?(params[:id])
      deleted_todo = Todo.destroy(params[:id])
      respond_to do |format|
        format.html do
          render 'index.html.erb', locals: { todos: Todo.all }
        end
        format.json do
          render json: deleted_todo
        end
      end

    else
      render json: { error: 'Todo not found' }, status: 404
    end
  end

  # def update
  #   todo = Todo.find(params[:id])
  #   todo.todo = params[:todo] if params[:todo].present?
  #   todo.complete      = params[:complete ]      if params[:complete ].present?
  #   todo.save

  #   render json: todo
  # end

end

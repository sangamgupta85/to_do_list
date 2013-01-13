class TodosController < ApplicationController
  skip_before_filter :verify_authenticity_token
  # GET /todos
  # GET /todos.json
  
  def toggle_check
  item = Todo.find(params["id"])

  # change the done flag.  ActiveRecord
  # will automatically do the boolean/int
  # conversion.  
  item.done = !item.done?

  if item.save
    redirect_to(:action => "list")
  else
    render :text => "Couldn't update item" 
  end
end
  
  def add_item 
  item = Todo.new  # Create a new instance of Todo, so create a new item
  item.attributes = params["new_item"]  # The fields of item should be set to what's in the "new_item" hash
  item.attributes = params["item"]
  if item.save  # Try to save our item into the database
    redirect_to(:action => "list")  # Return to the list page if it suceeds
  else
    render :text => "Couldn't add new item"  # Print an error message otherwise
  end
 end
  
  
  def list
   redirect_to log_in_path unless session[:user_id]
   @not_done = Todo.find_not_done
   @done = Todo.find_done
  end
  
  def index
    @todos = Todo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @todos }
    end
  end

  # GET /todos/1
  # GET /todos/1.json
  def show
    @todo = Todo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @todo }
    end
  end

  # GET /todos/new
  # GET /todos/new.json
  def new
    @todo = Todo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @todo }
    end
  end

  # GET /todos/1/edit
  def edit
    @todo = Todo.find(params[:id])
  end
  
  # PUT /todos/1
  # PUT /todos/1.json
  def update
    @todo = Todo.find(params[:id])

    respond_to do |format|
      if @todo.update_attributes(params[:todo])
        format.html { redirect_to @todo, notice: 'Todo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.json
  def destroy
    item = Todo.find(params["id"])
  begin
    item.destroy
    redirect_to(:action => "list")
  rescue ActiveRecord::ActiveRecordError
    render :text => "Couldn't destroy item" 
  end
 end
end

class ReminderController < ApplicationController
   
   # GET /posts
  # GET /posts.xml
  def index
    if !session[:user_id]
        flash[:error] = "You are not a valid user. Please Login to continue."
        redirect_to "/home"
    else
        #@reminder.uid = session[:user_id]
        #@reminder = Reminder.find_by_sql("Select * from reminders where user_id = 3")
        #@reminder = Reminder.all
        #@reminder.uid = session[:user_id]
        
        @show_header = true
        @show_footer = true
        
        @reminder = Reminder.find(:all,:conditions => ["user_id = ?",session[:user_id]])
    
        respond_to do |format|
          format.html # index.html.erb
          format.xml  { render :xml => @reminder }
        end
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    if !session[:user_id]
      flash[:error] = "You are not a valid user. Please Login to continue."
      redirect_to "/home"
    else
      
      @show_header = true
      @show_footer = true
      @reminder = Reminder.find(params[:id])
  
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @reminder }
      end
    end    
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    if !session[:user_id]
      flash[:error] = "You are not a valid user. Please Login to continue."
      redirect_to "/home"
    else
      @show_header = true
      @show_footer = true
      @reminder = Reminder.new  
     # @start_date = Date.civil(params[:range][:"start_date(1i)"].to_i,params[:range][:"start_date(2i)"].to_i,params[:range][:"start_date(3i)"].to_i)
      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @reminder }
      end
    end
  end

  # GET /posts/1/edit
  def edit
    if !session[:user_id]
      flash[:error] = "You are not a valid user. Please Login to continue."
      redirect_to "/home"
    else
      @show_header = true
      @show_footer = true
      @reminder = Reminder.find(params[:id])
    end    
  end

  # POST /posts
  # POST /posts.xml
  def create
    if !session[:user_id]
      flash[:error] = "You are not a valid user. Please Login to continue."
      redirect_to "/home"
    else
      ##Experiment
#      reminder.transaction do # start transaction. any AR class would do, it applies to the connection
#        @reminder = Reminder.new(params[:reminder])
#        @reminder.uid = @session["user_id"]
#      end # end transaction
      
      @reminder = Reminder.new(params[:reminder])
      @reminder.user_id = session[:user_id]
  
      respond_to do |format|
        if @reminder.save
          flash[:notice] = 'Reminder was successfully created.'
          format.html { redirect_to(@reminder) }
          format.xml  { render :xml => @reminder, :status => :created, :location => @reminder }
        else
          @show_header = true
          @show_footer = true
          format.html { render :action => "new" }
          format.xml  { render :xml => @reminder.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    if !session[:user_id]
      flash[:error] = "You are not a valid user. Please Login to continue."
      redirect_to "/home"
    else
        @reminder = Reminder.find(params[:id])
    
        respond_to do |format|
          if @reminder.update_attributes(params[:reminder])
            flash[:notice] = "Reminder was successfully updated."
            format.html { redirect_to(@reminder) }
            format.xml  { head :ok }
          else
            format.html { render :action => "edit" }
            format.xml  { render :xml => @reminder.errors, :status => :unprocessable_entity }
          end
        end
     end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    if !session[:user_id]
      flash[:notice] = "You are not a valid user. Please Login to continue."
      redirect_to "/home"
    else
        @reminder = Reminder.find(params[:id])
        @reminder.destroy
    
        respond_to do |format|
          flash[:notice] = "Reminder was successfully deleted"
          format.html { redirect_to "/reminder" }
          format.xml  { head :ok }
        end
      end
   end    
end

class UserController < ApplicationController
  
  def login  
  end

  def signup
    @show_header = true
    @show_footer = true
  end

  def register
    @user = User.new
    respond_to do |format|
      format.html # signup.html.erb
      format.xml  { render :xml => @user }
    end
  end
  
  ### For Signup ###
  def create
    @user = User.new(params[:user])

    #respond_to do |format|
      if @user.save && simple_captcha_valid?
        flash[:notice] = "Thank you for registering for our AndolaSoft eReminder Service"
        redirect_to "/home"
        #format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        #format.html { render :action => "signup" }
        #format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
        flash[:error] = "Invalid Entry"
        redirect_to :action=> 'signup'
      end
    #end
  end
  

  def private
     if !session[:user_id]
        flash[:notice] = "Your session is Expired, Please Login to continue"
        redirect_to "/home"
    end
    @show_header = true
    @show_footer = true
  end
  
  def authenticate    
    #User.new(params[:userform]) will create a new object of User, retrieve values from the form and store it variable @user.
    @user = User.new(params[:userform])
        #find records with username,password
    valid_user = User.find(:first,:conditions => ["user_id = ? and password = ?",@user.user_name, @user.password])

        #if statement checks whether valid_user exists or not
    if valid_user
        #creates a session with username
      session[:user_name]=valid_user.user_name
      session[:user_id]=valid_user.id
        #redirects the user to our private page.
      redirect_to :action => 'private'
    else
      flash[:error] = "Username and password do not match!"
      redirect_to :controller => 'home', :action=> 'index'
    end
  end
  
  def logout
    if session[:user_id]
      reset_session
      flash[:notice] = "You have successfully logged out"
      redirect_to "/"
    end  
  end
  
end

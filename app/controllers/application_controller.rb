class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :all_categories
  helper_method :recent_posts
  helper_method :popular_tags

  before_filter :site_search

  def site_search
    @q = Post.ransack(params[:q])
    @q_posts = @q.result(distinct:true).order("created_at DESC")
  end 

  def all_categories
  	@categories = Category.all
  end

  def popular_tags
    ActsAsTaggableOn::Tag.most_used(10)
  end

  def recent_posts
  	@posts = Post.all.order("created_at DESC").limit(10)
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :name, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :current_password) }
  end
end

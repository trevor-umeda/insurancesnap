module ApplicationHelper
 def deny_access
  redirect_to new_user_session_path, :notice => "Please sign in to access this page."
  end
end

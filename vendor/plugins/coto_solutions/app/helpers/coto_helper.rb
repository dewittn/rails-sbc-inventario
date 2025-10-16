module CotoHelper
  ## Default App Helpers ##
  def page_title(title=APP_CONFIG['page_title'])
    content_for(:title) { title }
  end
  
  def app_title(title=APP_CONFIG['app_title'])
    content_for(:app_title) { title }
  end
  
  def defualt_title
   APP_CONFIG['page_title']
  end
  
   #Renders button 1 on left of Home button
   def button_1(text,path,options={})
     content_for(:button1) do
       content_tag(:td, link_to(content_tag(:div, content_tag(:center, text), class: 'three'), path, options))
       end
     end

   #Renders button 2 on right of Home button
   def button_2(text,path,options={})
     content_for(:button2) do
       content_tag(:td, link_to(content_tag(:div, content_tag(:center, text), class: 'three'), path, options))
       end
     end

   #Generates links across left side of top bar
   def create_top_links(*controllers)
     controllers.each do |controller|
       content_for :top_link do
          if params[:controller] == controller.downcase
            content_tag(:b, controller.titlecase) + raw("&nbsp;")
          else
            link_to(controller.titlecase, url_for(:controller => controller.downcase, :action => 'index')) + raw("&nbsp;")
          end
        end
     end
   end

   #Create Logout on right side of top bar
   def create_logout
     if logged_in?
       content_for :logout do
         link_to "Logout", logout_path
       end
     else
       content_for :logout do
         link_to "Login", login_path
       end
    end
   end 
   
   def javascripts(*file)
    content_for :javascripts do
      javascript_include_tag file
    end
   end
   
   def stylesheets(*file)
     content_for :stylesheets do
       stylesheet_link_tag file
     end
   end
   
   #Creates searchable dropdowns from array of tables
   def searchables(*tables)
     Searchable.new(tables,self).selectors_for_search
   end
   ## End default App helpers ##
end
class Spree::Admin::UploadsController < Spree::Admin::ResourceController
  
	def index
	  render :template => "spree/admin/uploads/#{request.xhr? ? 'picker' : 'index'}", :layout => !request.xhr?
  end
  
  private
  
    def collection
      params[:q] ||= {}
      params[:q][:sort] ||= "created_at.desc"
      @search = Spree::PageImage.search(params[:q])
      @collection = @search.result.page(params[:page]).per(Spree::Config[:orders_per_page])
      #@collection = Spree::PageImage.all
    end

end

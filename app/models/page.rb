class Page < ActiveRecord::Base
  
  validates_presence_of :title, :path
  validates_uniqueness_of :path
  
  scope :active, where(:accessible => true)
  scope :visible, active.where(:visible => true)
  
  has_many :contents, :dependent => :destroy
  
  before_validation :set_defaults
  
  def self.find_by_path(_path)
    super("/" + _path.sub(/^\//, ''))
  end
  
  def to_param
    path.sub(/^\//, '')
  end
  
  private
  
    def set_defaults
      self.nav_title = title if nav_title.blank?
      self.path = nav_title.parameterize if path.blank?
      self.path = "/" + path.sub(/^\//, '')
    end
  		
end
  
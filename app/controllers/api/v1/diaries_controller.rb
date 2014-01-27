class Api::V1::DiariesController < Api::V1::BaseController
  before_filter :find_child_profile, :only => [:index, :show, :update,:destroy, :create]
  #before_filter :verify_token , :only => [:index, :show, :update,:destroy, :create]
  respond_to :json

  def index
    @diaries = @child_profile.diaries
    if @diaries.empty?
      render json:{:status => false, :message => "Child not found for this id"}
    end
  end
  #
  def show
    begin
      @diary = Diary.find(params[:id])
        # render json:@logbook.to_json
    rescue ActiveRecord::RecordNotFound
      render json:{:status => false, :message => "Unable to find log_record on cloud"}
    end
  end

  def create
    @diary = @child_profile.diaries.create(params[:diary])
    create_pictures(params) if params[:filescount] > 0
    if @diary.valid?
      render json:{:status => true, :logid => @diary.id}
    else
      render json:{:status => false, :message => @diary.errors.full_messages }
    end
  end

  #def update
  #  @diary = Diary.find(params[:id])
  #
  #  respond_to do |format|
  #    if @diary.update_attributes(diary_params)
  #      format.html { redirect_to @diary, notice: 'Diary was successfully updated.' }
  #      format.json { head :no_content }
  #    else
  #      format.html { render action: "edit" }
  #      format.json { render json: @diary.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  def destroy
    @diary = Diary.find(params[:id])
    if @diary.destroy
      render json:{:status => true}
    else
      render json:{:status => false, :message => "Unable to destroy diary on cloud"}
    end
  end

  #private
  # def diary_params
  #    params.require(:diary).permit(:diary)
  # end

  def create_pictures(params)
    for i in 1..params[:filescount]
      unless params["file{i}".to_sym].empty?
        tempfile = Tempfile.new("fileupload")
        tempfile.binmode
        tempfile.write(Base64.decode64(params["file{i}".to_sym]) )
        uploaded_file = ActionDispatch::Http::UploadedFile.new(:tempfile => tempfile, :filename =>'image.png', :original_filename => 'old',:content_type=>"image/jpeg")
        @picture = @child_profile.diaries.pictures.create(:image=>uploaded_file)
        #todo add validation if unable to create picture record
        #todo return picture id hash for updation of each picture
      end
    end
  end

  def update_pictures
     #get all picture ids then update on basis of that
  end
  private

  def find_child_profile
    @child_profile = ChildProfile.find(params[:children_id])
  rescue ActiveRecord::RecordNotFound
    render json:{:status => false, :message => "Unable to find child profile on cloud"}
  end

  #def verify_token
  #  authtoken = request.headers['authtoken']
  #  @parent_profile = ParentProfile.find(params[:profile_id])
  #  raise  if @parent_profile.authtoken != authtoken
  #rescue Exception => e
  #  render json:{:status => false, :message => "Auth token not verified"}
  #end

end
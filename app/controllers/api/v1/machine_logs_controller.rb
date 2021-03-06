class Api::V1::MachineLogsController < Api::V1::BaseController

  def create
    #message=["TIMEOUT_TEMP","LIMIT_CLEAN_NUMBER","LIMIT_CLEAN_TIME","TEMP_CLEAN","DELAY_TEMP_CLEAN","WATER_CLEAN_TIME"]
    #mess = []
    #2.times do |i|
    #  mess << message.sample
    #end
    @machine = Machine.where(:serialid => params[:serialid]).first
    @parent_profile = ParentProfile.find_all_by_machine_id(@machine.id)
    if @machine.nil?
      render json:{:status => false, :message => "please provide valid serialid " }
    else
      @machine_log = MachineLog.create(:machine_id => @machine.id, :data => params[:data])
      #puts "the message is #{I18n.t('128')}"
      if @machine_log.valid?

        @parent_profile.each do |parent|
          I18n.locale = parent.lang.to_sym
          data=I18n.t(@machine_log.log_type)
        if parent.devicetypeid==0
            MachineLog.iphone_notifications(parent.tokenid,data)
        elsif parent.devicetypeid==1
            MachineLog.android_notifications(parent.tokenid,data)
        end
          I18n.locale = :en.to_sym
        end

        render json:{:status => true}
      else
        render json:{:status => false, :message => @machine_log.errors.full_messages }
      end
    end
  end

end
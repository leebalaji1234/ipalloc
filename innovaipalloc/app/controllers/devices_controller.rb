class DevicesController < ApplicationController
  def index
   
  	if ENV['IPALLOC_DATAPATH']
      testRes = `grep -w #{params[:ip]} #{ENV['IPALLOC_DATAPATH']}  && echo  || echo "no"`.strip
      if (testRes != "no")
        ipArr = testRes.split(",")
        userRes = {}
        userRes['device'] = ipArr[2]
        userRes['ip'] = params[:ip]
        render :json => userRes, status: :ok
      else
        userRes = {}
        userRes['error'] = "NotFound"
        userRes['ip'] = params[:ip]
        render :json => userRes, status: :not_found
      end

  	else
  		 render :text => "ERROR:Set \"IPALLOC_DATAPATH\" environment variable on your system"
  	end
  end

end

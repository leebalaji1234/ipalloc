class AddressesController < ActionController::Base
  def assign
  	if (params[:ip] && params[:device])
  		if(ipvalidate(params[:ip]) == false)
  			userRes = {}
  			userRes['error'] = "OutOfRangeAddress"
  			userRes['ip'] = params[:ip]
  			userRes['device'] = params[:device]
  			render :json => userRes, status: :bad_request  	 				 		 
  		else
  			# assign ip to the file
  			testRes = `grep -q #{params[:ip]} #{ENV['IPALLOC_DATAPATH']}  && echo "yes" || echo "no"`.strip
  			if (testRes == "yes")
  				userRes = {}
  				userRes['error'] = "AddressExist"
	  			userRes['ip'] = params[:ip]
	  			userRes['device'] = params[:device]
	  			render :json => userRes, status: :bad_request
  			else
	  			strTowrite = "1.2.0.0/16,#{params[:ip]},#{params[:device]}"
	  			res = `echo "#{strTowrite}\n" >> #{ENV['IPALLOC_DATAPATH']}`
	  			userRes = {}
	  			userRes['ip'] = params[:ip]
	  			userRes['device'] = params[:device]
	  			render :json => userRes, status: :created  		 
  		    end
  		end
  	end

  end
  def ipvalidate(ipset)
  	ipArr = ipset.split(".")
  	# ipv4 block validation and length count
   	if ((ipArr[0].to_i != 1 && ipArr[1] != 2) ||  (ipArr.count !=4))
	   return false
	else
		return true
	end
  end
   

end

json.set! :status ,true
json.set! :status_code, 4004
json.set! :message,"Child found"
json.child do
     json.set! :id, @child_profile.id
     json.set! :name, @child_profile.name
     json.set! :dob, @child_profile.dob
     json.set! :gender, @child_profile.gender
     json.set! :filepath, request.protocol + request.host_with_port + @picture.image_url

end
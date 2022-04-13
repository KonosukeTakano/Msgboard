class MsgboardController < ApplicationController
  layout 'msgboard'

  def initialize
    super
    begin
      @msg_data = JSON.parse(File.read("data.txt"))
    rescue
      @msg_data = Hash.new
    end
    @msg_data.each do |key,obj|
      if Time.now.to_i - key.to_i > 24*60*60 then
        @msg_data.delete(key)
      end
    end
    File.write("data.txt", @msg_data.to_json)
  end

  def index
    if request.post? then
      obj = MyData.new(msg:params['msg'],name:params['name'])
      @msg_data[Time.now.to_i] = obj
      data = @msg_data.to_json
      File.write("data.txt",data)
      @msg_data = JSON.parse(data)
    end
  end
end

class MyData
  attr_accessor :name
  attr_accessor :msg

  def initialize msg:msg(), name:name()
    self.name = name
    self.msg = msg
  end
end
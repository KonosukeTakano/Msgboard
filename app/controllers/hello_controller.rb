class HelloController < ApplicationController
    layout 'hello'

    def index
        @header = 'layout sample'
        @footer = 'Konosuke Takano'
        @title = 'New Layout'
        @msg = 'this is sample page!'
    end

end
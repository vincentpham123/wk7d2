class BandsController < ApplicationController
    
    before_action :set_band, only: [:show,:edit,:destroy, :create]
    def index
        @bands = Band.all 
    end

    def show 
        @band 
    end

    def edit 
        @band 
    end

    def new 
    end

    def create
        @band = Band.new(band_params)
        if @band.save 
            redirect_to bands_url 
        else
            flash.now[:errors]=@band.errors.full_messages
            render :new 
        end
    end

    def update
        if @band.update(band_params)
            redirect_to bands_url 
        else
            flash.now[:errors]=@band.errors.full_messages
        end
    end

    def destroy 
        @band.destroy
        redirect_to bands_url 
    end
        

    private
    #show, edit, update, destroy
    def set_band
        @band = Band.find_by(id: params[:id])
    end


    def band_params
        params.require(:band).permit(:name)
    end
end

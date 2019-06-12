module Api
    module V1
        class TargetsController < ApplicationController

            before_action :authenticate_user!

            def index
                @targets = current_user.targets      
            end
                       

            def create    

                if current_user.targets.length <10
                    @target = current_user.targets.create!(target_params)                                             
                else
                    render json: {status: 'FAIL', message: 'Target maximum reached'}, status: :ok
                end
            end


            def destroy
                #@target.destroy
                @target= Target.find(params[:id])                
                @target.destroy
            end


            private
                def target_params
                    params.require(:target).permit(:title, :topic, :latitude, :longitude, :length) 
                end
            

        end
    end
end

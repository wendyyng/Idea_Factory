require 'rails_helper'

RSpec.describe IdeasController, type: :controller do
    describe "#new" do
        context "with signed in user" do
            before do
                session[:user_id] = FactoryBot.create(:user).id
            end
        
            it "requires a render of a new template" do
                #GIVEN

                #WHEN
                get(:new)

                #THEN
                expect(response).to(render_template(:new))
            end

            it "requires setting an instance variable with a new idea" do
                #GIVEN

                #WHEN
                get(:new)

                #THEN
                expect(assigns(:idea)).to(be_a_new(Idea))

            end
        end
    end


    describe "#create" do
        def valid_request
            post(:create, params: {
                idea: FactoryBot.attributes_for(:idea)
            })
        end

        context "with signed in user" do
            before do
                session[:user_id] = FactoryBot.create(:user).id
            end

            context "with valid parameters" do
            
                it "requires a new creation of idea in the database" do
                    #GIVEN
                    count_before = Idea.count 
        
                    #WHEN
                    valid_request
        
                    #THEN
                    count_after = Idea.count
                    expect(count_after).to(eq(count_before + 1))
                end
        
                it "requires a redirect to the show page for the new idea" do
                    #GIVEN
                    #we are creating a new idea
        
                    #WHEN
                    valid_request
        
                    #THEN
                    idea = Idea.last
                    expect(response).to(redirect_to(idea_path(idea.id)))
                end
        
            end

            context "with invalid parameters" do
                def invalid_request
                    post(:create, params: {
                        idea: FactoryBot.attributes_for(:idea, title:nil)
                    })
                end
    
                it "requires that the database does not save the new record of the idea" do
                    #GIVEN
                    count_before = Idea.count
    
                    #WHEN
                    invalid_request
    
                    #THEN
                    count_after = Idea.count
                    expect(count_after).to(eq(count_before)) 
                end
    
                it "requires no redirect and should render the new page" do
                    #GIVEN
    
                    #WHEN
                    invalid_request #invalid params given
    
                    #THEN
                    expect(response).to render_template(:new)
                end
            end
        end
        
        context "without signed in user" do
            it "should redirect to the root page" do
            valid_request
            expect(response).to redirect_to(root_path)
            end
        end

    end

end

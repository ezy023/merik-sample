class FrequentlyaskedquestionsController < ApplicationController
  def create
  	@faq = FrequentlyAskedQuestions.new(question: params[:question])
  	if @faq.save
  		flash[:success] = "Question submitted"
  		redirect_to :back
  	end
  end
end

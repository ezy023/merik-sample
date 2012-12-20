class FrequentlyaskedquestionsController < ApplicationController
  def create
  	@faq = FrequentlyAskedQuestions.new(question: params[:question])
  	if @faq.save
  		flash[:success] = "Thank you, we will answer this question ASAP"
  		redirect_to :back
  	end
  end
end

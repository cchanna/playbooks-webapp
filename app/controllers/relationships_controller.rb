class RelationshipsController < ApplicationController
  def new
    @character = Character.find(params[:character_id])
    @relationship = Relationship.new(character: @character)
    respond_to do |format|
      format.html {render :text => "", :layout => true}
      format.js
    end
  end

  def create
    trust_question = TrustQuestion.find(params[:relationship][:trust_question_id])
    @character = Character.find(params[:character_id])
    @relationship = Relationship.create(
      name: params[:relationship][:name],
      trust_question: trust_question,
      trust: trust_question.trust,
      character: @character
    )
    respond_to do |format|
      format.js
    end
    # respond_to do |format|
    #   format.html {render text: new_character_relationship_path(params[:character_id])}
    # end
  end

  def increment
    relationship = Relationship.find_by(id: params[:id])
    unless relationship.trust >= 3
      relationship.update(trust: relationship.trust + 1)
    end
    render partial: "value", locals: {relationship: relationship}
  end

  def decrement
    relationship = Relationship.find_by(id: params[:id])
    unless relationship.trust <= -3
      relationship.update(trust: relationship.trust - 1)
    end
    render partial: "value", locals: {relationship: relationship}
  end

  def destroy
    relationship = Relationship.find_by(id: params[:id])
    @character = relationship.character
    @question_id = relationship.trust_question.id
    relationship.destroy
    respond_to do |format|
      format.js
    end
  end
end

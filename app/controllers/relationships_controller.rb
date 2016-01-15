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
    @relationship = Relationship.create(
      name: params[:relationship][:name],
      trust_question: trust_question,
      trust: trust_question.trust,
      character_id: params[:character_id]
    )
    respond_to do |format|
      format.html {render text: new_character_relationship_path(params[:character_id])}
    end
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
end

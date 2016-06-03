class AddRunnerEmailToCompetitions < ActiveRecord::Migration
  def change
    add_column :competitions, :runner_email, :string
  end
end

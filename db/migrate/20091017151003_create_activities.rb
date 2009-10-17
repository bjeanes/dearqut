class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.references :target, :polymorphic => true
      t.references :user
      t.string     :action
    
      t.timestamps
    end
    
    add_index :activities, :user_id
    add_index :activities, :action
    add_index :activities, :target_type
    add_index :activities, :created_at
    
    targets = [:messages, :comments, :votes]
    
    User.all(:include => targets).each do |user|
      targets.each do |target|
        user.send(target).each do |t|
          user.activities.create(
            :target     => t, 
            :created_at => t.created_at,
            :action     => "created")
        end
      end
    end
  end

  def self.down
    drop_table :activities
  end
end

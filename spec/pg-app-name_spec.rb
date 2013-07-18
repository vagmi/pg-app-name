require 'pg-app-name'

connection_params = {adapter: 'postgresql', username: 'postgres', database: 'pg_app_name_test'}
connection_params['password'] = ENV['PG_PASS'] if ENV['PG_PASS']
ENV['PG_APP_NAME']="pgtest"

describe "Set PG App Name" do
  it "should monkey patch ActiveRecord::Base" do
    ActiveRecord::Base.respond_to?(:establish_connection_with_application_name).should be_true
  end

  it "should monkey patch ConnectionPool" do
    cp = ActiveRecord::ConnectionAdapters::ConnectionPool.new(ActiveRecord::ConnectionAdapters::ConnectionSpecification.new(connection_params,"postgresql_connection"))
    cp.respond_to?(:new_connection_with_application_name).should be_true
  end

  it "should set the application name while establishing connection" do
    ActiveRecord::Base.establish_connection connection_params
    result = ActiveRecord::Base.connection.exec_query "select application_name from pg_stat_activity where datname='"+connection_params[:database]+"'"
    result.rows.count.should == 1
    result.rows[0][0].should=="pgtest_without_pool"
    ActiveRecord::Base.connection.close
  end

  it "should set the application name while establishing connection with connection pool" do
    cp = ActiveRecord::ConnectionAdapters::ConnectionPool.new(ActiveRecord::ConnectionAdapters::ConnectionSpecification.new(connection_params,"postgresql_connection"))
    conn = cp.checkout
    result = conn.exec_query "select application_name from pg_stat_activity where datname='"+connection_params[:database]+"'"
    result.rows.flatten!
    result.rows.count.should == 2
    result.rows.index("pgtest_with_pool_1").should_not be_nil
    result.rows.index("pgtest_without_pool").should_not be_nil
    cp.disconnect!
  end
end

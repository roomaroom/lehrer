server '46.101.245.65', user: 'app', roles: %w{docker}

namespace :custom do
  task :setup_container do
    on roles(:docker) do |host|
        image_name = "lehrer" #we use this for container name also
        puts "================Starting Docker setup===================="
        execute "cp /home/app/database.yml #{deploy_to}/current/config/database.yml"
        execute "cp /home/app/secrets.yml #{deploy_to}/current/config/secrets.yml"
        execute "cd #{deploy_to}/current && docker build --rm=true --no-cache=false -t rockyj/#{image_name} ."
        execute "docker stop #{image_name}; echo 0"
        execute "docker rm -fv #{image_name}; echo 0"
        execute 'docker run -tid -p 80:80 -e "PASSENGER_APP_ENV=production" -e "RAILS_ENV=production" --name lehrer rockyj/lehrer'
        execute "docker exec -it lehrer bundle exec rake db:migrate"
    end
  end
end

after "deploy:finishing", "custom:setup_container"

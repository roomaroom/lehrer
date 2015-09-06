server '46.101.245.65', user: 'app', roles: %w{docker}

namespace :custom do
  task :setup_container do
    on roles(:docker) do |host|
        image_name = "lehrer" #we use this for container name also
        puts "================Starting Docker setup===================="
        execute "cd #{deploy_to}/current && docker build --rm=true --no-cache=false -t rockyj/#{image_name} ."
        execute "docker stop #{image_name}; echo 0"
        execute "docker rm -fv #{image_name}; echo 0"
        execute 'docker run -tid -p 80:80 -e "LEHRER_DATABASE_PASSWORD=udontcme" -e "SECRET_KEY_BASE=f8bb2bc6fdf8e12a897ed70481c8d330a13b8bbebca4aae726b1bbe8faac91f010cfc94e8f298c89a7fe0fd4ae1a365195cb9df6f78ac0e65bf45244efedad21" -e "PASSENGER_APP_ENV=production" -e "RAILS_ENV=production" --name lehrer rockyj/lehrer'
        execute "docker exec -it lehrer bundle exec rake db:migrate"
    end
  end
end

after "deploy:finishing", "custom:setup_container"

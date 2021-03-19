. ../blog-ledez-jekyll-source-twitter.sh

./scripts/new_draft.sh 'Terraform, Ansible et Consul sont dans un bateau'
./scripts/create_images_directory.sh
bundle exec jekyll server --config _config.yml,_config-dev.yml --draft
bundle exec jekyll server --config _config.yml,_config-dev.yml --draft --incremental
bundle exec jekyll server --config _config.yml,_config-dev.yml

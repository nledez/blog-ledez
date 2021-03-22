# Update
vi ./scripts/jekyll_envs.sh
./scripts/jekyll_update.sh

# Create post
./scripts/new_draft.sh 'Terraform, Ansible et Consul sont dans un bateau'
./scripts/create_images_directory.sh

./scripts/jekyll_launch_dev.sh

./scripts/publish_draft.sh

./scripts/jekyll_build_staging.sh
./scripts/jekyll_build_prod.sh

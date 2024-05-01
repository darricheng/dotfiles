function take -d "mkdir then cd"
  set -l new_dir_name $argv[1]
  mkdir new_dir_name
  cd new_dir_name
end

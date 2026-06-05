function git_clone_new_worktree_ssh_git_url -d "clones a new repository into a directory with git worktree set up using the ssh git url"
    # An argument must be present
    if test (count $argv) -lt 1
        echo "Error: Please provide a Git URL (e.g., git@github.com:owner/repo.git)"
        return 1
    end

    echo "Creating project directory: $folder_name"
    set -l git_url $argv[1]
    set -l folder_name (string match -r ".*/(.+).git" -g $git_url)
    mkdir -p $folder_name
    cd $folder_name

    echo "Cloning core repository data"
    if not git clone --bare $git_url .bare --depth=2
        echo "Error: something went wrong while cloning repository."
        cd ..
        return 1
    end

    echo "Configuring worktree"
    echo "gitdir: ./.bare" >.git
    git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
    git worktree add main

    echo "Set up complete."
    cd main
end
